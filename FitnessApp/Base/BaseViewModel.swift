//
//  BaseViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

class BaseViewModel<T: Coordinator> {
    
    weak var coordinator: T?
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
}
