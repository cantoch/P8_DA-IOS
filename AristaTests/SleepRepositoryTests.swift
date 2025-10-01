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
}
