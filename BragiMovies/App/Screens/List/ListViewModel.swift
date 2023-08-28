//
//  ListViewModel.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation
import RxSwift
import RxRelay

protocol ListViewModelProtocol {
    var title: String { get }
    var type: MediaType { get }
    
    var genres: [Genre] { get }
    var selectedGenre: Int? { get }
    
    var listCount: Int { get }
    var list: [PageItem] { get }
    
    var state: BehaviorRelay<ListState> { get }
    
    func loadGenres()
    func didSelect(genreAt index: Int)
    func isGenreSelected(at index: Int) -> Bool
    
    func loadPage(for genreID: Int, page: Int)
    func preloadIfNeeded(for index: Int)
}

class ListViewModel: ListViewModelProtocol {
    
    // MARK: -
    
    let title: String
    let type: MediaType
    let tmdbUseCase: TMDBUseCaseProtocol
    
    let state: BehaviorRelay<ListState> = BehaviorRelay<ListState>(value: .empty)
    
    var genres: [Genre] = []
    var selectedGenre: Int? = nil
    
    var pages: [Page] = []
    var listCount: Int {
        pages.reduce(0) { partialResult, page in
            partialResult + page.items.count
        }
    }
    var list: [PageItem] {
        var list: [PageItem] = []
        for page in pages.map(\.items) {
            list.append(contentsOf: page)
        }
        return list
    }
    
    private var bag = DisposeBag()
    
    // MARK: -
    
    init(type: MediaType, tmdbUseCase: TMDBUseCaseProtocol) {
        self.type = type
        self.title = type.rawValue
        self.tmdbUseCase = tmdbUseCase
    }
    
    // MARK: -
    
    func loadGenres() {
        tmdbUseCase.listGenres(for: type)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] items in
                self?.genres = items
                self?.selectedGenre = .zero
                self?.state.accept(.finishedLoadingGenres)
            })
            .disposed(by: bag)
    }
    
    func loadPage(for genreID: Int, page: Int) {
        state.accept(.loading(page: page))
        switch type {
        case .movie:
            loadMovies(for: genreID, page: page)
        case .tv:
            loadTVShows(for: genreID, page: page)
        }
    }
    
    private func loadMovies(for genreID: Int, page: Int) {
        let handle: Single<ListPage<Movie>> = tmdbUseCase
            .listMovies(for: type, with: genreID, page: page)
        handle
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] page in
                let page = Page(
                    page: page.page,
                    items: page.results.map { $0.toPageItem() },
                    totalPages: page.totalPages,
                    totalResults: page.totalResults
                )
                self?.pages.append(page)
                self?.state.accept(.loaded(page: page))
            })
            .disposed(by: bag)
    }
    
    private func loadTVShows(for genreID: Int, page: Int) {
        let handle: Single<ListPage<TVShow>> = tmdbUseCase
            .listTVShows(for: type, with: genreID, page: page)
        handle
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] page in
                let page = Page(
                    page: page.page,
                    items: page.results.map { $0.toPageItem() },
                    totalPages: page.totalPages,
                    totalResults: page.totalResults
                )
                self?.pages.append(page)
                self?.state.accept(.loaded(page: page))
            })
            .disposed(by: bag)
    }
    
    func preloadIfNeeded(for index: Int) {
        let displayedPage = (index / Page.defaultSize)
        let pageToLoad = displayedPage + 2
        if case .loading(let pageInLoading) = state.value {
            if pageInLoading <= pageToLoad {
                return
            }
        }
        guard (displayedPage + 1) >= pages.count else {
            return
        }
        let remainder = index % Page.defaultSize
        let rate: Double = Double(remainder) / Double(Page.defaultSize)
        guard rate > 0.75 else {
            return
        }
        if let index = selectedGenre, genres.count > index {
            loadPage(for: genres[index].id, page: pageToLoad)
        }
    }
    
    func didSelect(genreAt index: Int) {
        guard genres.count > index else {
            return
        }
        resetMediaList()
        let oldSelectionIndex = selectedGenre
        selectedGenre = index
        state.accept(.genreChange(from: oldSelectionIndex, to: index))
    }
    
    func isGenreSelected(at index: Int) -> Bool {
        guard let selectedGenreIndex = selectedGenre, genres.count > index else {
            return false
        }
        return genres[selectedGenreIndex] == genres[index]
    }
    
    private func resetMediaList() {
        pages = []
        state.accept(.empty)
    }
}

