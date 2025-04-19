//
//  UserDataService.swift
//  SignUp
//
//  Created by 안준경 on 4/19/25.
//

import Foundation
import CoreData

final class UserDataService {
    
    private let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        self.container = NSPersistentContainer(name: "UserData")
        self.container.loadPersistentStores { _, error in
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
    func deleteUser(email: String) {
        
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        request.fetchLimit = 1
        
        do {
            if let user = try context.fetch(request).first {
                context.delete(user)
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllUsers() -> [UserData] {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { entity in
                UserData(
                    email: entity.email ?? "",
                    password: entity.password ?? "",
                    nickname: entity.nickname ?? ""
                )
            }
        } catch {
            print("❌ Failed to fetch users: \(error)")
            return []
        }
    }
}
