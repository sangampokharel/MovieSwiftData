//
//  AddMoviesView.swift
//  MovieSwiftData
//
//  Created by sangam pokharel on 30/04/2025.
//

import SwiftUI
import SwiftData

struct AddMoviesView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var title:String = ""
    @State private var year:String = ""
   
    var isFormValid:Bool {
        return !title.isEmpty || !year.isEmpty
    }
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Year", text: $year)
                
            }.navigationTitle("Add Movies")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            do {
                                let movie = Movies(title: title, year: year)
                                context.insert(movie)
                                try context.save()
                                dismiss()
                            }catch {
                                print("Failved to save data: \(error.localizedDescription)")
                            }
                           
                        } label: {
                            Text("Save")
                        }.disabled(!isFormValid)
                        

                    }
                }
        }
    }
}

#Preview {
    AddMoviesView()
}
