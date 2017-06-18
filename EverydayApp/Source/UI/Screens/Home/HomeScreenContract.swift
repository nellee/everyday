//
//  HomeScreenContract.swift
//  EverydayApp
//
//  Created by Danijel on 10/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenContract: BaseScreenContract<HomeViewController> {
    
    typealias View = HomeViewProtocol
    typealias Presenter = HomePresenterProtocol
    
    override var storyboard: AppStoryboards {
        return .Home
    }
    
}

protocol HomeViewProtocol: class, BaseViewProtocol {
    
}

protocol HomePresenterProtocol: class {
    func openMoviesScreen()
    func openPhotoEditorScreen()
}
