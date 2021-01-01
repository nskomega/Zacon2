//
//  СheckInView.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import UIKit
import RxSwift

class СheckInView: UIView {
    
    private var viewModel: СheckInViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    // MARK: - Constants
    private enum Constants {
        static let textFieldPlaceholderEmail = "Email"
        static let textFieldPlaceholderPassword = "Пароль"
        static let serNameTextFieldPlaceholder = "Фамилия"
        static let nameTextFieldPlaceholder = "Имя"
        static let patronymicTextFieldPlaceholder = "Отчетсво"
        static let telefonTextFieldPlaceholder = "Телефон"
        static let buttonSetTitleRegistration = "Регистрация"
        static let labelSetTitleRegistration = "Регистрация"
        static let labelTextSize25: CGFloat = 25
        static let constraint250: CGFloat = 250
        static let constraint200: CGFloat = 200
        static let constraint40: CGFloat = 40
        static let constraint30: CGFloat = 30
        static let constraint16: CGFloat = 16
        static let constraint60: CGFloat = 60
        static let constraint8: CGFloat = 8
    }

    // MARK: - Subviews
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.labelSetTitleRegistration
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize25)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let serNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.serNameTextFieldPlaceholder
        
        return textField
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.nameTextFieldPlaceholder
        
        return textField
    }()
    
    private let patronymicTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.patronymicTextFieldPlaceholder
        
        return textField
    }()
    
    private let telefonTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.telefonTextFieldPlaceholder
        
        return textField
    }()
    
    private let loginCheckInTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.textFieldPlaceholderEmail
        
        return textField
    }()
    
    private let passwordCheckInTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.textFieldPlaceholderPassword
        
        return textField
    }()
    
    private let checkInButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.buttonSetTitleRegistration, for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    // MARK: Methods
    func setup(viewModel: СheckInViewModelProtocol) {
        self.viewModel = viewModel
        
        checkInButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            guard let login = self.loginCheckInTextField.text,
                  let password = self.passwordCheckInTextField.text,
                  let name = self.nameTextField.text,
                  let surName = self.serNameTextField.text,
                  let patronymic = self.patronymicTextField.text,
                  let phone = self.telefonTextField.text
    
                  else { return }
            self.viewModel?.tapCheckIn(login: login, password: password, name: name, surName: surName, patronymic: patronymic, phone: phone)
        }).disposed(by: disposeBag)
        
        loadView()
    }
    
    func loadView() {
        self.addSubview(titleLabel)
        self.addSubview(serNameTextField)
        self.addSubview(nameTextField)
        self.addSubview(patronymicTextField)
        self.addSubview(telefonTextField)
        self.addSubview(loginCheckInTextField)
        self.addSubview(passwordCheckInTextField)
        self.addSubview(checkInButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self).offset(-Constants.constraint250)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        serNameTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        nameTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(serNameTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        patronymicTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(nameTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        telefonTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(patronymicTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        loginCheckInTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(telefonTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        passwordCheckInTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(loginCheckInTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        checkInButton.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(passwordCheckInTextField.snp.bottom).offset(Constants.constraint16)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint40)
        }
    }
}
