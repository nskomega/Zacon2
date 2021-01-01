//
//  ProfileService.swift
//  Zacon
//
//  Created by Mikhail Danilov on 06.12.2020.
//

import Foundation
import Firebase

class ProfileService {
    
    static let shared = ProfileService()
    var ref: DatabaseReference?
    
    var myUserProfile = UserProfile(name: "", surName: "", patronymic: "", phone: "", email: "", password: "")
    var userId = ""
    
    func saveMyUserProfile(userProfile: UserProfile) {
        ref = Database.database().reference(withPath: "users")
        let userRef = self.ref?.child(userId)
        userRef?.setValue([
            "name" : userProfile.name,
            "surName" : userProfile.surName,
            "email" : userProfile.email,
            "patronymic" : userProfile.patronymic,
            "password" : userProfile.password,
            "phone" : userProfile.phone,
        ])
        loadMyUserProfile()
    }
    
    func loadMyUserProfile() {
        
        ref = Database.database().reference(withPath: "users").child(userId)
        ref?.observe(.value, with: { (snapshot) in
            for item in snapshot.children {
                if let data = item as? DataSnapshot {
                    print("data.key>",data.key, "  ->", data.value)
                    let value: String = data.value as? String ?? ""
                    
                    switch data.key {
                    case "name":
                        self.myUserProfile.name = value
                    case "password":
                        self.myUserProfile.password = value
                    case "phone":
                        self.myUserProfile.phone = value
                    case "surName":
                        self.myUserProfile.surName = value
                    case "patronymic":
                        self.myUserProfile.patronymic = value
                    case "email":
                        self.myUserProfile.email = value
                    default:
                        print("чтото пошло не так")
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
