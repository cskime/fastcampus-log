//
//  ViewController.swift
//  ImagePickerControllerExample
//
//  Created by giftbot on 2020. 1. 4..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit
import MobileCoreServices

final class ViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    private let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }
    
    @IBAction private func pickImage(_ sender: Any) {
        print("\n---------- [ pickImage ] ----------\n")
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    
    @IBAction private func takePicture(_ sender: Any) {
        print("\n---------- [ takePicture ] ----------\n")
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
    }
    
    @IBAction private func takePictureWithDelay(_ sender: Any) {
        print("\n---------- [ takePictureWithDelay ] ----------\n")
        
        imagePickerController.sourceType = .camera
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        present(imagePickerController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.imagePickerController.takePicture()
            }
        }
    }
    
    
    @IBAction private func recordingVideo(_ sender: Any) {
        print("\n---------- [ recordingVideo ] ----------\n")
        
        imagePickerController.sourceType = .camera
        // Movie - 소리포함, Video - 영상만
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        imagePickerController.cameraCaptureMode = .video
//        imagePickerController.cameraDevice = .rear
        present(imagePickerController, animated: true)
        
        imagePickerController.videoQuality = .typeHigh
    }
    
    @IBAction private func toggleAllowsEditing(_ sender: Any) {
        print("\n---------- [ toggleAllowsEditing ] ----------\n")
        imagePickerController.allowsEditing.toggle()
    }
}

// MARK:- UIImagePickerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("\n---------- [ imagePickerControllerDidCancel ] ----------\n")
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\n---------- [ imagePickerControllerDidFinishPickingMediaWithInfo ] ----------\n")
        
        // 영상인 경우는 제외하고 이미지인 경우에만 동작하도록
        let mediaType = info[.mediaType] as! NSString
        if UTTypeEqual(mediaType, kUTTypeImage) {
            let originalImage = info[.originalImage] as? UIImage
            let editedImage = info[.editedImage] as? UIImage
            let selectedImage = editedImage ?? originalImage
            imageView.image = selectedImage
            
            if picker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(selectedImage!, nil, nil, nil)
            }
        } else if UTTypeEqual(mediaType, kUTTypeMovie) {
            if let mediaPath = (info[.mediaURL] as? NSURL)?.path, UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(mediaPath) {
                UISaveVideoAtPathToSavedPhotosAlbum(mediaPath, nil, nil, nil)
            }
        }
        
        dismiss(animated: true)
    }
}
