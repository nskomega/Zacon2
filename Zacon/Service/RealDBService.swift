//
//  DataBaseService.swift
//  Zacon
//
//  Created by Mikhail Danilov on 20.12.2020.
//

import Foundation
import RealmSwift

protocol DataBaseServiceProtocol {
    func saveOrder(order: Order)
    func deleteOrder(order: Order)
    func deleteOrders()
    func getMyOrders() -> [Order]
}


class RealDBService: DataBaseServiceProtocol {
    
    let realm = try! Realm()
    
    func deleteOrders() {
        
    }
    
    func getMyOrders() -> [Order] {
        var result = [Order]()
        
        let items = realm.objects(OrderRealModel.self)
        for obj in items {
            result.append(Order(orderModel: obj))
        }
        
        return result
    }
    
    
    func deleteOrder(order: Order) {
        
    }
    
    func saveOrder(order: Order) {
        let orderModel = order.toOrderRealModel()
        try! realm.write {
            realm.add(orderModel)
            print("save->real->", order.type)
        }
    }
    
    
}
