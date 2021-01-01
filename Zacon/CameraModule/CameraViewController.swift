//
//  CameraViewController.swift
//  Zacon
//
//  Created by Mikhail Danilov on 04.12.2020.
//

import UIKit

final class CameraViewController: UIViewController {
    // MARK: Constants

    // MARK: Properties

    private var viewModel: CameraViewModelProtocol?

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
    }

    // MARK: Methods
    func setup(viewModel: CameraViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: IBActions

}

