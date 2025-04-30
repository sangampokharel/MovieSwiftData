//
//  Movies.swift
//  MovieSwiftData
//
//  Created by sangam pokharel on 30/04/2025.
//

import SwiftData


@Model
final class Movies {
    
    @Attribute(.unique) var title:String
    var year:String
    var reviews: [Reviews] = []
    
    init(title: String, year: String, reviews:[Reviews] = []) {
        self.title = title
        self.year = year
        self.reviews = reviews
    }
}
