//
//  CategoryCell.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation
import UIKit
import SnapKit


protocol CategoryProtocol {
    func configureWith(viewModel: CategoryCellViewModel, indexPath: Int)
}

class CategoryCell: UICollectionViewCell {
    
   private enum Constants {
        static let selectedColor = UIColor(cgColor: CGColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2))
       static let deselectedColor = UIColor(red: 243/255, green: 245/255, blue: 249/255, alpha: 1)
       static let selectedFont = UIFont.systemFont(ofSize: 13, weight: .bold)
       static let deselectedFont = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    }
    
    override var isSelected: Bool {
        didSet {
            self.categoryLabel.backgroundColor = self.isSelected ? Constants.selectedColor : Constants.deselectedColor
            self.categoryLabel.font = self.isSelected ? Constants.selectedFont : Constants.deselectedFont
            contentView.layer.borderWidth = self.isSelected ? 0 : 1
        }
    }

     lazy var categoryLabel: UILabel = {
        let category = UILabel()
        category.textAlignment = .center
        category.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
        category.backgroundColor = Constants.deselectedColor
        category.font = UIFont.systemFont(ofSize: 13)
        return category
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    func setupLabel() {
        self.contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension CategoryCell: CategoryProtocol {
    func configureWith(viewModel: CategoryCellViewModel, indexPath: Int) {
        self.categoryLabel.text = viewModel.categories[indexPath].rawValue
    }
}
