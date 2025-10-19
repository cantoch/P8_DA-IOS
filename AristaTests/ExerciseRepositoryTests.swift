//
//  ExerciseRepositoryTests.swift
//  AristaTests
//
//  Created by Renaud Leroy on 01/10/2025.
//

import XCTest
import CoreData
@testable import Arista

final class ExerciseRepositoryTests: XCTestCase {
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Exercise.fetchRequest()
        let objects = try! context.fetch(fetchRequest)
        
        for exercice in objects {
            context.delete(exercice)
        }
        
        try! context.save()
    }
    
    private func addExercice(context: NSManagedObjectContext, category: String, duration: Int, intensity: Int, startDate: Date, userFirstName: String, userLastName: String) {
        
        let newUser = User(context: context)
        newUser.firstName = userFirstName
        newUser.lastName = userLastName
        try! context.save()
        
        let newExercise = Exercise(context: context)
        newExercise.category = category
        newExercise.duration = Int64(duration)
        newExercise.intensity = Int64(intensity)
        newExercise.startDate = startDate
        newExercise.user = newUser
        
        try! context.save()
    }
    
    func test_WhenNoExerciseIsInDatabase_GetExercise_ReturnEmptyList() {
        
        // Clean manually all data
        let persistenceController = PersistenceController(inMemory: true)
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let data = ExerciseRepository(viewContext: persistenceController.container.viewContext)
        let exercises = try! data.getExercise()
        
        XCTAssert(exercises.isEmpty == true)
    }
    
    func test_WhenAddingOneExerciseInDatabase_GetExercise_ReturnAListContainingTheExercise() {
        
        // Clean manually all data
        let persistenceController = PersistenceController(inMemory: true)
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date = Date()
        
        addExercice(context: persistenceController.container.viewContext, category: "Football", duration: 10, intensity: 5, startDate: date, userFirstName: "Eric", userLastName: "Marcus")
        
        let data = ExerciseRepository(viewContext: persistenceController.container.viewContext)
        
        let exercises = try! data.getExercise()
        
        XCTAssert(exercises.isEmpty == false)
        XCTAssert(exercises.first?.category == "Football")
        XCTAssert(exercises.first?.duration == 10)
        XCTAssert(exercises.first?.intensity == 5)
        XCTAssert(exercises.first?.startDate == date)
    }
    
    func test_WhenAddingMultipleExerciseInDatabase_GetExercise_ReturnAListContainingTheExerciseInTheRightOrder() {
        
        // Clean manually all data
        let persistenceController = PersistenceController(inMemory: true)
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let date1 = Date()
        let date2 = Date(timeIntervalSinceNow: -(60*60*24))
        let date3 = Date(timeIntervalSinceNow: -(60*60*24*2))
        
        addExercice(context: persistenceController.container.viewContext,
                    category: "Football",
                    duration: 10,
                    intensity: 5,
                    startDate: date1,
                    userFirstName: "Erica",
                    userLastName: "Marcusi")
        
        addExercice(context: persistenceController.container.viewContext,
                    category: "Running",
                    duration: 120,
                    intensity: 1,
                    startDate: date3,
                    userFirstName: "Erice",
                    userLastName: "Marceau")
        
        addExercice(context: persistenceController.container.viewContext,
                    category: "Fitness",
                    duration: 30,
                    intensity: 5,
                    startDate: date2,
                    userFirstName: "Fréderic",
                    userLastName: "Marcus")
        
        let data = ExerciseRepository(viewContext: persistenceController.container.viewContext)
        
        let exercises = try! data.getExercise()
        
        XCTAssert(exercises.count == 3)
        XCTAssert(exercises[0].category == "Football")
        XCTAssert(exercises[1].category == "Fitness")
        XCTAssert(exercises[2].category == "Running")
    }
    
    func test_addExercise_AddANewExerciseInTheDatabase() {
        let persistenceController = PersistenceController(inMemory: true)
        let context = persistenceController.container.viewContext
        let user = User(context: context)
        let date = Date()
      
        user.firstName = "John"
        user.lastName = "Doe"
        
        let data = ExerciseRepository(viewContext: persistenceController.container.viewContext)
        try! data.addExercise(category: .natation,
                              duration: 120,
                              intensity: 1,
                              startDate: date)
        
        let exercises = try! data.getExercise()
        
        XCTAssert(exercises.count == 1)
        XCTAssert(exercises[0].category == "Natation")
        XCTAssert(exercises[0].duration == 120)
        XCTAssert(exercises[0].intensity == 1)
        XCTAssert(exercises[0].startDate == date)
    }
}

