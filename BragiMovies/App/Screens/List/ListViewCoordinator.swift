//
//  ListViewCoordinator.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 21..
//

import UIKit

protocol ListViewCoordinatorProtocol: CoordinatorProtocol {
    var dependencies: ListViewDependencies { get }
}

class ListViewCoordinator: ListViewCoordinatorProtocol {
    
    let dependencies: ListViewDependencies
    let viewController: UIViewController
    
    init(dependencies: ListViewDependencies) {
        self.dependencies = dependencies
        viewController = Assembler.default.listView(dependencies: dependencies)
    }
}
