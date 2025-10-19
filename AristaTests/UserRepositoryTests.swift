//
//  UserRepositoryTests.swift
//  AristaTests
//
//  Created by Renaud Leroy on 19/10/2025.
//

import XCTest
import CoreData
@testable import Arista

final class UserRepositoryTests: XCTestCase {

    var context: NSManagedObjectContext!
    var persistenceController: PersistenceController!
    var userRepository: UserRepository!
    
    override func setUp() {
        super.setUp()
        persistenceController = PersistenceController(inMemory: true)
        context = persistenceController.container.viewContext
        userRepository = UserRepository(viewContext: context)
    }
    
    override func tearDown() {
        userRepository = nil
        context = nil
        persistenceController = nil
        super.tearDown()
    }
    
    func test_getUser_returnsNil_whenNoUserExists() {
        // Given: base vide
        
        // When
        let user = try? userRepository.getUser()
        
        // Then
        XCTAssertNil(user)
    }
    
    func test_getUser_returnsUser_whenUserExists() {
        // Given
        let user = User(context: context)
        user.firstName = "Ren"
        user.lastName = "L"
        try! context.save()
        
        // When
        let fetchedUser = try? userRepository.getUser()
        
        //Then
        XCTAssertNotNil(user)
        XCTAssertEqual(fetchedUser?.firstName, "Ren")
        XCTAssertEqual(fetchedUser?.lastName, "L")
    }
    
    func test_getUser_returnsFirstUser_whenMultipleUsersExist() {
        // Given
        let user1 = User(context: context)
        user1.firstName = "jane"
        user1.lastName = "smith"
        
        let user2 = User(context: context)
        user2.firstName = "john"
        user2.lastName = "doe"
        
        try! context.save()
        
        // When
        let fetchedUser = try? userRepository.getUser()
        
        // Then
        XCTAssertNotNil(fetchedUser)
        // Assertion à ajouter 
    }
    
    func test_getUser_withNilValues() {
        // Given
        let user = User(context: context)
        user.firstName = nil
        user.lastName = nil
        try! context.save()
        
        // When
        let fetchedUser = try! userRepository.getUser()
        
        //Then
        XCTAssertNotNil(fetchedUser)
        XCTAssertNil(fetchedUser?.firstName)
        XCTAssertNil(fetchedUser?.lastName)
    }
}
