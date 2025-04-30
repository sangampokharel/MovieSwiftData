//
//  UpdateMovieView.swift
//  MovieSwiftData
//
//  Created by sangam pokharel on 30/04/2025.
//

import SwiftUI

struct UpdateMovieView: View {
    
    @State private var title:String = ""
    @State private var year:String = ""
    @State private var isPresented = false
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
   
    var movie:Movies?
    
    var isFormValid:Bool {
        return  !title.isEmpty || !year.isEmpty
    }
    
    func onDelete(indexSet:IndexSet) {
       let reviewsToDelete = indexSet.map { movie?.reviews[$0] }.compactMap { $0 }
        
        indexSet.forEach { index in
            movie?.reviews.remove(at: index)
        }
        
        for review in reviewsToDelete {
            context.delete(review)
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to delete review: \(error)")
        }
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("year",text: $year)
            
            Section {
                if let movie, !movie.reviews.isEmpty {
                    List {
                        
                        ForEach(movie.reviews) { item in
                            VStack {
                                Text(item.reviewTitle)
                                Text(item.reviewDesc)
                            }
                        }.onDelete(perform: onDelete)
                    }
                }else{
                    Text("No Reviews Found!!")
                    
                }
            } header: {
                HStack {
                    Text("Reviews")
                    Spacer()
                    
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                        
                    }
                    
                }
            }
        }.navigationTitle("Update Movie")
            .onAppear {
                if let movie {
                    self.title = movie.title
                    self.year = movie.year
                }
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        guard let movie else {return }
                        do {
                            movie.title = title
                            movie.year = year
                            try context.save()
                            dismiss()
                        }catch {
                            print("Failed to Update the movies")
                        }
                        
                    } label: {
                        Text("Update")
                    }.disabled(!isFormValid)
                    
                }
            }.sheet(isPresented: $isPresented) {
                AddReviewsView(movie: movie)
            }
        
    }
}

