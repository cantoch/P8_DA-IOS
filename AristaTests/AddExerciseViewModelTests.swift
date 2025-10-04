//
//  AddExerciseViewModelTests.swift
//  AristaTests
//
//  Created by Renaud Leroy on 04/10/2025.
//

import XCTest
import CoreData
import Combine
@testable import Arista

final class AddExerciseViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_addExercise_addsExerciseToContext() {
        
        // Clean manually all data
        
        let persistenceController = PersistenceController(inMemory: true)
        
        let date = Date()
        
        emptyEntities(context: persistenceController.container.viewContext)
        
        let viewModel = AddExerciseViewModel(context: persistenceController.container.viewContext)
        
        let expectation = XCTestExpectation(description: "fetch empty list of exercise")
        
        viewModel.category = "Football"
        viewModel.duration = 10
        viewModel.intensity = 5
        viewModel.startTime = date
        
        viewModel.addExercise()
        
        let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        
        let exercises = try! persistenceController.container.viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(exercises.count, 1)
        XCTAssertEqual(exercises.first?.category, "Football")
        XCTAssertEqual(exercises.first?.duration, 10)
        XCTAssertEqual(exercises.first?.intensity, 5)
        
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    private func emptyEntities(context: NSManagedObjectContext) {
        
        let fetchRequest = Exercise.fetchRequest()
        
        let objects = try! context.fetch(fetchRequest)
        
        for exercice in objects {
            
            context.delete(exercice)
            
        }
        
        try! context.save()
        
    }
}
