//
//  PageItem.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import Foundation

struct PageItem {
    var id: Int
    var title: String
    var voteAverage: Double
    var budget: Int
    var revenue: Int
    var imageURL: URL?
    
    init(id: Int, title: String, voteAverage: Double, budget: Int, revenue: Int, imageURL: URL?) {
        self.id = id
        self.title = title
        self.voteAverage = voteAverage
        self.budget = budget
        self.revenue = revenue
        self.imageURL = imageURL
    }
}
