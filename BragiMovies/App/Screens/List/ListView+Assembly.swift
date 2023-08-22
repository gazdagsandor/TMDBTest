//
//  ListView+Assembly.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import Foundation

extension Assembler {
    
    func listView(dependencies: ListViewDependencies) -> ListViewController {
        ListViewController(viewModel: listViewModel(dependencies: dependencies))
    }
    
    func listViewModel(dependencies: ListViewDependencies) -> ListViewModelProtocol {
        ListViewModel(type: dependencies.type, tmdbUseCase: dependencies.tmdbUseCase)
    }
}
