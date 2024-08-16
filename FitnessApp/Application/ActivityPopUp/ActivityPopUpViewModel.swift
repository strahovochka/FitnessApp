//
//  ActivityPopUpViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 15.08.2024.
//

import Foundation

final class ActivityPopUpViewModel: BaseViewModel<ActivityPopUpCoordinator> {
    let title = "Chose Your Activity Level"
    let confirmButtonText = "Confirm"
    private(set) var selectedActivityLevel: DailyCaloriesRateAtivity?
    
    init(selectedActivityLevel: DailyCaloriesRateAtivity?) {
        self.selectedActivityLevel = selectedActivityLevel
    }
    
    func setActivityLevel(_ activityLevel: DailyCaloriesRateAtivity) {
        self.selectedActivityLevel = activityLevel
    }
}
