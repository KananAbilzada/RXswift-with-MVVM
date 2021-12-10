//
//  UIViewController+.swift
//  Photos
//
//  Created by Kanan Abilzada on 30.11.21.
//

import UIKit

extension UIViewController {
    func runInMainThread (completion: @escaping () -> ()) {
        DispatchQueue.main.async {
            completion()
        }
    }
    
}

// MARK : Add Child ViewControllers
extension UIViewController {
    
    func insertChildController(_ childController: UIViewController,
                               intoParentView parentView: UIView,
                               frame: CGRect) {
        childController.willMove(toParent: self)
        
        self.addChild(childController)
        childController.view.frame = frame
        parentView.addSubview(childController.view)
        
        childController.didMove(toParent: self)
    }
    
}

extension UIViewController {
    func delayAfter(_ seconds: Double,
                    completetion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completetion()
        }
    }
}
