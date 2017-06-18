//
//  HomeScreenPresenter.swift
//  EverydayApp
//
//  Created by Danijel on 10/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation

class HomeScreenPresenter {
    
    weak var view: HomeScreenContract.View!
    
    required init(view: HomeScreenContract.View) {
        self.view = view
    }
}

//MARK: - HomeScreenPresenter protocol
extension HomeScreenPresenter: HomeScreenContract.Presenter {
    
    func openMoviesScreen() {
        MoviesScreenContract().push(navigationController: self.view.navigationController)
    }
    
    func openPhotoEditorScreen() {
        PhotoEditorScreenContract().push(navigationController: self.view.navigationController)
    }
    
}
