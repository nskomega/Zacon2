//
//  UIImage + extension.swift
//  Zacon
//
//  Created by Mikhail Danilov on 06.12.2020.
//

import Foundation
import UIKit

public extension UIImage {
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
         guard let data = compressedData(quality: quality) else { return nil }
         return UIImage(data: data)
     }
     func compressedData(quality: CGFloat = 0.5) -> Data? {
         return jpegData(compressionQuality: quality)
     }
}
