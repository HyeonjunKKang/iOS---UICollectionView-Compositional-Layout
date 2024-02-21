//
//  Cell.swift
//  CompositionalLayout
//
//  Created by 강현준 on 2/7/24.
//

import UIKit
import SnapKit

public extension UICollectionViewCell {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

final class Cell: UICollectionViewCell {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    public func initSetting(data: DataSource) {
        label.text = "\(data.index)"
        contentView.backgroundColor = data.backbroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
