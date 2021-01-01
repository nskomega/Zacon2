//
//  Order.swift
//  Zacon
//
//  Created by Mikhail Danilov on 06.12.2020.
//

import UIKit


class Order {
    var id: Int
    var type: String
    var model: String
    var gosNomer: String
    var address: String
    var imgs = [UIImage]()
    var lat: Double = 0
    var long: Double = 0
    var name: String
    var surName: String
    var patronymic: String
    var email: String
    var phone: String
    var date: String
    
    init(id: Int = 0, type: String, model: String, gosNomer: String, address: String, name: String, surName: String, patronymic: String, email: String, phone: String) {
        self.id = id
        self.type = type
        self.model = model
        self.gosNomer = gosNomer
        self.address = address
        self.name = name
        self.surName = surName
        self.patronymic = patronymic
        self.email = email
        self.phone = phone
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy hh:mm:ss"
        self.date = formatter.string(from: date)
    }
    
    init(orderModel: OrderRealModel) {
        self.id = orderModel.id
        self.type = orderModel.type
        self.model = orderModel.model
        self.gosNomer = orderModel.gosNomer
        self.address = orderModel.address
        self.name = orderModel.name
        self.surName = orderModel.surName
        self.patronymic = orderModel.patronymic
        self.email = orderModel.email
        self.phone = orderModel.phone
        self.lat = orderModel.lat
        self.long = orderModel.long
        self.date = orderModel.date
        
        if !orderModel.foto1.isEmpty {
            imgs.append(convertBase64StringToImage(imageBase64String: orderModel.foto1))
        }
        if !orderModel.foto2.isEmpty {
            imgs.append(convertBase64StringToImage(imageBase64String: orderModel.foto2))
        }
        if !orderModel.foto3.isEmpty {
            imgs.append(convertBase64StringToImage(imageBase64String: orderModel.foto3))
        }
        if !orderModel.foto4.isEmpty {
            imgs.append(convertBase64StringToImage(imageBase64String: orderModel.foto4))
        }
        if !orderModel.foto5.isEmpty {
            imgs.append(convertBase64StringToImage(imageBase64String: orderModel.foto5))
        }
    }
    
    func toOrderRealModel() -> OrderRealModel {
        
        let orderModel = OrderRealModel()
        orderModel.id = id
        orderModel.type = type
        orderModel.model = model
        orderModel.gosNomer = gosNomer
        orderModel.address = address
        orderModel.name = name
        orderModel.surName = surName
        orderModel.patronymic = patronymic
        orderModel.email = email
        orderModel.phone = phone
        orderModel.date = date
        orderModel.lat = lat
        orderModel.long = long
        
        var num = 0
        for img in imgs {
            num += 1
            switch num {
            case 1:
                orderModel.foto1 = convertImageToBase64String(img: img)
            case 2:
                orderModel.foto2 = convertImageToBase64String(img: img)
            case 3:
                orderModel.foto3 = convertImageToBase64String(img: img)
            case 4:
                orderModel.foto4 = convertImageToBase64String(img: img)
            case 5:
                orderModel.foto5 = convertImageToBase64String(img: img)
            default:
                orderModel.foto5 = convertImageToBase64String(img: img)
            }
        }
        
        return orderModel
    }
    
}
