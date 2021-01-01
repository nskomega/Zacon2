//
//  CameraViewModel.swift
//  Zacon
//
//  Created by Mikhail Danilov on 04.12.2020.
//

import Foundation
import RxSwift
import RxCocoa

protocol CameraViewModelProtocol: AnyObject {
    var rxImage: BehaviorRelay<UIImage> { get set }
    func close()
}

final class CameraViewModel: CameraViewModelProtocol {

    // MARK: Constants

    // MARK: Properties
    private let router: CameraRouter
    var rxImage = BehaviorRelay<UIImage>(value: UIImage())

    init(router: CameraRouter) {
        self.router = router
    }
    
    func close() {
        router.close()
    }
    // MARK: Methods
    
}
