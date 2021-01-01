//
//  AccountViewModel.swift
//  Zacon
//
//  Created by Mikhail Danilov on 28.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol AccountViewModelProtocol: AnyObject {

}

final class AccountViewModel: AccountViewModelProtocol {

    // MARK: Constants

    // MARK: Properties
    private let router: AccountRouter
    
    init(router: AccountRouter) {
        self.router = router
    }
    
    // MARK: Methods
}
