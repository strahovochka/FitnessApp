//
//  Coordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 01.07.2024.
//

import UIKit
import PhotosUI
import ImageCaptureCore

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
}

extension Coordinator {
    func showPopUp(title: String, type: PopUpCoordinator.ViewType, completition: (() -> ())? = nil) {
        let child = PopUpCoordinator(navigationController: navigationController, message: title, type: type, completition: completition)
        childCoordinators.append(child)
        child.start()
    }
    
    func navigateBack() {
        navigationController.popViewController(animated: true)
    }
    
    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    
    func showImagePickerOptions(delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)) {
        let alertVC = UIAlertController(title: "Pick a profile photo", message: "Choose a picture from gallery or camera", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] action in
            guard let self = self else { return }
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    DispatchQueue.main.async {
                        let cameraImagePicker = self.imagePicker(sourceType: .camera)
                        cameraImagePicker.delegate = delegate
                        self.navigationController.present(cameraImagePicker, animated: true)
                    }
                } else {
                    print("No access")
                }
            }
            
        }
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] action in
            guard let self = self else { return }
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
                        libraryImagePicker.delegate = delegate
                        self.navigationController.present(libraryImagePicker, animated: true)
                    }
                } else {
                    print("Not authorized")
                }
            }
        }
        
        let cancelAtion = UIAlertAction(title: "Cancel", style: .cancel)
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAtion)
        self.navigationController.topViewController?.present(alertVC, animated: true)
    }
}
