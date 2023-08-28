//
//  ListItemDataView.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import UIKit

class ListItemDataView: UIView {
    
    private struct Constants {
        static let numberOfLines = 2
        static let fontSize = 12.0
        static let valueTitleWidthRatio = 1.4
    }

    lazy var title: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = Constants.numberOfLines
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var value: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = Constants.numberOfLines
        label.font = UIFont.systemFont(ofSize: Constants.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
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
    
    func setupUI() {
        
        backgroundColor = .white

        addSubview(title)
        addSubview(value)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Dimensions.sizeS),
            title.trailingAnchor.constraint(equalTo: value.leadingAnchor, constant: -Dimensions.sizeS),
            title.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            value.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            value.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Dimensions.sizeS),
            value.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            value.widthAnchor.constraint(equalTo: title.widthAnchor, multiplier: Constants.valueTitleWidthRatio)
        ])
    }
    
    func configure(with line: PageItemDataLine) {
        title.text = line.title
        value.text = line.value
    }
}
