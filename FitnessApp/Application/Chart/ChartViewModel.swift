//
//  ChartViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 31.07.2024.
//

import UIKit

struct Record {
    let date: Date
    let value: Double
    var progress: Double?
    let barColor: CGColor
    let barHeightCoeff: CGFloat
    let units: String
}

final class ChartViewModel: BaseViewModel<ChartCoordinator> {
    let option: OptionModel
    let navigationTitle: String
    let mainTitle: String
    let maxValue: Double
    var dateTitle = "Displaying dynamics relative to data from "
    
    init(option: OptionModel) {
        self.option = option
        self.navigationTitle = "\(option.optionName.rawValue) chart".capitalized
        self.mainTitle = "\(option.optionName.rawValue), \(option.optionName.metricValue)"
        if let firstDate = option.dateArray.first {
            dateTitle.append(firstDate.convertToDate().formatDate("dd.MM.yyyy"))
        }
        self.maxValue = option.valueArray.compactMap { $0 }.max() ?? 0
    }
    
    func getRecords() -> [Record] {
        var records = [Record]()
        for (index, (date, value)) in zip(option.dateArray, option.valueArray).enumerated() {
            if let value = value {
                let record = getRecord(date: date.convertToDate(), currentValue: value, previousValue: index > 0 ? option.valueArray[index - 1] : nil, units: option.optionName.metricValue)
                records.append(record)
            }
        }
        return records
    }
}

private extension ChartViewModel {
    func getRecord(date: Date, currentValue: Double, previousValue: Double?, units: String) -> Record {
        var record = Record(date: date, value: currentValue, progress: nil, barColor: UIColor.primaryYellow.cgColor, barHeightCoeff: currentValue / maxValue, units: units)
        guard let previousValue = previousValue else { return record }
        record.progress = currentValue - previousValue
        return record
    }
}
