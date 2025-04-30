//
//  Reviews.swift
//  MovieSwiftData
//
//  Created by sangam pokharel on 30/04/2025.
//

import SwiftData

@Model
class Reviews {
    var reviewTitle:String
    var reviewDesc:String
    
    init(reviewTitle: String, reviewDesc: String) {
        self.reviewTitle = reviewTitle
        self.reviewDesc = reviewDesc
    }
}
