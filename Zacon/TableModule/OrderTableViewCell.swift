//
//  OrderTableViewCell.swift
//  Zacon
//
//  Created by Mikhail Danilov on 19.12.2020.
//

import UIKit
import SnapKit

class OrderTableViewCell: UITableViewCell {

    var order: Order?
    var uploadService = UploadService()
    
    // MARK: - Constants
    private enum Constants {
        static let labelTextSize16: CGFloat = 16
        static let labelTextSize20: CGFloat = 20
    }
    
    // MARK: - Subviews
    private let fotoImageview: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "nofoto")
        return imageview
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let gosNomerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let adressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(Constants.labelTextSize16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

   
    
    func setconfig(order: Order) {
        self.order = order
        self.typeLabel.text = order.type
        self.modelLabel.text = order.model
        self.gosNomerLabel.text = order.gosNomer
        self.adressLabel.text = order.address
        loadView()
    }
    
    func loadView() {
        self.addSubview(fotoImageview)
        self.addSubview(typeLabel)
        self.addSubview(modelLabel)
        self.addSubview(gosNomerLabel)
        self.addSubview(adressLabel)

        fotoImageview.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.right.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        typeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(8)
        }
        
        modelLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.top.equalTo(typeLabel.snp.bottom).offset(8)
        }
        
        gosNomerLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.top.equalTo(modelLabel.snp.bottom).offset(8)
        }
        
        adressLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.top.equalTo(gosNomerLabel.snp.bottom).offset(8)
        }
        
        loadImage()
    }
    
    
    func loadImage() {
        print(#function)
        guard let order = order else { return }
        print(order.id)
        if order.imgs.count == 0 {
            uploadService.loadImage(orderId: String(order.id)) { (imageFoto, error) in
                if let imageFoto = imageFoto {
                    self.fotoImageview.image = imageFoto
                }
            }
        } else {
            fotoImageview.image = order.imgs[0]
        }
        
    }
}
