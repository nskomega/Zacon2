//
//  CameraView.swift
//  Zacon
//
//  Created by Mikhail Danilov on 04.12.2020.
//

import UIKit
import RxSwift
import CameraManager

class CameraView: UIView {

    private var viewModel: CameraViewModelProtocol?
    private let disposeBag = DisposeBag()
    private var cameraManager: CameraManager?
    
    private let cameraBord: UIView = {
        let camera = UIView()
        
        return camera
    }()
    
    private let closwButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let makeFoto: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        
        return button
    }()
    
    
    // MARK: Methods
    func setup(viewModel: CameraViewModelProtocol) {
        self.viewModel = viewModel
        
        self.backgroundColor = .black
        loadView()
        
        cameraManager = CameraManager()
        cameraManager?.addPreviewLayerToView(cameraBord)
        
        makeFoto.rx.tap.subscribe(onNext: { [weak self] _ in
            
            self?.cameraManager?.capturePictureWithCompletion({ result in
                switch result {
                case .failure:
                    // error handling
                    print("cameraManager>failure")
                case .success(let content):
                    print("cameraManager>success")
                    self?.viewModel?.rxImage.accept(content.asImage!)
                    self?.viewModel?.close()
                }
            })
            
        }).disposed(by: disposeBag)
        
        closwButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.close()
        }).disposed(by: disposeBag)
    }
    
    
    func loadView() {
        self.addSubview(cameraBord)
        self.addSubview(closwButton)
        self.addSubview(makeFoto)
        
        
        cameraBord.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        closwButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.left.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(40)
        }
        makeFoto.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
        }
        
    }
    
}
