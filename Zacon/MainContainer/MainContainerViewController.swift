//
//  MainContainerViewController.swift
//  Zacon
//
//  Created by Mikhail Danilov on 04.12.2020.
//

import UIKit

class MainContainerViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }

    func configure () {

        let orderService = OrderService()
        let dataBaseService = RealDBService()

        let mainView = ModuleBuilder.mainVC(dataBaseService: dataBaseService)
        let tableVC = ModuleBuilder.tableVC(orderService: orderService, dateBaseService: dataBaseService)
        let accountVC = ModuleBuilder.accountVC()
        
        let mainIcon =  UIImage(named: "house")?.withRenderingMode(.alwaysOriginal)
        let tableIcon =  UIImage(named: "copy")?.withRenderingMode(.alwaysOriginal)
        let accaountIcon =  UIImage(named: "avatar")?.withRenderingMode(.alwaysOriginal)
        
        let mainViewButton = UITabBarItem(title: "Главная", image: mainIcon, tag: 0)
        let tableVCButton = UITabBarItem(title: "Обращения", image: tableIcon, tag: 1)
        let accountVCButton = UITabBarItem(title: "Аккаунт", image: accaountIcon, tag: 2)
        

        
        //tabBar.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.brown], for: .normal)
        
        tableVC.tabBarItem = tableVCButton
        accountVC.tabBarItem = accountVCButton
        mainView.tabBarItem = mainViewButton
        
        mainView.tabBarItem.imageInsets.top = 90
        mainView.tabBarItem.imageInsets.bottom = 90
        
        accountVC.tabBarItem.imageInsets.top = 90
        accountVC.tabBarItem.imageInsets.bottom = 90
        
        tableVC.tabBarItem.imageInsets.top = 16
        tableVC.tabBarItem.imageInsets.bottom = 16
        
        self.viewControllers = [mainView, tableVC, accountVC]
        
    }
    
}

extension MainContainerViewController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
          return false // Make sure you want this as false
        }

        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionFlipFromLeft], completion: nil)
        }

        return true
    }
}
