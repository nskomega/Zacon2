//
//  Base64.swift
//  Zacon
//
//  Created by Mikhail Danilov on 20.12.2020.
//

import Foundation
import UIKit

func convertImageToBase64String (img: UIImage) -> String {
    return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
}
//
// Convert a base64 representation to a UIImage
//
func convertBase64StringToImage (imageBase64String: String) -> UIImage {
    let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
    let image = UIImage(data: imageData!)
    return image!
}
