//
//  Page.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import Foundation

struct Page {
    
    static let defaultSize: Int = 20
    
    let page: Int
    var items: [PageItem]
    let totalPages: Int
    let totalResults: Int
    
    var indexPaths: [IndexPath] {
        let pageStart = (page - 1) * Page.defaultSize
        let range = pageStart ..< pageStart + items.count
        return range.map { index in
            IndexPath(item: index, section: .zero)
        }
    }
    
    init(page: Int, items: [PageItem], totalPages: Int, totalResults: Int) {
        self.page = page
        self.items = items
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
