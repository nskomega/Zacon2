//
//  CameraRouter.swift
//  Zacon
//
//  Created by Mikhail Danilov on 04.12.2020.
//

import Foundation
import UIKit

protocol CameraRouterProtocol: AnyObject {
    func close()
}

final class CameraRouter: CameraRouterProtocol {
    
    // MARK: Properties
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    // MARK: Internal helpers

    func close() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}

