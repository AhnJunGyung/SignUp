//
//  SignUpDataService.swift
//  SignUp
//
//  Created by 안준경 on 4/19/25.
//

import Foundation
import CoreData

final class SignUpDataService {
    
    private let persistentContainer: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
        self.persistentContainer = NSPersistentContainer(name: "UserData")
        self.persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // MARK: Save UserData
    func saveUser(userData: UserData) {
        let user = UserEntity(context: context)
        user.email = userData.email
        user.password = userData.password
        user.nickname = userData.nickname
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Fetch UserData
    func fetchUser(email: String) -> UserData? {
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        request.fetchLimit = 1
        
        do {
            if let user = try context.fetch(request).first {
                return UserData(
                    email: user.email ?? "",
                    password: user.password ?? "",
                    nickname: user.nickname ?? ""
                )
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    // MARK: Delete UserData
    func deleteUser() {
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: UserEntity.fetchRequest())
        
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: persistentContainer.viewContext)
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
