//
//  UIViewController.extension.swift
//  EverydayApp
//
//  Created by Danijel on 10/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func startWithRootViewController<T: UIViewController>(storyboard: AppStoryboards, controller: T.Type) {
        guard let window = UIApplication.shared.delegate?.window! else {
            return
        }
        
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        if let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
            
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
}
