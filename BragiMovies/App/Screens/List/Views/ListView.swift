//
//  ListView.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit

class ListView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Dimensions.sizeXXS
        layout.minimumLineSpacing = Dimensions.sizeS
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        showsHorizontalScrollIndicator = false
        register(ListItemView.self, forCellWithReuseIdentifier: ListItemView.identifier)
    }
}
