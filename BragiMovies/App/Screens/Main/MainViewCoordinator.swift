//
//  MainViewCoordinator.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit

protocol MainViewCoordinatorProtocol: CoordinatorProtocol {
    var dependencies: MainViewDependencies { get }
}

class MainViewCoordinator: MainViewCoordinatorProtocol {
    
    let dependencies: MainViewDependencies
    var moviesCoordinator: ListViewCoordinator
    var tvShowsCoordinator: ListViewCoordinator
    var viewController: UIViewController {
        tabBarController
    }
    
    var tabBarController: UITabBarController
    
    init(dependencies: MainViewDependencies) {
        self.dependencies = dependencies
        self.moviesCoordinator = ListViewCoordinator(dependencies: ListViewDependencies(
            type: .movie,
            tmdbUseCase: Assembler.default.tmdbUseCase()
        ))
        self.tvShowsCoordinator = ListViewCoordinator(dependencies: ListViewDependencies(
            type: .tv,
            tmdbUseCase: Assembler.default.tmdbUseCase()
        ))
        self.tabBarController = Assembler.default.mainView(dependencies: dependencies)
    }
    
    func start() {
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: moviesCoordinator.viewController),
            UINavigationController(rootViewController: tvShowsCoordinator.viewController)
        ]
        dependencies.window.rootViewController = viewController
        dependencies.window.makeKeyAndVisible()
    }
}
