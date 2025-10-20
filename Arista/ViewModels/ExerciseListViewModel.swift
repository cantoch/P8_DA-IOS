//
//  ExerciseListViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation
import CoreData

class ExerciseListViewModel: ObservableObject {
    @Published var exercises = [Exercise]()
    @Published var errorMessage: ExerciseError?
    
    var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchExercises()
    }
    func fetchExercises() {
        do {
            let data = ExerciseRepository(viewContext: viewContext)
            exercises = try data.getExercise()
        } catch {
            errorMessage = .fetchExerciseFailed
            exercises = []
        }
    }
    
    func removeExercise(at indexSet: IndexSet) {
        let repository = ExerciseRepository(viewContext: viewContext)
        
        guard let index = indexSet.first, exercises.indices.contains(index) else {
            return
        }
        do {
            try repository.deleteExercise(exercises[index])
        } catch {
            errorMessage = .deleteExerciseFailed
        }
        fetchExercises()
    }
}
