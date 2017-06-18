//
//  BaseScreenContract.swift
//  EverydayApp
//
//  Created by Danijel on 10/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class BaseScreenContract<T> {
    
    required init() {}
    
    var storyboard: AppStoryboards {
        return .Base
    }

    var viewControllerStoryboardId: String {
        return String(describing: T.self)
    }
    
    var animated: Bool {
        return false
    }
    
    func configureViewController(viewController: UIViewController?) {
        //Override in corresponding child class
    }
    
    func instantiateViewController () -> UIViewController? {
        let sb = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: viewControllerStoryboardId)
        self.configureViewController(viewController: vc)
        return vc
    }
    
    func push(navigationController: UINavigationController?) {
        if let vc = self.instantiateViewController() {
            if let viewControllerFromStack = getViewControllerFromNavigation(viewController: vc, navigationController: navigationController!) {
                navigationController!.popToViewController(viewControllerFromStack, animated: true)
                return
            }
            navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func pushIgnoreStack(navigationController: UINavigationController?) {
        if let vc = self.instantiateViewController() {
            navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func present(presentingViewController: UIViewController) {
        if let vc = self.instantiateViewController() {
            presentingViewController.present(vc, animated: animated, completion: nil)
        }
    }
    
    func presentModal(presentingViewController: UIViewController?) -> UIViewController? {
        if let vc = self.instantiateViewController(), let presentingViewController = presentingViewController {
            vc.modalPresentationStyle = .overCurrentContext
            presentingViewController.present(vc, animated: animated, completion: nil)
            return vc
        }
        
        return nil
    }
    
    func getViewControllerFromNavigation (viewController: UIViewController, navigationController: UINavigationController) -> UIViewController? {
        for vc in navigationController.viewControllers {
            if vc.classForCoder == viewController.classForCoder {
                return vc
            }
        }
        return nil
    }
    
}
