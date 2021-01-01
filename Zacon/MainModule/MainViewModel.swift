//
//  MainViewModel.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

protocol MainViewModelProtocol: AnyObject {
    func tapShowCamera()
    var rxImage: BehaviorRelay<UIImage> { get set }
    var images: [UIImage] { get set }
    func tapSave(type: String, model: String, gosNomer: String, address: String )
    var isPrccesing: BehaviorRelay<Bool> { get }
}

final class MainViewModel: MainViewModelProtocol {

    // MARK: Constants

    // MARK: Properties
    private let router: MainRouter
    let locationService = LocationService()
    let orderService = OrderService()
    let uploadService = UploadService()
    let dataBaseService: DataBaseServiceProtocol?
    
    var rxImage = BehaviorRelay<UIImage>(value: UIImage())
    var isPrccesing = BehaviorRelay<Bool>(value: false)
    var images = [UIImage]()
    var disposeBag = DisposeBag()
    
    init(router: MainRouter, dataBaseService: DataBaseServiceProtocol) {
        self.router = router
        rxImage.accept(UIImage())
        locationService.start()
        self.dataBaseService = dataBaseService
    }
    
    // MARK: Methods
    func tapShowCamera() {
        router.showCamera(rxImage: rxImage)
    }
    
    func tapSave(type: String, model: String, gosNomer: String, address: String ) {
        isPrccesing.accept(true)
        
        let profile = ProfileService.shared.myUserProfile        
        let order = Order(type: type,
                          model: model,
                          gosNomer: gosNomer,
                          address: address,
                          name: profile.name,
                          surName: profile.surName,
                          patronymic: profile.patronymic,
                          email: profile.email,
                          phone: profile.phone)
        order.imgs = self.images
        order.lat = locationService.location.latitude
        order.long = locationService.location.longitude

        print("order.lat>",order.lat)
        
        dataBaseService?.saveOrder(order: order)
        
        orderService.saveOrder(order: order) { [weak self] (success, orderId, erorr) in
            print("save->fb")
            var index = 0
            if order.imgs.count == 0 {
                self?.isPrccesing.accept(false)
                self?.router.showTableVC()
            }
            for img in order.imgs {
                index += 1
                let fileName = "order_" + orderId + "_" + String(index)
                if let photoData = img.compressedData(quality: 0.2) , index > 1 {
                    self?.uploadService.uploadImage(orderId: orderId, fileName: fileName, file: photoData, { (text, error) in
                        if order.imgs.count == index {
                            self?.isPrccesing.accept(false)
                            self?.router.showTableVC()
                        }
                    })
                }
            }
        }
       
    }
}
