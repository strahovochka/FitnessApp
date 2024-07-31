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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configTable()
        guard let _ = viewModel?.user else {
            viewModel?.getUser(completition: { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.updateUI()
                }
            })
            return
        }
        viewModel?.update = { [weak self] in
            guard let self = self else { return }
            self.updateUI()
        }
        updateUI()
    }
    
    override func customizeNavBar() {
        super.customizeNavBar()
        self.title = viewModel?.navigationTitle
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.bounds.height
    }
}

private extension ProgressViewController {
    func configUI() {
        emptyViewContainer.isHidden = true
        tableView.isHidden = true
    }
    
    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: Identifiers.NibNames.progressTableCell, bundle: nil), forCellReuseIdentifier: Identifiers.NibNames.progressTableCell)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.NibNames.progressTableCell, for: indexPath) as? ProgressTableViewCell,
              let option = viewModel?.getOptions()[indexPath.row] else { return UITableViewCell() }
        cell.config(with: option.optionName.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        73
    }
}
