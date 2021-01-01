//
//  ModuleBuilder.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import Foundation
import UIKit
import RxRelay

class ModuleBuilder {
    
    static func logInVC() -> UIViewController {
    
        let viewController = LoginInViewController()
        let view = LogInView()
        let router = LoginInRouter(viewController: viewController)
        let viewModel = LoginInViewModel(router: router)
        view.setup(viewModel: viewModel)
        viewController.view = view
        viewController.view.backgroundColor = .white

        return viewController
    }
    
    static func checkInVC() -> UIViewController {
        
        let viewController = СheckInViewController()
        let view = СheckInView()
        let router = СheckInRouter(viewController: viewController)
        let viewModel = СheckInViewModel(router: router)
        view.setup(viewModel: viewModel)
        viewController.view = view
        viewController.view.backgroundColor = .white
        
        return viewController
    }
    
    static func mainVC(dataBaseService: DataBaseServiceProtocol) -> UIViewController {
        
        let viewController = MainViewController()
        let view = MainView()
        let router = MainRouter(viewController: viewController)
        let viewModel = MainViewModel(router: router, dataBaseService: dataBaseService)
        view.setup(viewModel: viewModel)
        viewController.view = view
        viewController.view.backgroundColor = .white
        
        return viewController
    }
    
    static func tableVC(orderService: OrderService, dateBaseService: DataBaseServiceProtocol) -> UIViewController {
        
        let viewController = TableViewController()
        let view = TableView()
        let router = TableRouter(viewController: viewController)
        let viewModel = TableViewModel(router: router, orderService: orderService, dateBaseService: dateBaseService)
        view.setup(viewModel: viewModel)
        viewController.setView(view: view)
        viewController.view.backgroundColor = .white
        
        return viewController
    }
    
    static func accountVC() -> UIViewController {
        
        let viewController = AccountViewController()
        let view = AccountView()
        let router = AccountRouter(viewController: viewController)
        let viewModel = AccountViewModel(router: router)
        view.setup(viewModel: viewModel)
        viewController.view = view
        viewController.view.backgroundColor = .white
        
        return viewController
    }
    
    static func cameraVC(rxImage: BehaviorRelay<UIImage> ) -> UIViewController {
        
        let viewController = CameraViewController()
        let view = CameraView()
        let router = CameraRouter(viewController: viewController)
        let viewModel = CameraViewModel(router: router)
        viewModel.rxImage = rxImage
        
        view.setup(viewModel: viewModel)
        viewController.view = view
        
        return viewController
    }
}
