//
//  ExerciseViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 09.08.2024.
//

import Foundation

final class ExerciseViewModel: BaseViewModel<ExerciseCoordinator> {
    let exercise: ExerciseModel
    let navigationTitle = "Exercise"
    let showMoreText = " ...showMore"
    
    init(exercise: ExerciseModel) {
        self.exercise = exercise
    }
}
