//
//  ClaculatorViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

final class CalculatorViewController: BaseViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    var viewModel: CalculatorViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        showNavigationBar()
        configTable()
        viewModel?.update = { [weak self] in
            guard let self = self else { return }
            self.updateUI()
        }
        updateUI()
    }
}

private extension CalculatorViewController {
    func configUI() {
        guard let viewModel = viewModel else { return }
        self.title = viewModel.navigationTitle
    }
    
    func updateUI() {
        guard let user = viewModel?.user else { return }
        setBackground(for: user.getSex())
    }
    
    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(Identifiers.NibNames.underlinedTableCell)
    }
}

extension CalculatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.NibNames.underlinedTableCell, for: indexPath) as? UnderlinedTableViewCell, let cellType = viewModel?.cells[indexPath.row] else { return UITableViewCell() }
        cell.config(with: cellType.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.rowHeight ?? 0
    }
}
