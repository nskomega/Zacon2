//
//  СheckInViewModel.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol СheckInViewModelProtocol: AnyObject {
    func tapCheckIn(login: String, password: String, name: String, surName: String, patronymic: String, phone: String)
}


final class СheckInViewModel: СheckInViewModelProtocol {

    // MARK: Constants

    // MARK: Properties
    private let router: СheckInRouter
    private let profileService = ProfileService.shared

    init(router: СheckInRouter) {
        self.router = router
    }
    
    // MARK: Methods
    func tapCheckIn(login: String, password: String, name: String, surName: String, patronymic: String, phone: String) {
        
        let userProfile = UserProfile(name: name, surName: surName, patronymic: patronymic, phone: phone, email: login, password: password)
        
        print(userProfile.email)
        print(userProfile.password)
        
        
        Auth.auth().createUser(withEmail: userProfile.email, password: userProfile.password) { [weak self] (result, error) in
            
            if error != nil {
                print("error>", error?.localizedDescription)
            }
            
            if let user = Auth.auth().currentUser {
                self?.profileService.userId = user.uid
                self?.profileService.saveMyUserProfile(userProfile: userProfile)
                self?.router.showMainContainer()
            }
        }
    }

}
