//
//  СheckInRouter.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import Foundation
import UIKit

protocol СheckInRouterProtocol: AnyObject {
    func showMainContainer()
}

final class СheckInRouter: СheckInRouterProtocol {
    
    // MARK: Properties
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    // MARK: Internal helpers
    
    func showMainContainer() {
        let mainContainer = MainContainerViewController()
        mainContainer.configure()
        
        viewController?.navigationController?.pushViewController(mainContainer, animated: true)
    }
    
}

