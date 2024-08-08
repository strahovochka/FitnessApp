//
//  MusclesViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

final class MusclesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MusclesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configTable()
        viewModel?.reloadSection = { [weak self] section in
            guard let self = self else { return }
            self.tableView.beginUpdates()
            self.tableView.reloadSections([section], with: .none)
            self.tableView.endUpdates()
        }
        viewModel?.onSelect = { [weak self] section in
            guard let self = self else { return }
            self.showResetButton()
            self.tableView.reloadSections([section], with: .none)
        }
    }
}

private extension MusclesViewController {
    func configUI() {
        setBackground(for: viewModel?.user?.getSex() ?? .male)
        title = viewModel?.navigationTitle
        tableView.backgroundColor = .clear
    }
    
    func configTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(startResfresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: Identifiers.NibNames.muscleHeader, bundle: nil), forHeaderFooterViewReuseIdentifier: Identifiers.NibNames.muscleHeader)
        tableView.register(Identifiers.NibNames.exerciseCell)
    }
    
    @objc func startResfresh(refreshControl: UIRefreshControl) {
        self.reset()
        refreshControl.endRefreshing()
    }
    
    @objc func reset() {
        viewModel?.reset()
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .automatic)
        navigationItem.rightBarButtonItem = nil
    }
    
    func showResetButton() {
        guard let muscleExercises = viewModel?.muscleExercises else { return }
        if muscleExercises.contains(where: { $0.exerciseList.contains { $0.isSelected }}) {
            navigationItem.rightBarButtonItem = self.createNavButton(text: "Reset", selector: #selector(reset))
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
}

extension MusclesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.muscleExercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let muscleExercises = viewModel?.muscleExercises else  { return 0 }
        let exercises = muscleExercises[section]
        if exercises.isCollapsed {
            return 0
        } else {
            return exercises.exerciseList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.NibNames.exerciseCell, for: indexPath) as? ExerciseTableViewCell,
              let exercise = viewModel?.muscleExercises?[indexPath.section].exerciseList[indexPath.row],
              let headerView = tableView.headerView(forSection: indexPath.section) as? MuscleHeaderView else { return UITableViewCell() }
        cell.exercise = exercise
        cell.delegate = headerView
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifiers.NibNames.muscleHeader) as? MuscleHeaderView else { return UIView() }
        headerView.section = section
        headerView.muscle = viewModel?.muscleExercises?[section]
        headerView.delegate = viewModel
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel?.headerHeight ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.rowHeight ?? 0.0
    }
}
