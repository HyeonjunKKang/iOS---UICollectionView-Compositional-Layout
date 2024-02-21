//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by 강현준 on 2/7/24.
//

import UIKit
import SnapKit
import Then

extension UIColor {
    static var randomColor: UIColor {
        let red = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        
        return .init(red: red, green: green, blue: blue, alpha: 1)
    }
}

struct DataSource {
    let index: Int
    let backbroundColor: UIColor
}

final class ViewController: UIViewController {
    
    enum Section {
        case first([DataSource])
        case second([DataSource])
        case third([DataSource])
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeCompositionalLayout()
    ).then {
        $0.register(Cell.self, forCellWithReuseIdentifier: Cell.defaultReuseIdentifier)
        $0.dataSource = self
        $0.backgroundColor = .white
    }
    
    private let dataSource: [Section] = [
        .first((1...6).map { DataSource(index: $0, backbroundColor: .randomColor)}),
        .second((1...2).map { DataSource(index: $0, backbroundColor: .randomColor)}),
        .third((1...5).map { DataSource(index: $0, backbroundColor: .randomColor)})
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, environment in
        
            switch section {
            case 0:
                let itemWidth = 1.0/3.0
                let groupHeight = 1.0/4.0
                let itemInset: CGFloat =  2.5
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemWidth),
                    heightDimension: .fractionalHeight(1)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupHeight)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            case 1:
                let itemWidth = 1.0/2.0
                let groupHeight = 1.0/5.0
                let itemInset: CGFloat =  0
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemWidth),
                    heightDimension: .fractionalHeight(1)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupHeight)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            default:
                let itemWidth = 1.0
                let groupHeight = 1.0/4.0
                let itemInset: CGFloat =  3
                
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemWidth),
                    heightDimension: .fractionalHeight(1)
                )
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupHeight)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch self.dataSource[section] {
        case let .first(items):
            return items.count
        case let .second(items):
            return items.count
        case let .third(items):
            return items.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.defaultReuseIdentifier, for: indexPath) as? Cell else { return UICollectionViewCell() }
        
        print("DEBUG: Section -- \(indexPath.section)")
        
        switch self.dataSource[indexPath.section] {
        case let .first(items):
            cell.initSetting(data: items[indexPath.item])
        case let .second(items):
            cell.initSetting(data: items[indexPath.item])
        case let .third(items):
            cell.initSetting(data: items[indexPath.item])
        }
        
        return cell
    }
}

