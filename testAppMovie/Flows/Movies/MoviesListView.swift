//
//  MoviesListView.swift
//  testAppMovie
//
//  Created by apple on 2/5/21.
//

import SwiftUI
import Kingfisher

struct MoviesListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    private var viewModel: MoviesViewModel = MoviesViewModel()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack() {
                    ScrollView(showsIndicators: false) {
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.results, id: \.self) { movie in
                                NavigationLink(destination: DetailView(results: movie)) {
                                    KFImage.init(URL(string: "https://image.tmdb.org/t/p/original/\(movie.poster_path)"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: (geometry.size.width / 2) - 25, height: 250)
                                        .background(Color.blue)
                                        .cornerRadius(15)
                                }
                            }
                        }
                    }.padding(.horizontal)
                    
                }
                .navigationBarTitle("Popular Movies")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Text("Log Out")
                                        })
            }
        }
    }
}
