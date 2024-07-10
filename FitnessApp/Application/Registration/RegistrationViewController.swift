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
        if cellData == .confirmPassword {
            let errorChecker: (String) -> (Bool) = { text in
                if let index = viewModel.getCells().firstIndex(of: .password), let passwordCell = tableView.cellForRow(at: IndexPath(row: 0, section: index)) as? TextFieldTableViewCell, let password = passwordCell.getText() {
                    return text != password
                } else {
                    return false
                }
            }
            cell.config(title: cellData.title, placeholder: cellData.placeholderText, errorAction: errorChecker)
        } else {
            cell.config(title: cellData.title, placeholder: cellData.placeholderText, errorAction: cellData.errorChecker)
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
            return FooterView()
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
}
