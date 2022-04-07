//
//  FavoritesView.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import SwiftUI
import CardStack

struct FavoritesView: View {
    @StateObject private var viewModel = ViewModel()
    
    let configuration = StackConfiguration()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                NavigationLink {
                    SearchView()
                } label: {
                    Text(String(.searchComics))
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16)
                            })
                }
                .foregroundColor(.gray)
                
                if viewModel.comics.isEmpty {
                    Spacer()
                    Text(String(.noFavoriteComics))
                    Spacer()
                } else {
                    CardStackView<ComicCardView, ComicIdHolderModel>(configuration: configuration, items: viewModel.comics.map{ ComicIdHolderModel(id: "\($0.id)") })
                }
            }
            .onAppear(perform: viewModel.fetchFavoritedComics)
            .navigationBarTitle(Text(String(.favoritedComics)))
        }
    }
}

#if DEBUG
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
#endif
