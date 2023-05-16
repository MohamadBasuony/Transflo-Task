//
//  ImagePickerProtocol.swift
//  AJEL
//
//  Created by Michelle Gerges on 6/22/18.
//  Copyright © 2018 Michelle Gerges. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

private enum ImageOptions: String {
    case camera = "Camera"
    case photos = "Photos"
}

protocol ImagePickerProtocol: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pickImage(imagePickerController: UIImagePickerController)
}

extension ImagePickerProtocol where Self: UIViewController {
    
    private func openCamera(_ imagePickerController: UIImagePickerController) {
        if [.denied, .restricted].contains(AVCaptureDevice.authorizationStatus(for: .video)) {
            UIApplication.shared.goToAppSettings()
            return
        }
        
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    private func openPhotos(_ imagePickerController: UIImagePickerController) {
        
        if [.denied, .restricted].contains(PHPhotoLibrary.authorizationStatus()) {
            UIApplication.shared.goToAppSettings()
            return
        }
        
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func pickImage(imagePickerController: UIImagePickerController) {
        
        let optionsAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        optionsAlert.addAction(UIAlertAction(title: "Camera",
                                             style: .default,
                                             handler: { _ in
                                                optionsAlert.dismiss(animated: false, completion: nil)
                                                self.openCamera(imagePickerController)
        }))
        
        optionsAlert.addAction(UIAlertAction(title: "Photos",
                                             style: .default,
                                             handler: { _ in
                                                optionsAlert.dismiss(animated: false, completion: nil)
                                                self.openPhotos(imagePickerController)
        }))
        
        optionsAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(optionsAlert, animated: true, completion: nil)
    }
}
