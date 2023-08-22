//
//  GenresView.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit

class GenresView: UICollectionView {

    // MARK: -

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    func setupUI() {
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        register(GenresItemView.self, forCellWithReuseIdentifier: GenresItemView.identifier)
    }
}
