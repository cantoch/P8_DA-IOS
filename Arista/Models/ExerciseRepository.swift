//
//  ExerciseRepository.swift
//  Arista
//
//  Created by Renaud Leroy on 27/09/2025.
//

import Foundation
import CoreData

protocol ExerciseRepositoryProtocol {
    func getExercise() throws -> [Exercise]
    func addExercise(category: String, duration: Int, intensity: Int, startDate: Date) throws
    func deleteExercise(_ exercise: Exercise) throws
}

struct ExerciseRepository: ExerciseRepositoryProtocol {
    
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getExercise() throws -> [Exercise] {
        let request = Exercise.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Exercise> (\.startDate, order: .reverse))]
        return try viewContext.fetch(request)
    }
    
    
    
    func addExercise(category: String, duration: Int, intensity: Int, startDate: Date) throws {
        let user = try? UserRepository(viewContext: viewContext).getUser()
        let newExercise = Exercise(context: viewContext)
        newExercise.category = category
        newExercise.duration = Int64(duration)
        newExercise.intensity = Int64(intensity)
        newExercise.startDate = startDate
        newExercise.user = user
        try viewContext.save()
    }
    
    func deleteExercise(_ exercise: Exercise) throws {
        viewContext.delete(exercise)
        try viewContext.save()
    }
}

