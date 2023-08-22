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
    
    lazy var title: ListItemDataView = {
        let view = ListItemDataView()
        view.title.text = "Title:"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return view
    }()
    
    lazy var rating: ListItemDataView = {
        let view = ListItemDataView()
        view.title.text = "Rating:"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return view
    }()

    lazy var budget: ListItemDataView = {
        let view = ListItemDataView()
        view.title.text = "Budget:"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return view
    }()
    
    lazy var revenue: ListItemDataView = {
        let view = ListItemDataView()
        view.title.text = "Revenue:"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        
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

        addSubview(title)
        addSubview(rating)
        addSubview(budget)
        addSubview(revenue)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Dimensions.sizeS),
            image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 0.5),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),

            title.topAnchor.constraint(greaterThanOrEqualTo: image.bottomAnchor, constant: Dimensions.sizeXS),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            rating.topAnchor.constraint(greaterThanOrEqualTo: title.bottomAnchor, constant: Dimensions.sizeXS),
            rating.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            rating.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            budget.topAnchor.constraint(greaterThanOrEqualTo: rating.bottomAnchor, constant: Dimensions.sizeXS),
            budget.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            budget.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            revenue.topAnchor.constraint(greaterThanOrEqualTo: budget.bottomAnchor, constant: Dimensions.sizeXS),
            revenue.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            revenue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func configure(with item: PageItem) {
        title.value.text = item.title
        rating.value.text = item.voteAverage
        budget.value.text = item.budget
        revenue.value.text = item.revenue
        
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
