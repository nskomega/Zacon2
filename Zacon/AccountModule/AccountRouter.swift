//
//  AccountRouter.swift
//  Zacon
//
//  Created by Mikhail Danilov on 28.11.2020.
//

import Foundation
import UIKit

protocol AccountRouterProtocol: AnyObject {

}

final class AccountRouter: AccountRouterProtocol {
    
    // MARK: Properties
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    // MARK: Internal helpers

}
