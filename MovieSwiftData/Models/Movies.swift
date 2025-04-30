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
    
    init(title: String, year: String) {
        self.title = title
        self.year = year
    }
}
