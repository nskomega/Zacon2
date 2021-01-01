//
//  LoginInRouter.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import Foundation
import UIKit

protocol LoginInRouterProtocol: AnyObject {
    func showCheckIn()
    func showMainContainer()
}

final class LoginInRouter: LoginInRouterProtocol {
    
    // MARK: Properties
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    // MARK: Internal helpers

    func showCheckIn() {
        let vc = ModuleBuilder.checkInVC()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMainContainer() {
        let mainContainer = MainContainerViewController()
        mainContainer.configure()
        
        viewController?.navigationController?.pushViewController(mainContainer, animated: true)
    }
}

