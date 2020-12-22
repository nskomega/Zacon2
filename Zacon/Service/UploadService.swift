//
//  UploadService.swift
//  Zacon
//
//  Created by Mikhail Danilov on 06.12.2020.
//

import Firebase
import FirebaseStorage
import UIKit

class UploadService {
    
    func uploadImage(orderId: String, fileName: String, file: Data, _ completion:  @escaping (_ photoUrl: String?, _ error: Error?) -> Void ) {
        let storageRef = Storage.storage().reference().child("orders/\(orderId)/images/\(fileName).jpg")
        
        storageRef.putData(file, metadata: nil) { (metadata, error) in
            if error != nil {
                completion(nil, error)
            }
            storageRef.downloadURL(completion: { (url, error) in
                completion(url?.absoluteString, error)
            })
        }
    }
    
    func loadImage (orderId: String,  _ completion:  @escaping (_ image: UIImage?, _ error: String?) -> Void ) {
    
        let fileName = "orders/" + String(orderId) + "/images/order_" + String(orderId) + "_2.jpg"
        let storageRef = Storage.storage().reference()
        let islandRef = storageRef.child(fileName)

        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            completion(nil, error.localizedDescription)
          } else {
            let image = UIImage(data: data!)
            completion(image, nil)
          }
        }
        
    }
    
}
