//
//  BaseViewController.swift
//  EverydayApp
//
//  Created by Danijel on 10/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}

extension UIColor {
    func maxBright() -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            let d:CGFloat = 1.0 - max(r,g,b)
            return UIColor(red: r + d, green: g + d , blue: b + d, alpha: 1.0)
            
        }
        return self
    }
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default
            .addObserver(self, selector: #selector(BaseViewController.showInternetConnectionErrorAlert),
                         name: NSNotification.Name(rawValue: internetConnectionError), object: nil)
        
        self.title = self.navigationTitle()
        
        initNavigationBar()
    }
    
    //MARK: - Navigation bar title methods
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        if let navButtons = self.navigationController?.navigationBar.items {
            if navButtons.count > 0 {
                navButtons[0].title = ""
            }
        }
        self.navigationItem.rightBarButtonItems = rightNavigationButtonItems()
    }
    
    //override to set navigation title
    func navigationTitle() -> String {
        return "Everyday"
    }
    
    func rightNavigationButtonItems() -> [UIBarButtonItem] {
        return []
    }

    func showInternetConnectionErrorAlert() {
        showAlert(title:"no_internet_connectivity", completion: { _ in })
    }
    
    // MARK: - Alert and Activity indicator methods
    func showAlert(title: String = "", message: String = "", completion: @escaping (UIAlertAction) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        present(alertController, animated: true, completion: nil)
        
        //KVC
        let titleFont = UIFont.systemFont(ofSize: 18)
        let textFont = UIFont.systemFont(ofSize: 15)
        
        let titleAttributed = NSMutableAttributedString(string: alertController.title!,
                                                        attributes: [NSFontAttributeName: titleFont])
        
        let messageAttributed = NSMutableAttributedString(string: alertController.message!,
                                                          attributes: [NSFontAttributeName: textFont])
        
        alertController.setValue(titleAttributed, forKey: "attributedTitle")
        alertController.setValue(messageAttributed, forKey: "attributedMessage")
    }
    
    //TESTING
    deinit {
        print("deinit -> " + self.className)
    }
    
}
