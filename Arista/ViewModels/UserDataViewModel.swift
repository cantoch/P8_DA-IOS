//
//  UserDataViewModel.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import Foundation
import CoreData

class UserDataViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    private var viewContext: NSManagedObjectContext
    private var repository: UserRepositoryProtocol
    
    init(context: NSManagedObjectContext, repository: UserRepositoryProtocol) {
        self.viewContext = context
        self.repository = repository
    }
    
    func fetchUserData() {
        guard let user = try? repository.getUser() else {
            firstName = ""
            lastName = ""
            return
        }
        firstName = user.firstName ?? ""
        lastName = user.lastName ?? ""
    }
}
