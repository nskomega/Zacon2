//
//  AccountView.swift
//  Zacon
//
//  Created by Mikhail Danilov on 28.11.2020.
//

import UIKit
import SnapKit
import RxSwift

class AccountView: UIView {

    private var viewModel: AccountViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    // MARK: - Constants
    private enum Constants {
        static let labelSetTitleAccount = "Аккаунт"
        static let labelTextSize20: CGFloat = 20
        static let constraint200: CGFloat = 200
        static let constraint250: CGFloat = 250
        static let constraint30: CGFloat = 30
        static let constraint8: CGFloat = 8
    }
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.labelSetTitleAccount
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    // MARK: Methods
    func setup(viewModel: AccountViewModelProtocol) {
        self.viewModel = viewModel
        
        loadView()
    }
    
    func loadView() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self).offset(-Constants.constraint250)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
    }
}
