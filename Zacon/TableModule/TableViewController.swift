//
//  TableViewController.swift
//  Zacon
//
//  Created by Mikhail Danilov on 28.11.2020.
//

import UIKit

final class TableViewController: UIViewController {
    
    // MARK: Constants
    
    // MARK: Properties
    private var viewState = TableView()
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewState.viewDidAppear()
    }
    
    func setView(view: TableView) {
        self.viewState = view
        self.view = viewState
    }
    
    override func loadView() {
        super.loadView()
    }


    // MARK: IBActions

}
