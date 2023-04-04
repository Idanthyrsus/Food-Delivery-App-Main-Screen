//
//  ViewController.swift
//  MainScreen
//
//  Created by Alexander Korchak on 03.04.2023.
//

import UIKit
import SnapKit

protocol HomeView: AnyObject {
    func updateTable(with pizzasList: [MexicanFoodViewModel])
    func displaySelected(category: CategoryType)
}

class HomeViewController: UIViewController {
    
    private enum Dimensions {
        static let upperViewHeight: CGFloat = 302
        static let upperViewReducedHeight: CGFloat = 160
        static let categoryTop: CGFloat = 20
        static let bannerViewHeight: CGFloat = 120
    }
    
    var presenter: HomePresenting?
    let background = UIColor(red: 243/255, green: 245/255, blue: 249/255, alpha: 1)
    var banners: BannerCellViewModel = .init()
    var categories: CategoryCellViewModel = .init()
    var foodList: [MexicanFoodViewModel] = []
  
    var categoryTopConstraint: Constraint?
    var bannerHeightConstraint: Constraint?
    var upperViewHeight: Constraint?
    
    var list: [String: [MexicanFoodViewModel]] = [:]

    private lazy var upperView: UIView = {
        let navigationView = UIView()
        navigationView.backgroundColor = background
        return navigationView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Москва"
        label.backgroundColor = background
        label.textColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        label.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
        return label
    }()
    
    private lazy var chevronImage: UIImageView = {
        let chevron = UIImageView()
        chevron.image = UIImage(named: "Chevron")
        return chevron
    }()
    
    private lazy var bannerCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 112)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 2)
        layout.minimumLineSpacing = 16
        let banner = UICollectionView(frame: .zero, collectionViewLayout: layout)
        banner.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseIdentifier)
        banner.showsHorizontalScrollIndicator = false
        banner.backgroundColor = background
        return banner
    }()
    
    private lazy var categoriesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 88, height: 32)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 16, bottom: 2, right: 2)
        layout.minimumLineSpacing = 8
        let categories = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categories.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        categories.showsHorizontalScrollIndicator = false
        categories.backgroundColor = background
        categories.layer.cornerRadius = 12
        return categories
    }()
    
    private lazy var mainTable: UITableView = {
        let mainTable = UITableView(frame: .zero, style: .plain)
        mainTable.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseIdentifier)
        mainTable.showsVerticalScrollIndicator = false
        mainTable.layer.cornerRadius = 16
        mainTable.backgroundColor = background
        return mainTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = background
        presenter?.viewDidLoad()
        setupUpperView()
        setUpperViewElements()
        mainTable.delegate = self
        mainTable.dataSource = self
        bannerCollection.delegate = self
        bannerCollection.dataSource = self
        categoriesCollection.delegate = self
        categoriesCollection.dataSource = self
        
    }
    
    private func setupUpperView() {
        self.view.addSubview(upperView)
        
        upperView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            self.upperViewHeight = make.height.equalTo(Dimensions.upperViewHeight).constraint
        }
    }
    
    private func setUpperViewElements() {
        self.upperView.addSubview(locationLabel)
        self.upperView.addSubview(chevronImage)
        self.upperView.addSubview(bannerCollection)
        self.upperView.addSubview(categoriesCollection)
        self.view.addSubview(mainTable)
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.top).offset(60)
            make.leading.equalTo(upperView.snp.leading).offset(16)
            make.height.equalTo(20)
            make.width.equalTo(61)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.top.equalTo(upperView.snp.top).offset(67)
            make.leading.equalTo(locationLabel.snp.trailing).offset(8)
            make.height.equalTo(8)
            make.width.equalTo(14)
        }
        
        bannerCollection.snp.makeConstraints { make in
            make.top.equalTo(self.upperView.snp.top).offset(104)
            make.leading.trailing.equalToSuperview()
            self.bannerHeightConstraint = make.height.equalTo(Dimensions.bannerViewHeight).constraint
        }
        
        categoriesCollection.snp.makeConstraints { make in
            self.categoryTopConstraint = make.top.equalTo(self.bannerCollection.snp.bottom).offset(20).constraint
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(36)
        }
        
        mainTable.snp.makeConstraints { make in
            make.top.equalTo(self.upperView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: HomeView {
    func updateTable(with mealsList: [MexicanFoodViewModel]) {
        var easy: [MexicanFoodViewModel] = []
        var medium: [MexicanFoodViewModel] = []
        mealsList.forEach {
            switch $0.difficulty {
            case .easy:
                easy.append($0)
            case .medium:
                medium.append($0)
            default:
                return
            }
        }
        self.list = ["Easy" : easy, "Medium" : medium]
      //  self.foodList = mealsList
        Task {
            await MainActor.run(body: {
                self.mainTable.reloadData()
            })
        }
     }
    func displaySelected(category: CategoryType) {
        guard let index = categories.categories.firstIndex(of: category) else {
            return
        }
        mainTable.scrollToRow(at: IndexPath(item: 0, section: index), at: .top, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        list.keys.count
    }
  }

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollection:
            return banners.pictures.count
        case categoriesCollection:
            return categories.categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bannerCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIdentifier, for: indexPath) as? BannerCell else {
                return UICollectionViewCell()
            }
            let viewModel = banners
            cell.configureWith(viewModel: viewModel, indexPath: indexPath.row)
            return cell
            
        case categoriesCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell else {
                return UICollectionViewCell()
            }
            let viewModel = categories
            cell.configureWith(viewModel: viewModel, indexPath: indexPath.row)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoriesCollection:
           if indexPath.row < 2 {
                let category = categories.categories[indexPath.row]
                presenter?.select(category: category)
            }
        default:
            break
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories.categories[section]
        return list[category.rawValue]?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.reuseIdentifier, for: indexPath) as? MainCell else {
            return UITableViewCell()
        }
        let viewModel = categories.categories[indexPath.section]
        let newViewModel = list[viewModel.rawValue]?[indexPath.row]
        cell.configure(using: newViewModel)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        let swipingDown = y <= 0
        let shouldSnap = y > 30
        
        UIView.animate(withDuration: 0.3) {
            self.bannerCollection.alpha = swipingDown ? 1.0 : 0.0
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) {
                let upperViewHeight = shouldSnap ? Dimensions.upperViewReducedHeight : Dimensions.upperViewHeight
                self.upperViewHeight?.update(offset: upperViewHeight)
                let bannerHeight = shouldSnap ? 0 : Dimensions.bannerViewHeight
                self.bannerHeightConstraint?.update(offset: bannerHeight)
                let categoryOffset = shouldSnap ? 0 : Dimensions.categoryTop
                self.categoryTopConstraint?.update(offset: categoryOffset)
                self.view.layoutIfNeeded()
            }
        }
    }
}
