//
//  ListItemView.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit
import Kingfisher

class ListItemView: UICollectionViewCell {
    
    static let identifier = "ListItemView"
    
    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .horizontal)
        imageView.setContentHuggingPriority(.init(252), for: .horizontal)
        return imageView
    }()
    
    lazy var line1: ListItemDataView = {
        let view = ListItemDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return view
    }()
    
    lazy var line2: ListItemDataView = {
        let view = ListItemDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return view
    }()

    lazy var line3: ListItemDataView = {
        let view = ListItemDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return view
    }()
    
    lazy var line4: ListItemDataView = {
        let view = ListItemDataView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        line1.translatesAutoresizingMaskIntoConstraints = false
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    private func setupUI() {
        backgroundColor = .white
        contentView.clipsToBounds = true
        addSubview(image)

        addSubview(line1)
        addSubview(line2)
        addSubview(line3)
        addSubview(line4)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Dimensions.sizeS),
            image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 0.5),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),

            line1.topAnchor.constraint(greaterThanOrEqualTo: image.bottomAnchor, constant: Dimensions.sizeXS),
            line1.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            line1.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            line2.topAnchor.constraint(greaterThanOrEqualTo: line1.bottomAnchor, constant: Dimensions.sizeXS),
            line2.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            line2.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            line3.topAnchor.constraint(greaterThanOrEqualTo: line2.bottomAnchor, constant: Dimensions.sizeXS),
            line3.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            line3.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            line4.topAnchor.constraint(greaterThanOrEqualTo: line3.bottomAnchor, constant: Dimensions.sizeXS),
            line4.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            line4.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func configure(with item: PageItem) {
        let lines = [line1, line2, line3, line4]
        item.lines
            .enumerated()
            .forEach { lineData in
                if lines.count > lineData.offset {
                    lines[lineData.offset].configure(with: lineData.element)
                }
        }
        
        image.kf.setImage(
            with: item.imageURL,
                options: [
                    .loadDiskFileSynchronously,
                    .cacheOriginalImage,
                    .transition(.fade(0.25)),
                ]
            )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.kf.cancelDownloadTask()
    }
}
