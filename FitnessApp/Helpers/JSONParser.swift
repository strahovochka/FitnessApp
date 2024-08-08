//
//  JSONParser.swift
//  FitnessApp
//
//  Created by Jane Strashok on 08.08.2024.
//

import Foundation

class JSONParser {
    static let shared = JSONParser()
    
    private func extractJSONData(from fileName: String) -> [[String: Any]] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return [] }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let jsonData = json as? [[String: Any]] else { return [] }
            return jsonData
        } catch {
            print("JSON serialization error")
            return []
        }
    }
    
    func fetchExercises() -> [MuscleExercisesModel] {
        let jsonData = extractJSONData(from: Identifiers.FileNames.exercises)
        guard !jsonData.isEmpty else { return [] }
        var muscleTypes = [MuscleExercisesModel]()
        for muscleJson in jsonData {
            guard let musleName = muscleJson["muscleName"] as? String,
                  let exerciseList = muscleJson["exercisesList"] as? [[String: Any]] else { return [] }
            var exercises = [ExerciseModel]()
            for exerciseDict in exerciseList {
                guard let exercise = fetchExercise(from: exerciseDict) else { continue }
                exercises.append(exercise)
            }
            muscleTypes.append(MuscleExercisesModel(muscleName: musleName, exerciseList: exercises))
        }
        return muscleTypes
    }
    
    private func fetchExercise(from exercise: [String: Any]) -> ExerciseModel? {
        guard let name = exercise["name"] as? String,
              let imageIcon = exercise["imageIcon"] as? String,
              let exerciseImage = exercise["exerciseImage"] as? String,
              let descriptions = exercise["descriptions"] as? String,
              let exerciseType = exercise["exerciseType"] as? String,
              let equipment = exercise["equipment"] as? String,
              let level = exercise["level"] as? String else { return nil }
        guard let exerciseTypeCase = ExerciseType(rawValue: exerciseType),
              let equipmentCase = Equipment(rawValue: equipment),
              let levelCase = Level(rawValue: level) else { return nil }
        return ExerciseModel(name: name, imageIcon: imageIcon, exerciseImage: exerciseImage, descriptions: descriptions, exerciseType: exerciseTypeCase, equipment: equipmentCase, level: levelCase)
    }
}
