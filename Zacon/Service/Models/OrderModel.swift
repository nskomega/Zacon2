//
//  OrderModel.swift
//  Zacon
//
//  Created by Mikhail Danilov on 20.12.2020.
//

import RealmSwift

class OrderRealModel: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var type = ""
    @objc dynamic var model = ""
    @objc dynamic var gosNomer = ""
    @objc dynamic var address = ""
    @objc dynamic var lat: Double = 0
    @objc dynamic var long: Double = 0
    @objc dynamic var name = ""
    @objc dynamic var surName = ""
    @objc dynamic var patronymic = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var date = ""
    @objc dynamic var foto1 = ""
    @objc dynamic var foto2 = ""
    @objc dynamic var foto3 = ""
    @objc dynamic var foto4 = ""
    @objc dynamic var foto5 = ""
}
