//
//  ListViewController.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit
import RxSwift

class ListViewController: UIViewController {
    
    private struct Constants {
        static let itemCellHeight = 160.0
        static let estimatedGenreCellWidth = 300.0
    }
    
    // MARK: -
    
    lazy var genresView: GenresView = {
        let view = GenresView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var listView: ListView = {
        let view = ListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: ListViewModelProtocol
    
    private var bag = DisposeBag()
    private var template = GenresItemView()
    
    // MARK: -
    
    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadGenres()
    }
    
    // MARK: -
    
    func setupUI() {
        
        genresView.dataSource = self
        genresView.delegate = self
        
        listView.dataSource = self
        listView.delegate = self
        
        view.addSubview(genresView)
        view.addSubview(listView)
        
        NSLayoutConstraint.activate([
            genresView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            genresView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            genresView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            genresView.heightAnchor.constraint(equalToConstant: Dimensions.sizeXXL),
            
            listView.topAnchor.constraint(equalTo: genresView.bottomAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupBindings() {
        viewModel.state
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] state in
                guard let self = self else {
                    return
                }
                switch state {
                case .finishedLoadingGenres:
                    self.genresView.reloadData()
                    self.viewModel.didSelect(genreAt: .zero)
                case .genreChange(let oldIndex, let newIndex):
                    var indexPaths: [IndexPath] = []
                    if let newIndex = newIndex, self.viewModel.genres.count > newIndex {
                        self.viewModel.loadPage(for: self.viewModel.genres[newIndex].id, page: 1)
                        indexPaths.append(IndexPath(item: newIndex, section: .zero))
                    }
                    if let oldIndex = oldIndex, self.viewModel.genres.count > oldIndex {
                        indexPaths.append(IndexPath(item: oldIndex, section: .zero))
                    }
                    UIView.performWithoutAnimation {
                        self.genresView.reloadItems(at: indexPaths)
                    }
                case .empty:
                    self.listView.reloadData()
                case .loading: // TODO: add loading indicator here
                    break
                case .loaded(let page):
                    self.listView.insertItems(at: page.indexPaths)
                }
            })
            .disposed(by: bag)
    }
}

extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === listView {
            return viewModel.listCount
        } else {
            return viewModel.genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === listView {
            return mediaCell(collectionView , for: indexPath)
        } else {
            return genreCell(collectionView , for: indexPath)
        }
    }
    
    private func genreCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GenresItemView.identifier,
            for: indexPath
        ) as? GenresItemView else {
            return UICollectionViewCell()
        }
        let genre = viewModel.genres[indexPath.row]
        cell.isSelected = viewModel.isGenreSelected(at: indexPath.item)
        cell.configure(with: genre)
        return cell
    }
    
    private func mediaCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListItemView.identifier,
            for: indexPath
        ) as? ListItemView else {
            return UICollectionViewCell()
        }
        if viewModel.list.count > indexPath.row {
            cell.configure(with: viewModel.list[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView === listView {
            viewModel.preloadIfNeeded(for: indexPath.item)
        } else {
            cell.isSelected = viewModel.isGenreSelected(at: indexPath.item)
        }
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === listView {
            return CGSize(width: (collectionView.frame.width / 2.0) - Dimensions.sizeXS, height: Constants.itemCellHeight)
        } else {
            return CGSize(width: Constants.estimatedGenreCellWidth, height: Dimensions.sizeXL)
        }
    }
}

extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === genresView {
            viewModel.didSelect(genreAt: indexPath.item)
            listView.setContentOffset(.zero, animated: true)
        }
    }
}

