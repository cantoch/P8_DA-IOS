//
//  SleepRepositoryTests.swift
//  AristaTests
//
//  Created by Renaud Leroy on 02/10/2025.
//

import XCTest
import CoreData
@testable import Arista

final class SleepRepositoryTests: XCTestCase {
    
    var context: NSManagedObjectContext!
    var peristenceController: PersistenceController!
    var data: SleepRepository!
    
    override func setUp() {
        super.setUp()
        peristenceController = PersistenceController(inMemory: true)
        context = peristenceController.container.viewContext
        data = SleepRepository(viewContext: context)
    }
    
    override func tearDown() {
        peristenceController = nil
        context = nil
        data = nil
        super.tearDown()
    }
    
    func test_getSleepSessions_returnsEmptyArray_whenNoSessions() {
        
        let sessions = try! data.getSleepSessions()
        
        XCTAssertTrue(sessions.isEmpty == true)
    }
    
    func test_getSleepSessions_returnsOneSession_whenOneSessionExists() {
        
        // Given
        let user = User(context: context)
        user.firstName = "Test"
        user.lastName = "User"
        
        let sleep = Sleep(context: context)
        sleep.duration = 700
        sleep.startDate = Date()
        sleep.user = user
        sleep.quality = 7
        
        try! context.save()
        
        // When
        let sessions = try! data.getSleepSessions()
        
        // Then
        XCTAssertEqual(sessions.count, 1)
        XCTAssertEqual(sessions.first?.duration, 700)
        XCTAssertEqual(sessions.first?.quality, 7)
    }
    
    func test_getSleepSessions_returnsSessionsOrderedByDate() {
        
    }
}
