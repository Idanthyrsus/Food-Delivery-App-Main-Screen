//
//  MainCell.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

protocol MainProtocol {
    func configure(using viewModel: MexicanFoodViewModel?)
}

class MainCell: UITableViewCell {
    
    private lazy var itemImage: UIImageView = {
        let item = UIImageView()
        item.clipsToBounds = true
        item.layer.masksToBounds = true
        item.contentMode = .scaleAspectFill
        item.backgroundColor = .white
        return item
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        label.font = UIFont(name: "SFUIDisplay-Semibold", size: 17)
        return label
    }()
    
    private lazy var itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.665, green: 0.668, blue: 0.679, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        label.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        label.font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        label.text = "от 345 р"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElements()
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setupElements() {
        self.contentView.addSubview(itemImage)
        self.contentView.addSubview(itemNameLabel)
        self.contentView.addSubview(itemDescriptionLabel)
        self.contentView.addSubview(itemPriceLabel)
        
        itemImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.width.equalTo(132)
        }
        
        itemNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(32)
            make.leading.equalTo(itemImage.snp.trailing).offset(32)
            make.height.equalTo(20)
            make.width.equalTo(136)
        }
        
        itemDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(itemImage.snp.trailing).offset(32)
            make.height.equalTo(48)
            make.width.equalTo(171)
        }
        
        itemPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(itemDescriptionLabel.snp.bottom).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
    }
}

extension MainCell: MainProtocol {
    func configure(using viewModel: MexicanFoodViewModel?) {
        guard let viewModel else {
            return
        }
        self.itemNameLabel.text = viewModel.title
        self.itemDescriptionLabel.text = viewModel.difficulty?.rawValue
        self.itemPriceLabel.text = viewModel.price
        self.itemImage.sd_setImage(with: URL(string: viewModel.image))
    }
}
