//
//  MainView.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture
import RxCocoa



class MainView: UIView {
    
    private var viewModel: MainViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    // MARK: - Constants
    private enum Constants {
        static let labelSetTitleAdd = "Добавить обращение"
        static let typeOfViolationTextFieldPlaceholder = "Тип нарушения"
        static let markaAndModelTextFieldPlaceholder = "Марка машины и модель"
        static let licensePlateTextFieldPlaceholder = "Госномер"
        static let buttonSetTitleSend = "Отправить"
        static let addressPlateTextFieldPlaceholder = "Добавить адрес"
        static let labelTextSize20: CGFloat = 20
        static let constraint200: CGFloat = 200
        static let constraint250: CGFloat = 250
        static let constraint40: CGFloat = 40
        static let constraint30: CGFloat = 30
        static let constraint24: CGFloat = 24
        static let constraint16: CGFloat = 16
        static let constraint60: CGFloat = 60
        static let constraint8: CGFloat = 8
    }

    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.labelSetTitleAdd
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let addFotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nofoto"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.4)

        return button
    }()
    private let imageView1: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    private let imageView2: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    private let imageView3: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    private let imageView4: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    private let imageView5: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    
    private let typeOfViolationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.typeOfViolationTextFieldPlaceholder
        
        return textField
    }()
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.isHidden = true
        
        return indicator
    }()
    
    private let markaAndModelTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.markaAndModelTextFieldPlaceholder
        
        return textField
    }()
    
    private let licensePlateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.licensePlateTextFieldPlaceholder
        
        return textField
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.addressPlateTextFieldPlaceholder
        
        return textField
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.buttonSetTitleSend, for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    // MARK: Methods
    func setup(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        loadView()
        
        addFotoButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                print("addFotoButton.rx.tap")
                self?.viewModel?.tapShowCamera()
        }).disposed(by: disposeBag)
        
        self.viewModel?.isPrccesing.asObservable()
            .subscribe(onNext: { [weak self] value in
                if value {
                    self?.indicatorView.isHidden = false
                    self?.indicatorView.startAnimating()
                    self?.sendButton.isEnabled = false
                } else {
                    //TODO надо очистить все поля потом
                    self?.indicatorView.isHidden = true
                    self?.indicatorView.stopAnimating()
                    self?.sendButton.isEnabled = true
                }
        }).disposed(by: disposeBag)
        
        
        self.viewModel?.rxImage.asObservable()
            .subscribe(onNext: { [weak self] image in
                if image.size.width > 0 {
                    viewModel.images.append(image)
                    guard viewModel.images.count > 0 else { return }
                    self?.imageView1.image = viewModel.images[0]
                    guard viewModel.images.count > 1 else { return }
                    self?.imageView2.image = viewModel.images[1]
                    guard viewModel.images.count > 2 else { return }
                    self?.imageView3.image = viewModel.images[2]
                    guard viewModel.images.count > 3 else { return }
                    self?.imageView4.image = viewModel.images[3]
                    guard viewModel.images.count > 4 else { return }
                    self?.imageView5.image = viewModel.images[4]
                }
                
        }).disposed(by: disposeBag)
        
        sendButton.rx.tap.subscribe(onNext: { [weak self] _ in
            print(#function)
            guard let self = self else { return }
            guard let type = self.typeOfViolationTextField.text,
                  let model = self.markaAndModelTextField.text,
                  let gosNomer = self.licensePlateTextField.text,
                  let address = self.addressTextField.text
                  else { return }
            print("tapSave")
            self.viewModel?.tapSave(type: type, model: model, gosNomer: gosNomer, address: address)
        }).disposed(by: disposeBag)
        
    }
    
    func loadView() {
        self.addSubview(titleLabel)
        self.addSubview(typeOfViolationTextField)
        self.addSubview(markaAndModelTextField)
        self.addSubview(licensePlateTextField)
        self.addSubview(addressTextField)
        self.addSubview(sendButton)
        self.addSubview(addFotoButton)
        self.addSubview(imageView1)
        self.addSubview(imageView2)
        self.addSubview(imageView3)
        self.addSubview(imageView4)
        self.addSubview(imageView5)
        self.addSubview(indicatorView)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-Constants.constraint250)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        typeOfViolationTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        markaAndModelTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(typeOfViolationTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        licensePlateTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(markaAndModelTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        addressTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(licensePlateTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        addFotoButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Constants.constraint24)
            $0.top.equalTo(addressTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint40)
            $0.height.equalTo(Constants.constraint40)
        }
        
        imageView1.snp.makeConstraints {
            $0.left.equalTo(addFotoButton.snp.right).offset(Constants.constraint8)
            $0.centerY.equalTo(addFotoButton)
            $0.width.equalTo(Constants.constraint40)
            $0.height.equalTo(Constants.constraint40)
        }
        
        imageView2.snp.makeConstraints {
            $0.left.equalTo(imageView1.snp.right).offset(Constants.constraint8)
            $0.centerY.equalTo(addFotoButton)
            $0.width.equalTo(Constants.constraint40)
            $0.height.equalTo(Constants.constraint40)
        }
        
        imageView3.snp.makeConstraints {
            $0.left.equalTo(imageView2.snp.right).offset(Constants.constraint8)
            $0.centerY.equalTo(addFotoButton)
            $0.width.equalTo(Constants.constraint40)
            $0.height.equalTo(Constants.constraint40)
        }
        imageView4.snp.makeConstraints {
            $0.left.equalTo(imageView3.snp.right).offset(Constants.constraint8)
            $0.centerY.equalTo(addFotoButton)
            $0.width.equalTo(Constants.constraint40)
            $0.height.equalTo(Constants.constraint40)
        }
        imageView5.snp.makeConstraints {
            $0.left.equalTo(imageView4.snp.right).offset(Constants.constraint8)
            $0.centerY.equalTo(addFotoButton)
            $0.width.equalTo(Constants.constraint40)
            $0.height.equalTo(Constants.constraint40)
        }
        
        
        sendButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Constants.constraint250)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint40)
        }
        
        indicatorView.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self)
            $0.width.height.equalTo(Constants.constraint200)
        }
        
    }
}
