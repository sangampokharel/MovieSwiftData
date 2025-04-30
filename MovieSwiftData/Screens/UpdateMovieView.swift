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
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var movie:Movies?
    
    var isFormValid:Bool {
        return  !title.isEmpty || !year.isEmpty
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("year",text: $year)
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
            }
        
    }
}

