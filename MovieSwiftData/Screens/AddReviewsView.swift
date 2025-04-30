//
//  AddReviewsView.swift
//  MovieSwiftData
//
//  Created by sangam pokharel on 30/04/2025.
//

import SwiftUI

struct AddReviewsView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var reviewTitle = ""
    @State private var reviewDesc = ""
    var movie:Movies?
    var body: some View {
        NavigationStack {
            Form {
                TextField("Review Title", text: $reviewTitle)
                TextField("Review Description", text: $reviewDesc)
            }.navigationTitle("Add Review")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            do {
                                let review = Reviews(reviewTitle: reviewTitle, reviewDesc: reviewDesc)
                                context.insert(review)
                                
                                try context.save()
                                
                                if let movie {
                                    movie.reviews.append(review)
                                }
                                
                                dismiss()
                                
                            }catch {
                                print("Failed to add review")
                            }
                        } label: {
                            Text("Save")
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    AddReviewsView()
}
