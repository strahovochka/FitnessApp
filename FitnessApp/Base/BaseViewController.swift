//
//  BaseViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 30.06.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func instantiate(for storyboardName: String) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
