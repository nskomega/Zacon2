//
//  LogInView.swift
//  Zacon
//
//  Created by Mikhail Danilov on 27.11.2020.
//

import UIKit
import SnapKit
import RxSwift

class LogInView: UIView {

    private var viewModel: LoginInViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    // MARK: - Constants
    private enum Constants {
        static let textFieldPlaceholderEmail = "Email"
        static let textFieldPlaceholderPassword = "Пароль"
        static let buttonSetTitleLogin = "Войти"
        static let buttonSetTitleRegistration = "Регистрация"
        static let labelSetTitleAutorization = "Авторизация"
        static let labelTextSize25: CGFloat = 25
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
        label.text = Constants.labelSetTitleAutorization
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize25)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.textFieldPlaceholderEmail
        textField.text = "234567@ya.ru"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.textFieldPlaceholderPassword
        textField.text = "123456"
        
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.buttonSetTitleLogin, for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let checkInButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.buttonSetTitleRegistration, for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    // MARK: Methods
    func setup(viewModel: LoginInViewModelProtocol) {
        self.viewModel = viewModel
        
        checkInButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.tapCheckInButton()
        }).disposed(by: disposeBag)
        
        logInButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            guard let login = self.loginTextField.text, let password = self.passwordTextField.text else { return }
            self.viewModel?.tapLogIn(login: login, password: password)
        }).disposed(by: disposeBag)
        
        loadView()
    }
    
    func loadView() {
        self.addSubview(titleLabel)
        self.addSubview(loginTextField)
        self.addSubview(passwordTextField)
        self.addSubview(logInButton)
        self.addSubview(checkInButton)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self).offset(-Constants.constraint200)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        loginTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(loginTextField.snp.bottom).offset(Constants.constraint8)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        
        logInButton.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Constants.constraint16)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint40)
        }
        
        checkInButton.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(logInButton.snp.bottom).offset(Constants.constraint16)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint40)
        }
    }
}
