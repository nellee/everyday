//
//  HomeViewController.swift
//  EverydayApp
//
//  Created by Danijel on 10/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    //MARK: - Member properties
    var presenter: HomeScreenContract.Presenter!
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomeScreenPresenter(view: self)
    }
    
    //MARK: - @IBAcions methods
    @IBAction func moviesButtonClicked(_ sender: Any) {
        presenter.openMoviesScreen()
    }

    @IBAction func footballButtonClicked(_ sender: Any) {
    }
    
    @IBAction func photoEditorButtonClicked(_ sender: Any) {
        presenter.openPhotoEditorScreen()
    }

    @IBAction func newsButtonClicked(_ sender: Any) {
    }
    
    @IBAction func notesButtonClicked(_ sender: Any) {
    }
    
    @IBAction func oneSignalInboxClicked(_ sender: Any) {
    }
    
    @IBAction func aboutDeveloperHTMLClicked(_ sender: Any) {
    }
    
    @IBAction func aboutDeveloperPDFClicked(_ sender: Any) {
    }
}

//MARK: - HomeScreenContract.View methods
extension HomeViewController: HomeScreenContract.View {
    
}
