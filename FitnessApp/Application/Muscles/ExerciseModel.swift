//
//  ExerciseModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.08.2024.
//

import Foundation

struct MuscleExercisesModel {
    let muscleName: String
    var exerciseList: [ExerciseModel]
    var isCollapsed: Bool = true
    var count: Int = 0
}

struct ExerciseModel {
    let name: String
    let imageIcon: String
    let exerciseImage: String
    let descriptions: String
    let exerciseType: ExerciseType
    let equipment: Equipment
    let level: Level
    var isSelected: Bool = false
}
