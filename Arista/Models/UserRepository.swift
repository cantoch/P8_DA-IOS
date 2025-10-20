//
//  UserRepository.swift
//  Arista
//
//  Created by Renaud Leroy on 27/09/2025.
//

import Foundation
import CoreData

protocol UserRepositoryProtocol {
    func getUser() throws -> User?
}

struct UserRepository: UserRepositoryProtocol {
    
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getUser () throws -> User? {
        let request = User.fetchRequest()
        request.fetchLimit = 1
        return try viewContext.fetch(request).first
    }
}
