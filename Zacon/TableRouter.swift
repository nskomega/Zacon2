//
//  TableRouter.swift
//  Zacon
//
//  Created by Mikhail Danilov on 28.11.2020.
//

import Foundation
import UIKit

protocol TableRouterProtocol: AnyObject {

}

final class TableRouter: TableRouterProtocol {
    
    // MARK: Properties
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    // MARK: Internal helpers

}
