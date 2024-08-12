//
//  ChartViewController.swift
//  FitnessApp
//
//  Created by Jane Strashok on 31.07.2024.
//

import UIKit

final class ChartViewController: BaseViewController {
    
    @IBOutlet weak private var barChart: BarChartView!
    @IBOutlet weak private var optionNameLabel: UILabel!
    @IBOutlet weak private var chartDescriptionLabel: UILabel!
    @IBOutlet weak private var chartTopOffset: NSLayoutConstraint!
    @IBOutlet weak private var chartBottomOffset: NSLayoutConstraint!
    var viewModel: ChartViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeBackground()
        showNavigationBar(backButtonEnabled: true)
        configUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        barChart.records = viewModel?.getRecords()
    }
}

private extension ChartViewController {
    
    func configUI() {
        self.title = viewModel?.navigationTitle
        self.view.backgroundColor = .primaryBlack
        chartTopOffset.constant = screenSize.height * 0.15
        chartBottomOffset.constant = screenSize.height * 0.12
        
        optionNameLabel.text = viewModel?.mainTitle
        optionNameLabel.font = .regularSaira?.withSize(24)
        optionNameLabel.textColor = .primaryWhite
        optionNameLabel.textAlignment = .center
        
        chartDescriptionLabel.text = viewModel?.dateTitle
        chartDescriptionLabel.font = .mediumSaira?.withSize(16)
        chartDescriptionLabel.textColor = .secondaryGray
        chartDescriptionLabel.textAlignment = .center
        chartDescriptionLabel.numberOfLines = 0
    }
}

