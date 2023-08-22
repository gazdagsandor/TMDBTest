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
    var voteAverage: String
    var budget: String
    var revenue: String
    var imageURL: URL?
    
    init(id: Int, title: String, voteAverage: Double, budget: Int?, revenue: Int?, imageURL: URL?) {
        self.id = id
        self.title = title
        self.voteAverage = "\(voteAverage)"
        if let budget = budget {
            self.budget = "\(budget)"
        } else {
            self.budget = "-"
        }
        if let revenue = revenue {
            self.revenue = "\(revenue)"
        } else {
            self.revenue = "-"
        }
        self.imageURL = imageURL
    }
}
