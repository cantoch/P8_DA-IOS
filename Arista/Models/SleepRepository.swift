//
//  SleepRepository.swift
//  Arista
//
//  Created by Renaud Leroy on 27/09/2025.
//

import Foundation
import CoreData

protocol SleepRepositoryProtocol {
    func getSleepSessions() throws -> [Sleep]
}

struct SleepRepository: SleepRepositoryProtocol {
    
    let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
    }
    
    func getSleepSessions() throws -> [Sleep] {
        let request = Sleep.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(SortDescriptor<Sleep>(\.startDate, order: .reverse))]
        return try viewContext.fetch(request)
    }
}
