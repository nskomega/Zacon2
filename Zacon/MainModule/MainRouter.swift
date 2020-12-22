//
//  MainRouter.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import Foundation
import UIKit
import RxRelay

protocol MainRouterProtocol: AnyObject {
    func showCamera(rxImage: BehaviorRelay<UIImage>)
    func showTableVC()
}

final class MainRouter: MainRouterProtocol {
    
    // MARK: Properties
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    // MARK: Internal helpers

    
    func showCamera(rxImage: BehaviorRelay<UIImage>) {
        let cameraController = ModuleBuilder.cameraVC(rxImage: rxImage)
        cameraController.modalPresentationStyle = .fullScreen
        viewController?.present(cameraController, animated: true, completion: nil)
    }
    
    func showTableVC() {
        self.viewController?.tabBarController?.selectedIndex = 1
    }
}
