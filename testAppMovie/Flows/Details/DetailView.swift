//
//  detailView.swift
//  testAppMovie
//
//  Created by apple on 2/8/21.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    var results: Results
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            KFImage(URL(string: "https://image.tmdb.org/t/p/original//\(results.poster_path)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.blue)
                .cornerRadius(20)
                .padding(EdgeInsets(top: -20, leading: 20, bottom: 0, trailing: 20))
                .frame(width: 300, height: 380, alignment: .center)
            
            
            VStack(alignment: .leading) {
                Text(results.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                Text(results.release_date)
                Text(results.overview)
                    .padding(.top, 20)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                
            }.padding()
        }
    }
}
