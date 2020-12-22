//
//  TableView.swift
//  Zacon
//
//  Created by Mikhail Danilov on 28.11.2020.
//

import UIKit
import SnapKit
import RxSwift

class TableView: UIView {

    private var viewModel: TableViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    // MARK: - Constants
    private enum Constants {
        static let labelSetTitleTable = "Список обращений"
        static let labelTextSize20: CGFloat = 20
        static let constraint200: CGFloat = 200
        static let constraint250: CGFloat = 250
        static let constraint30: CGFloat = 30
        static let constraint8: CGFloat = 8
    }
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.labelSetTitleTable
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: Methods
    func setup(viewModel: TableViewModelProtocol) {
        self.viewModel = viewModel
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadView()
        
        self.viewModel?.rxTableReload.asObservable()
            .subscribe(onNext: { [weak self] image in
                self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func viewDidAppear() {
        self.viewModel?.loadMyOrders()
    }
    
    func loadView() {
        self.addSubview(titleLabel)
        self.addSubview(tableView)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(self).offset(40)
            $0.width.equalTo(Constants.constraint200)
            $0.height.equalTo(Constants.constraint30)
        }
        

        tableView.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.constraint8)
            $0.width.equalToSuperview().offset(-40)
            $0.bottom.equalToSuperview()
        }
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderTableViewCell()
        
        if let order = viewModel?.orders[indexPath.row] {
            cell.setconfig(order: order)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
