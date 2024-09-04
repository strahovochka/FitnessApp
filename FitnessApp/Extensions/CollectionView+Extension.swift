//
//  CollectionView+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 01.08.2024.
//

import UIKit

extension UICollectionView {
    func register (_ nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}
