//
//  TableViewModel.swift
//  Zacon
//
//  Created by Mikhail Danilov on 28.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol TableViewModelProtocol: AnyObject {
    var rxTableReload: BehaviorRelay<Bool> { get }
    func loadMyOrders()
    var orders: [Order]{ get }
}

final class TableViewModel: TableViewModelProtocol {

    // MARK: Constants

    // MARK: Properties
    private let router: TableRouter
    private let orderService: OrderService
    private let dateBaseService: DataBaseServiceProtocol
    var orders = [Order]()
    var rxTableReload = BehaviorRelay<Bool>(value: false)

    
    init(router: TableRouter, orderService: OrderService, dateBaseService: DataBaseServiceProtocol) {
        self.router = router
        self.orderService = orderService
        self.dateBaseService = dateBaseService
    }
    
    // MARK: Methods
    func loadMyOrders() {
        orderService.getMayOrders { [weak self] (state, orders, errorText) in
            if state {
             self?.orders = orders
             self?.rxTableReload.accept(true)
            } else {
                self?.loadMyOrdersLocalStorage()
            }
        }
    }
    
    func loadMyOrdersLocalStorage() {
        orders = dateBaseService.getMyOrders()
        
        for obj in orders {
            print("loadMyOrdersLocalStorage>", obj.type,"->" ,obj.imgs.count)
        }
        
        rxTableReload.accept(true)
    }
}
