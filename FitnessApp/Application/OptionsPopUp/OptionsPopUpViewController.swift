//
//  OptionsPopUpViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 24.07.2024.
//

import UIKit

final class OptionsPopUpViewController: UIViewController  {
    
    @IBOutlet weak private var backgroundView: UIView!
    @IBOutlet weak private var contentView: UIStackView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var tableView: AdjustableTableView!
    @IBOutlet weak private var cancelButton: UIButton!
    @IBOutlet weak private var selectButton: UIButton!
    
    weak var delegate: OptionsPopUpDelegate?
    var viewModel: OptionsPopUpViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        configTableView()
        configUI()
    }
}

private extension OptionsPopUpViewController {
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Identifiers.NibNames.optionTableCell)
        tableView.setMinHeight(28)
        tableView.setMaxHeight(UIScreen.main.bounds.height / 1.56)
    }
    
    func configUI() {
        view.backgroundColor = .primaryBlack.withAlphaComponent(0.7)
        backgroundView.backgroundColor = .clear
        contentView.backgroundColor = .primaryBlack
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.primaryWhite.cgColor
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        tableView.backgroundColor = .clear
        titleLabel.textColor = .primaryYellow
        titleLabel.font = .mediumSaira?.withSize(18)
        titleLabel.text = viewModel?.title
        cancelButton.setTitle(viewModel?.cancelButtonText, for: .normal)
        if let model = viewModel {
            let attributedCancelTitle: NSAttributedString = .init(string: model.cancelButtonText, attributes: [
                .font: UIFont.regularSaira?.withSize(18) ?? .systemFont(ofSize: 18),
                .foregroundColor: UIColor.primaryWhite
            ])
            let attributedSelectTitle: NSAttributedString = .init(string: model.selectButtonText, attributes: [
                .font: UIFont.regularSaira?.withSize(18) ?? .systemFont(ofSize: 18),
                .foregroundColor: UIColor.primaryYellow
            ])
            cancelButton.setAttributedTitle(attributedCancelTitle, for: .normal)
            selectButton.setAttributedTitle(attributedSelectTitle, for: .normal)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        if let model = viewModel {
            delegate?.selectOptions(Array(model.selection))
        }
        self.dismiss(animated: true)
    }
}

extension OptionsPopUpViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        OptionDataName.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.NibNames.optionTableCell, for: indexPath) as? OptionTableViewCell else {
            return UITableViewCell()
        }
        if let model = viewModel {
            let option = OptionDataName.allCases[indexPath.row]
            let selected = model.selection.contains { $0 == option }
            cell.config(with: option, isSelected: selected) { option, isSelected in
                isSelected ? model.addOption(option) : model.removeOption(option)
            }
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? OptionTableViewCell else { return }
        cell.toggle()
    }
}
