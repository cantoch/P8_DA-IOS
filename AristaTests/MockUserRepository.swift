//
//  MockUserRepository.swift
//  AristaTests
//
//  Created by Renaud Leroy on 19/10/2025.
//

import Foundation
@testable import Arista

final class MockUserRepository: UserRepositoryProtocol {
   
    var mockUsers: User?
    
    func getUser() throws -> User? {
        return mockUsers
    }
    
}
