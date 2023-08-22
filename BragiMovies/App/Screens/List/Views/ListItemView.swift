//
//  ListItemView.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit
import RxCocoa
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
        addSubview(image)

        addSubview(title)
        addSubview(rating)
        addSubview(budget)
        addSubview(revenue)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Dimensions.sizeM),
            image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 0.5),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),

            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Dimensions.sizeS),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            rating.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Dimensions.sizeS),
            rating.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            rating.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            budget.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: Dimensions.sizeS),
            budget.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            budget.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            revenue.topAnchor.constraint(equalTo: budget.bottomAnchor, constant: Dimensions.sizeS),
            revenue.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            revenue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            revenue.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configure(with media: PageItem) {
        title.value.text = media.title
        rating.value.text = "\(media.voteAverage)"
        budget.value.text = "\(media.budget ?? .zero)"
        revenue.value.text = "\(media.revenue ?? .zero)"
        
        image.kf.setImage(
            with: media.imageURL,
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
