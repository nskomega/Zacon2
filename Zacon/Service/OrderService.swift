//
//  OrderService.swift
//  Zacon
//
//  Created by Mikhail Danilov on 06.12.2020.
//

import Foundation
import Firebase

class OrderService {
    
    var ref: DatabaseReference?
 
    func saveOrder( order: Order, completion: @escaping (_ success: Bool, _ orderId: String, _ error: String ) -> Void) {
        let userId = ProfileService.shared.userId
        let number = Int.random(in: 0 ... 99999999999)
        
        ref = Database.database().reference(withPath: "orders").child(userId)
        let userRef = self.ref?.child(String(number))
        userRef?.setValue([
            "type" : order.type,
            "gosNomer" : order.gosNomer,
            "address" : order.address,
            "model" : order.model,
            "name" : order.name,
            "patronymic" : order.patronymic,
            "surName" : order.surName,
            "phone" : order.phone,
            "email" : order.email,
            "date" : order.date,
            "lat" : order.lat,
            "long" : order.long,
        ])
        completion(true, String(number), "")
    }
    
    func getMayOrders( completion: @escaping (_ success: Bool, _ orders: [Order], _ error: String ) -> Void) {
        print(#function)
        let userId = ProfileService.shared.userId
        var result = [Order]()
        
        ref = Database.database().reference(withPath: "orders").child(userId)
        ref?.observe(.value, with: { (snapshot) in
            for item in snapshot.children {
                if let subitems = item as? DataSnapshot {
                    print("value->",(item as? DataSnapshot)?.value)
                    
                    var id = Int( (item as? DataSnapshot)?.key ?? "0") ?? 0
                    print("id->", id)
                    var type = ""
                    var model = ""
                    var gosNomer = ""
                    var address = ""
                    var name = ""
                    var surName = ""
                    var patronymic = ""
                    var email = ""
                    var phone = ""
                    var date = ""
                    var lat: Double = 0
                    var long: Double = 0
                    
                    for subitem in subitems.children {
                        if let data = subitem as? DataSnapshot {
                            let value: String = data.value as? String ?? ""
                            print(data.key,"--->-->", value)
                            switch data.key {
                            case "type":
                                type = value
                            case "gosNomer":
                                gosNomer = value
                            case "model":
                                model = value
                            case "address":
                                address = value
                            case "email":
                                email = value
                            case "name":
                                name = value
                            case "surName":
                                surName = value
                            case "patronymic":
                                patronymic = value
                            case "phone":
                                phone = value
                            case "date":
                                date = value
                            case "lat":
                                lat = Double (value) ?? 0
                            case "long":
                                long = Double (value) ?? 0

                            default:
                                print("чтото пошло не так")
                            }
                        }
                    }
                    
                    let order = Order(id: id, type: type, model: model, gosNomer: gosNomer, address: address, name: name, surName: surName, patronymic: patronymic, email: email, phone: phone)
                    order.lat = lat
                    order.long = long
                    order.date = date
                    print("new order->", order.date)
                    result.append(order)
                }
            }
            completion(true, result, "")
        }
        
        ) { (error) in
            completion(false, result, "")
            print(error.localizedDescription)
        }
        
       
    }
}
