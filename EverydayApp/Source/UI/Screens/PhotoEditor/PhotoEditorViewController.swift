//
//  PhotoEditorViewController.swift
//  EverydayApp
//
//  Created by Danijel on 17/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class PhotoEditorViewController: BaseViewController, UINavigationControllerDelegate {
    
    enum EditorState {
        case filters
        case stickers
        case frames
    }
    
    @IBOutlet weak var photoEditorView: PhotoEditorView!
    
    @IBOutlet weak var footerViewContainer: UIView!
    
    @IBOutlet weak var footerButtonCointainer: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var presenter: PhotoEditorScreenContract.Presenter!
    var imagePicker: UIImagePickerController?
    
    var currentEditorState: EditorState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PhotoEditorScreenPresenter(view: self)
    }
    
    //MARK: - NavigationBar items setup
    override func navigationTitle() -> String {
        return "Photo Editor"
    }
    
    override func rightNavigationButtonItems() -> [UIBarButtonItem] {
        
        let saveBarButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveActionBarButton))
        
        return [saveBarButton]
    }
    
    func saveActionBarButton() {
        presenter.saveImageToLibrary(image: photoEditorView.getScreenShot())
    }
    
    func setupCollectionView() {
        collectionView.register(UINib(nibName: PhotoEditorCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: PhotoEditorCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: - @IBAction
    @IBAction func filterButtonClicked(_ sender: Any) {
        selectNewEditorState(newState: .filters)
    }
    @IBAction func stickerButtonClicked(_ sender: Any) {
        selectNewEditorState(newState: .stickers)
    }
    @IBAction func framesButtonClicked(_ sender: Any) {
        selectNewEditorState(newState: .frames)
    }
    
    func selectNewEditorState(newState: EditorState) {
        currentEditorState = newState
        
        self.collectionView.reloadData()

        UIView.animate(withDuration: 0.7) {
            self.collectionViewHeightConstraint.constant = self.footerViewContainer.frame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    func deselectEditorState() {
        currentEditorState = nil
        
        UIView.animate(withDuration: 0.7) { 
            self.collectionViewHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    
    }
    
}

extension PhotoEditorViewController: PhotoEditorScreenContract.View {
    
    func showPhotoChooserAler() {
        weak var weakSelf = self
        
        let actionSheetAlertController = UIAlertController(title: "Please select photo source!", message: nil, preferredStyle: .actionSheet)
        actionSheetAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            weakSelf!.navigationController?.popViewController(animated: true)
        })
        actionSheetAlertController.addAction(UIAlertAction(title: "Camera", style: .default) { (alertAction) in
            //open camera
            weakSelf!.imagePicker = UIImagePickerController()
            weakSelf!.imagePicker!.delegate = self
            weakSelf!.imagePicker!.sourceType = .camera
            weakSelf!.present(weakSelf!.imagePicker!, animated: true, completion: nil)
        })
        
        actionSheetAlertController.addAction(UIAlertAction(title: "Gallery", style: .default) { (alertAction) in
            //open photo gallery
            weakSelf!.imagePicker = UIImagePickerController()
            weakSelf!.imagePicker!.delegate = self
            weakSelf!.imagePicker!.sourceType = .photoLibrary
            weakSelf!.present(weakSelf!.imagePicker!, animated: true, completion: nil)
        })
        
        self.navigationController!.present(actionSheetAlertController, animated: true, completion: nil)
    }
    
    func finishSavingImage() {
        showAlert(title: "Saved!", message: "Edited photo is saved in photo library!", completion: { _ in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
}

extension PhotoEditorViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView.collectionViewLayout.invalidateLayout()
        guard let editorState = currentEditorState else {
            return 0
        }
        return presenter.getCurrentStateArray(editorState: editorState).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoEditorCollectionCell.identifier, for: indexPath) as! PhotoEditorCollectionCell
        
        guard let editorState = currentEditorState else {
            return cell
        }
        
        if let image = UIImage(named: presenter.getCurrentStateArray(editorState: editorState)[indexPath.row]) {
            cell.imageView.image = image
        } else {
            cell.titleLabel.text = presenter.getCurrentStateArray(editorState: editorState)[indexPath.row]
        }
        
        return cell
    }
    
}

extension PhotoEditorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.2, height: collectionView.frame.height)
    }
}

extension PhotoEditorViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let editorState = currentEditorState else {
            return
        }
        
        switch editorState {
        case .filters:
            photoEditorView.addFilterEffect(filterName: presenter.getCurrentStateArray(editorState: editorState)[indexPath.row])
            break
        case .stickers:
            photoEditorView.addSticker(stickerName: presenter.getCurrentStateArray(editorState: editorState)[indexPath.row])
            break
        case .frames:
            photoEditorView.addFrame(frameName: presenter.getCurrentStateArray(editorState: editorState)[indexPath.row])
            break
        }
        deselectEditorState()
    }
    
}

extension PhotoEditorViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoEditorView.setBackgroundImage(image: image)
        }
        
        setupCollectionView()
    }
    
    
    
}
