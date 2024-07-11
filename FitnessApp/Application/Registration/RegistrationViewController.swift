//
//  RegistrationViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.07.2024.
//

import UIKit

class RegistrationViewController: BaseViewController {

    @IBOutlet weak var logInButton: PlainButton!
    @IBOutlet weak private var tableView: UITableView!
    
    var viewModel: RegistrationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configUI()
    }
}

//-MARK: TableView
extension RegistrationViewController: UITableViewDelegate {
    
}

extension RegistrationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.getCells().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.cellIdentifier(), for: indexPath) as? TextFieldTableViewCell else { return UITableViewCell() }
        
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let cellData = viewModel.getCells()[indexPath.section]
        cell.config(cellType: cellData, delegate: viewModel)
        if cellData == .confirmPassword {
            cell.setErrorChecker { [weak self] text in
                guard let self = self else { return false }
                guard let viewModel = self.viewModel else { return false }
                return viewModel.password != text
            }
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        RegistrationViewModel.CellType.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = HeaderView()
            view.config(mainTitle: viewModel?.title, subtitle: viewModel?.subtitle)
            return view
        } else {
            let view = UIView()
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 2).isActive = true
            return view
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == tableView.numberOfSections - 1 {
            let view = FooterView()
            view.addAction(target: self, #selector(signUpButtonTouched))
            viewModel?.delegate = view
            return view
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == tableView.numberOfSections - 1 {
            return RegistrationViewModel.CellType.footerHeight
        }
        return 0
    }
}

//-MARK: Private functions
private extension RegistrationViewController {
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TextFieldTableViewCell.self)
        tableView.backgroundColor = .clear
    }
    
    func configUI() {
        self.logInButton.setType(.unfilled)
    }
    
    @objc func signUpButtonTouched(_ sender: UIButton) {
        if let viewModel = viewModel {
            for section in 0..<tableView.numberOfSections {
                if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: section)) as? TextFieldTableViewCell {
                    if cell.isError(){
                        return
                    }
                }
            }
            viewModel.registerUser()
        }
    }
}
