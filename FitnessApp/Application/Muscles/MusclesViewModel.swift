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
    
    //TODO: -Separate service for parsing jsons singleton
    func fetchExercises() -> [MuscleExercisesModel] {
        guard let musclesPath = Bundle.main.path(forResource: Identifiers.FileNames.exercises, ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: musclesPath)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let exerciseArray = json as? [Any] else { return [] }
            var allExercises = [MuscleExercisesModel]()
            for muscleType in exerciseArray {
                guard let muscleExercises = muscleType as? [String: Any] else { return [] }
                guard let muscleName = muscleExercises["muscleName"] as? String,
                      let exercisesList = muscleExercises["exercisesList"] as? [[String: Any]] else { return [] }
                var exercises = [ExerciseModel]()
                for exercise in exercisesList {
                    guard let name = exercise["name"] as? String,
                          let imageIcon = exercise["imageIcon"] as? String,
                          let exerciseImage = exercise["imageIcon"] as? String,
                          let descriptions = exercise["descriptions"] as? String,
                          let exerciseType = exercise["exerciseType"] as? String,
                          let equipment = exercise["equipment"] as? String,
                          let level = exercise["level"] as? String else { return [] }
                    exercises.append(ExerciseModel(name: name, imageIcon: imageIcon, exerciseImage: exerciseImage, descriptions: descriptions, exerciseType: ExerciseType(rawValue: exerciseType) ?? .powerlifting, equipment: Equipment(rawValue: equipment) ?? .bodyweight, level: Level(rawValue: level) ?? .beginner))
                }
                allExercises.append(MuscleExercisesModel(muscleName: muscleName, exerciseList: exercises))
            }
            return allExercises
        } catch {
            coordinator?.showPopUp(title: error.localizedDescription, type: .oneButton(PopUpButtonConfig(title: "Ok", type: .filled, action: nil)))
        }
        return []
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
}

extension MusclesViewModel: HeaderViewDelegate {
    func didSelectExercise(from muscle: String, _ name: String, selected: Bool) {
        guard let muscleIndex = muscleExercises?.firstIndex(where: { $0.muscleName == muscle}),
              let exerciseIndex = muscleExercises?[muscleIndex].exerciseList.firstIndex(where: { $0.name == name}) else { return }
        muscleExercises?[muscleIndex].exerciseList[exerciseIndex].isSelected.toggle()
        muscleExercises?[muscleIndex].count += selected ? 1 : -1
        self.onSelect?(muscleIndex)
    }
    
    func toggleSection(header: MuscleHeaderView, section: Int) {
        muscleExercises?[section].isCollapsed.toggle()
        self.reloadSection?(section)
    }
}
