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
    var viewModel: ChartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func customizeNavBar() {
        super.customizeNavBar()
        customizeBackButton()
        self.title = viewModel?.navigationTitle
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        barChart.records = viewModel?.getRecords()
    }
}

private extension ChartViewController {
    func configUI() {
        self.view.backgroundColor = .primaryBlack
        optionNameLabel.text = viewModel?.mainTitle
        optionNameLabel.font = .regularSaira?.withSize(24)
        optionNameLabel.textColor = .primaryWhite
        optionNameLabel.textAlignment = .center
        chartDescriptionLabel.text = viewModel?.dateTitle
        chartDescriptionLabel.font = .mediumSaira?.withSize(24)
        chartDescriptionLabel.textColor = .secondaryGray
        chartDescriptionLabel.textAlignment = .center
        chartDescriptionLabel.numberOfLines = 0
        
    }
}

