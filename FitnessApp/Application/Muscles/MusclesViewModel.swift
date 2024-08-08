//
//  MusclesViewModel.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import Foundation

enum ExerciseType: String {
    case bodybuilding = "Bodybuilding"
    case powerlifting = "Powerlifting"
}

enum Equipment: String {
    case dumbbell = "Dumbbells"
    case barbell = "Barbell"
    case cablemachine = "Machine"
    case bodyweight = "Body Weight"
}

enum Level: String {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case experienced = "Experienced"
}

final class MusclesViewModel: UserDependentViewModel<MusclesCoordinator> {
    let navigationTitle = "Muscles"
    var muscleExercises: [MuscleExercisesModel]?
    let rowHeight: CGFloat = 183
    let headerHeight: CGFloat = 33
    
    var reloadSection: ((Int) -> ())?
    var onSelect: ((Int) -> ())?
    
    override init(user: UserModel? = nil) {
        super.init(user: user)
        muscleExercises = JSONParser.shared.fetchExercises()
    }
    
    func reset() {
        muscleExercises = muscleExercises?.map({ model in
            var newModel = model
            newModel.exerciseList = newModel.exerciseList.map { exercise in
                var newExercise = exercise
                newExercise.isSelected = false
                return newExercise
            }
            newModel.count = 0
            newModel.isCollapsed = true
            return newModel
        })
    }
    
    func didSelectExercise(from muscle: String, _ name: String, selected: Bool) {
        guard let muscleIndex = muscleExercises?.firstIndex(where: { $0.muscleName == muscle}),
              let exerciseIndex = muscleExercises?[muscleIndex].exerciseList.firstIndex(where: { $0.name == name}) else { return }
        muscleExercises?[muscleIndex].exerciseList[exerciseIndex].isSelected.toggle()
        muscleExercises?[muscleIndex].count += selected ? 1 : -1
        self.onSelect?(muscleIndex)
    }
}

extension MusclesViewModel: HeaderViewDelegate {
    func toggleSection(header: MuscleHeaderView, section: Int) {
        muscleExercises?[section].isCollapsed.toggle()
        self.reloadSection?(section)
    }
}
