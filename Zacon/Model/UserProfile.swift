//
//  UserProfile.swift
//  Zacon
//
//  Created by Mikhail Danilov on 04.12.2020.
//

import Foundation

class UserProfile {
    var name: String
    var surName: String
    var patronymic: String
    var phone: String
    var email: String
    var password: String
    
    init(name:String, surName: String, patronymic: String, phone: String, email: String, password: String) {
        self.name = name
        self.surName = surName
        self.patronymic = patronymic
        self.phone = phone
        self.email = email
        self.password = password
    }
}
