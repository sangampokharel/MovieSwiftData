//
//  MoviesList.swift
//  MovieSwiftData
//
//  Created by sangam pokharel on 30/04/2025.
//

import SwiftUI
import SwiftData

struct MoviesList: View {
    @State private var isPresented: Bool = false
    @Query(sort:\Movies.title)  private var movies:[Movies]
    @Environment(\.modelContext)  var context
    func deleteMovie(indexSet:IndexSet) {
        indexSet.forEach { item in
            let movie = movies[item]
            context.delete(movie)
            do {
                try context.save()
            }catch {
                print("Failed to delete item")
            }

        }
      }
    var body: some View {
        NavigationStack {
            List {
                ForEach(movies) { item in
                    NavigationLink {
                        UpdateMovieView(movie: item)
                    } label: {
                        HStack {
                            Text(item.title)
                            Spacer()
                            Text(item.year)
                        }
                    }

                   
                }.onDelete(perform: deleteMovie)
         
            }.sheet(isPresented: $isPresented, content: {
                AddMoviesView()
            }).navigationTitle("Movies")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Text("Add Movies")
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    MoviesList()
}
