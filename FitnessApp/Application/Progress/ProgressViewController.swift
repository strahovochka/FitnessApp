//
//  ProgressViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

final class ProgressViewController: BaseViewController {
    
    @IBOutlet weak private var emptyViewContainer: UIView!
    @IBOutlet weak private var emptyImageView: UIImageView!
    @IBOutlet weak private var emptyLabel: UILabel!
    @IBOutlet weak private var tableView: UITableView!
    
    var viewModel: ProgressViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        viewModel?.getUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configTable()
        showNavigationBar()
        viewModel?.update = { [weak self] in
            guard let self = self else { return }
            self.updateUI()
        }
        guard let _ = viewModel?.user else {
            viewModel?.getUser()
            return
        }
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.bounds.height
    }
}

private extension ProgressViewController {
    func configUI() {
        self.title = viewModel?.navigationTitle
        emptyViewContainer.isHidden = true
        tableView.isHidden = true
    }
    
    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(Identifiers.NibNames.underlinedTableCell)
    }
    
    func updateUI() {
        guard let viewModel = viewModel, let user = viewModel.user else { return }
        setBackground(for: user.getSex())
        if viewModel.isEmpty() {
            emptyViewContainer.isHidden = true
            emptyViewContainer.backgroundColor = .primaryBlack
            emptyViewContainer.layer.borderColor = UIColor.primaryWhite.cgColor
            emptyViewContainer.layer.borderWidth = 1
            emptyLabel.text = viewModel.emptyStateText
            emptyImageView.image = .errorIcon
        } else {
            tableView.reloadData()
            tableView.isHidden = false
        }
    }
}

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getOptions().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.NibNames.underlinedTableCell, for: indexPath) as? UnderlinedTableViewCell,
              let option = viewModel?.getOptions()[indexPath.row] else { return UITableViewCell() }
        cell.config(with: option.optionName.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        73
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let option = viewModel?.getOptions()[indexPath.row] else { return }
        viewModel?.goToChart(for: option)
    }
}
