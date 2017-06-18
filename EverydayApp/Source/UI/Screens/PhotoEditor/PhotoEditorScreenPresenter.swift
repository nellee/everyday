//
//  PhotoEditorScreenPresenter.swift
//  EverydayApp
//
//  Created by Danijel on 17/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class PhotoEditorScreenPresenter {
    
    var view: PhotoEditorScreenContract.View!
    
    var filterNames: [String]?
    
    init(view: PhotoEditorScreenContract.View) {
        self.view = view
        
        view.showPhotoChooserAler()
    }
    
    func getFilterNames() -> [String] {
        return [
            "Original",
            "CILinearToSRGBToneCurve",
            "CIPhotoEffectChrome",
            "CIPhotoEffectFade",
            "CIPhotoEffectInstant",
            "CIPhotoEffectMono",
            "CIPhotoEffectNoir",
            "CIPhotoEffectProcess",
            "CIPhotoEffectTonal",
            "CIPhotoEffectTransfer",
            "CISRGBToneCurveToLinear",
            "CIVignette",
            "CISepiaTone",
        ]
    }
    
    func getStickersNames() -> [String] {
        return [
            "Rock",
            "Nirvana",
            "Mustache",
            "Beer"
        ]
    }
    
    func getFramesNames() -> [String] {
        return [
            "frame1",
            "frame2",
            "frame3",
            "frame4"
        ]
    }
    
}

extension PhotoEditorScreenPresenter: PhotoEditorScreenContract.Presenter {
    
    func getCurrentStateArray(editorState: PhotoEditorViewController.EditorState) -> [String] {
        switch editorState {
        case .filters:
            return getFilterNames()
        case .stickers:
            return getStickersNames()
        case .frames:
            return getFramesNames()
        }
    }
    
    func saveImageToLibrary(image: UIImage?) {
        guard let safeImage = image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(safeImage, nil, nil, nil)
        view.finishSavingImage()
    }
    
}
