//
//  LoginInViewModel.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol LoginInViewModelProtocol: AnyObject {
    func tapCheckInButton()
    func tapLogIn(login: String, password: String)
}

final class LoginInViewModel: LoginInViewModelProtocol {

    // MARK: Constants

    // MARK: Properties
    private let router: LoginInRouter
    
    init(router: LoginInRouter) {
        self.router = router
    }
    
    // MARK: Methods
    func tapCheckInButton() {
        router.showCheckIn()
    }

    func tapLogIn(login: String, password:String) {
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] (result, error) in
            if error != nil {
                print("error>", error?.localizedDescription)
            } else {
                print("result?.user.uid>", result?.user.uid)
                if let uid = result?.user.uid {
                    self?.loadmyProfile(uid: uid)
                }
            }
        }
    }
    
    func loadmyProfile(uid: String) {
        print(#function)
        ProfileService.shared.userId = uid
        ProfileService.shared.loadMyUserProfile()
        self.router.showMainContainer()
    }
}
