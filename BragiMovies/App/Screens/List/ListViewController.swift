//
//  ListViewController.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit
import RxSwift

class ListViewController: UIViewController {
    
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
        
        viewModel.genres.subscribe { [weak self] _ in
            self?.genresView.reloadData()
        }
        .disposed(by: bag)
        
        viewModel.selectedGenre.subscribe { [weak self] genre in
            guard let genre = genre else { return }
            self?.viewModel.loadPage(for: genre.id, page: 1)
        }
        .disposed(by: bag)
        
        viewModel.loadingState.subscribe { [weak self] state in
            switch state {
            case .empty:
                self?.listView.reloadData()
            case .loading: // TODO: add loading indicator here
                break
            case .loaded(let page):
                self?.listView.insertItems(at: page.indexPaths)
            }
        }
        .disposed(by: bag)
    }
}

extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === listView {
            return viewModel.listCount
        } else {
            return viewModel.genres.value.count
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
        cell.configure(with: viewModel.genres.value[indexPath.row])
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
        }
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === listView {
            return CGSize(width: (collectionView.frame.width / 2.0) - Dimensions.sizeSM, height: 150.0)
        } else {
            return CGSize(width: .max, height: .max)
        }
    }
}

extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === genresView {
            viewModel.didSelect(genreAt: indexPath.item)
        }
    }
}
