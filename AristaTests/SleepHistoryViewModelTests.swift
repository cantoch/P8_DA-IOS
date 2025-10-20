//
//  SleepHistoryViewModelTests.swift
//  AristaTests
//
//  Created by Renaud Leroy on 19/10/2025.
//

import XCTest
import CoreData
@testable import Arista

final class SleepHistoryViewModelTests: XCTestCase {

    var context: NSManagedObjectContext!
    var peristenceController: PersistenceController!
    var viewModel: SleepHistoryViewModel!
    
    override func setUp() {
        super.setUp()
        peristenceController = PersistenceController(inMemory: true)
        context = peristenceController.container.viewContext
        viewModel = SleepHistoryViewModel(context: context)
    }
    
    override func tearDown() {
        peristenceController = nil
        context = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_sleepSessions_whenNoSessions_thenEmptyArray() {
        // Given
        // Aucune session
        
        // When
        let sessions = viewModel.sleepSessions
        
        // Then
        XCTAssertTrue(sessions.isEmpty)
    }
}
