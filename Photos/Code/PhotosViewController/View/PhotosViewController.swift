//
//  ViewController.swift
//  Photos
//
//  Created by Kanan`s Macbook Pro on 11/30/21.
//

import UIKit
import RxSwift
import RxCocoa
import SimpleImageViewer

class PhotosViewController: UIViewController, Storyboarded {
    // MARK: - Variables
    private var viewModel: PhotoListViewModel!
    private let disposeBag = DisposeBag()
    private var cachedImages: [Int: UIImage] = [:]
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Main methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupViewModel()
    }
}

// MARK: - Setup
extension PhotosViewController {
    // MARK: Setup UI
    private func setupUI() {
        setupCollectionView()

        self.view.backgroundColor = .white
    }
        
    private func setupCollectionView() {
        collectionView.register(PhotoCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = createCollectionViewLayout()
    }
    
    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = Dimensions.photosItemSize
        let numberOfCellsInRow = floor(Dimensions.screenWidth / Dimensions.photosItemSize.width)
        let inset = (Dimensions.screenWidth - (numberOfCellsInRow * Dimensions.photosItemSize.width)) / (numberOfCellsInRow + 1)
        layout.sectionInset = .init(top: inset,
                                    left: inset,
                                    bottom: inset,
                                    right: inset)
        return layout
    }
}

// MARK: - Setup ViewModel
extension PhotosViewController {
    private func setupViewModel() {
        viewModel = PhotoListViewModel()
        
        bindCollectionView()
        bindImageLoader()
    }
}

// MARK: - Bind ViewModel To UI
extension PhotosViewController {
    
    private func bindCollectionView() {
        // MARK: Bind photoList to collectionView
        viewModel.photoList
            .filter({ !$0.isEmpty })
            .bind(to: collectionView.rx
                    .items(cellIdentifier: PhotoCollectionViewCell.identifier,
                           cellType: PhotoCollectionViewCell.self)) { _, _, _ in}
            .disposed(by: disposeBag)
        
        // MARK: Bind willDisplayCell
        collectionView.rx.willDisplayCell
            .observeOn(MainScheduler.instance)
            .map({ ($0.cell as! PhotoCollectionViewCell, $0.at.item) })
            .subscribe { [weak self] cell, indexPath in
                guard let self = self else {return}
                if let cachedImage = self.cachedImages[indexPath] {
                    /// use image from cached images
                    cell.imageView.image = cachedImage
                } else {
                    /// start animation for download image
                    cell.activityIndicator.startAnimating()

                    /// download image
                    self.viewModel.loadImageFromGivenItem(with: indexPath)
                }
                
            }
            .disposed(by: disposeBag)
            
        // MARK: Bind selected model
        collectionView.rx.modelSelected(PhotoCollectionViewCell.self)
            .subscribe(onNext: { cell in
                let configuration = ImageViewerConfiguration { config in
                    config.imageView = cell.imageView
                }

                let imageViewerController = ImageViewerController(configuration: configuration)

                self.present(imageViewerController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    /// bind loaded image to cell
    private func bindImageLoader() {
        viewModel.imageDownloaded
            .observeOn(MainScheduler.instance)
            .filter({ $0.1 != nil })
            .map({ ($0.0, $0.1!) })
            .subscribe(onNext: { [unowned self] index, image in
                guard let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? PhotoCollectionViewCell else {
                    return
                }

                cell.animateCellWithImage(cell, image)

                self.cachedImages[index] = image
            })
            .disposed(by: disposeBag)
    }
}
