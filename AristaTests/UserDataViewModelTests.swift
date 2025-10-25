//
//  UserDataViewModelTests.swift
//  AristaTests
//
//  Created by Renaud Leroy on 19/10/2025.
//

import XCTest
import CoreData
@testable import Arista

final class UserDataViewModelTests: XCTestCase {
    
    var context: NSManagedObjectContext!
    var peristenceController: PersistenceController!
    var viewModel: UserDataViewModel!
    
    override func setUp() {
        super.setUp()
        peristenceController = PersistenceController(inMemory: true)
        context = peristenceController.container.viewContext
    }
    
    override func tearDown() {
        peristenceController = nil
        context = nil
        super.tearDown()
    }
    
    func test_fetchUserData_shouldReturnUserData() {
        // Given
        let mockRepository = MockUserRepository()
        let user = User(context: context)
        user.firstName = "john"
        user.lastName = "doe"
        mockRepository.mockUsers = user
        
        // When
        viewModel = UserDataViewModel(context: context, repository: mockRepository)
        viewModel.fetchUserData()
        
        // Then
        XCTAssertEqual(viewModel.firstName, "john")
    }
    
    func test_fetchUserData_shouldEmptyStringWhenNoUser() {
        let mockRepository = MockUserRepository()
        
        viewModel = UserDataViewModel(context: context, repository: mockRepository)
        viewModel.fetchUserData()
        
        XCTAssertEqual(viewModel.firstName, "")
    }
}
