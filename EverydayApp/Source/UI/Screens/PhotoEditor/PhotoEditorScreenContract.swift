//
//  PhotoEditorScreenContract.swift
//  EverydayApp
//
//  Created by Danijel on 17/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class PhotoEditorScreenContract: BaseScreenContract<PhotoEditorViewController> {
    
    typealias View = PhotoEditorViewProtocol
    typealias Presenter = PhotoEditorPresenterProtocol

    override var storyboard: AppStoryboards {
        return .PhotoEditor
    }

}

protocol PhotoEditorViewProtocol: class, BaseViewProtocol {
    func showPhotoChooserAler()
    func finishSavingImage()
}

protocol PhotoEditorPresenterProtocol: class {
    func getCurrentStateArray(editorState: PhotoEditorViewController.EditorState) -> [String]
    func saveImageToLibrary(image: UIImage?)
}
