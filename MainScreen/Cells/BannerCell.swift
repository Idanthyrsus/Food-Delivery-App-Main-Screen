//
//  BannerCell.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import Foundation
import UIKit
import SnapKit

protocol BannerProtocol {
    func configureWith(viewModel: BannerCellViewModel, indexPath: Int)
}

class BannerCell: UICollectionViewCell {
    
    private lazy var bannerImage: UIImageView = {
        let banner = UIImageView()
        banner.clipsToBounds = true
        banner.layer.masksToBounds = true
        banner.contentMode = .scaleAspectFill
        banner.layer.cornerRadius = 10
        return banner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        self.contentView.addSubview(bannerImage)
        bannerImage.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .blue
    }
}

extension BannerCell: BannerProtocol {
    func configureWith(viewModel: BannerCellViewModel, indexPath: Int) {
        self.bannerImage.image = UIImage(named: viewModel.pictures[indexPath])
    }
}
