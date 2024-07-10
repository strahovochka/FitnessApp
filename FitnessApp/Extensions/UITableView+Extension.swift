//
//  UITableView+Extension.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

extension UITableView {
    func register(_ cell: UITableViewCell.Type) {
        self.register(UINib(nibName: cell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: cell.cellIdentifier())
    }
}
