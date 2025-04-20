//
//  LoginUserDefaultsService.swift
//  SignUp
//
//  Created by 안준경 on 4/19/25.
//

import Foundation

final class LoginUserDefaultsService {
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: 저장
    func saveUserData(userData: UserData) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(userData)
            userDefaults.set(data, forKey: "member")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: 조회
    func loadUserData() -> UserData? {
        
        if let data = userDefaults.data(forKey: "member") {
            let decoder = JSONDecoder()
            do {
                let userData = try decoder.decode(UserData.self, from: data)
                return userData
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        return nil
    }
    
    // MARK: 삭제
    func deleteUser() {
        userDefaults.removeObject(forKey: "member")
    }
}
