//
//  PageItem.swift
//  BragiMovies
//
//  Created by Gazdag Sandor on 2023. 08. 22..
//

import Foundation

typealias PageItemDataLine = (title: String, value: String?)

struct PageItem {
    
    static var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var id: Int
    var lines: [PageItemDataLine] = []
    var imageURL: URL?
    
    static func from(input: PageItemInput) -> PageItem {
        switch input {
        case .movie(let id, let title, let voteAverage, let budget, let revenue, let imageURL):
            var item = PageItem(id: id, imageURL: imageURL)
            item.lines.append(PageItemDataLine(title: "Title:", value: title))
            item.lines.append(PageItemDataLine(title: "Rating:", value: "\(voteAverage)"))
            if let budget = budget {
                let b = amountFormatter.string(from: NSNumber(value: budget))
                item.lines.append(PageItemDataLine(title: "Budget:", value: b))
            } else {
                item.lines.append(PageItemDataLine(title: "Budget:", value: "-"))
            }
            if let revenue = revenue {
                item.lines.append(PageItemDataLine(title: "Revenue:", value: "\(revenue)"))
            } else {
                item.lines.append(PageItemDataLine(title: "Revenue:", value: "-"))
            }
            return item
        case .tvShow(let id, let title, let voteAverage, let lastAirDate, let lastEpisodeToAir, let imageURL):
            var item = PageItem(id: id, imageURL: imageURL)
            item.lines.append(PageItemDataLine(title: "Title:", value: title))
            item.lines.append(PageItemDataLine(title: "Rating:", value: "\(voteAverage)"))
            if let lastAirDate = lastAirDate {
                item.lines.append(PageItemDataLine(title: "Last aired:", value: lastAirDate))
            } else {
                item.lines.append(PageItemDataLine(title: "Last aired:", value: "-"))
            }
            if let lastEpisodeToAir = lastEpisodeToAir {
                item.lines.append(PageItemDataLine(title: "Last ep:", value: lastEpisodeToAir))
            } else {
                item.lines.append(PageItemDataLine(title: "Last ep:", value: "-"))
            }
            return item
        }
    }
}
