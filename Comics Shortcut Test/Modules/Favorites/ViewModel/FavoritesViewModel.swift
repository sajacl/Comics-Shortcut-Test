//
//  FavoritesViewModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import Combine

extension FavoritesView {
    class ViewModel: ObservableObject {
        @Published var comics: [ComicModel] = []
        
        func fetchFavoritedComics() {
            comics = RealmHelper.shared.fetchFavoritedComics()
        }
    }
}
