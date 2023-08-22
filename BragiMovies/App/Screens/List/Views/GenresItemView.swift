//
//  GenresItemView.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit

class GenresItemView: UICollectionViewCell {
    
    static let identifier = "GenresItemView"
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .horizontal)
        label.setContentHuggingPriority(.init(252), for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -

    private func setupUI() {
        backgroundColor = .white
        title.textColor = .black

        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: 40),
            
            title.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configure(with genre: Genre) {
        title.text = genre.name
    }
}
