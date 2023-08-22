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
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .lightGray
            } else {
                backgroundColor = .white
            }
        }
    }
    
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
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Dimensions.sizeS),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Dimensions.sizeS),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Dimensions.sizeS),
            title.heightAnchor.constraint(equalToConstant: Dimensions.sizeXL),
            title.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Dimensions.sizeS),
        ])
    }
    
    func configure(with genre: Genre) {
        title.text = genre.name
    }
}
