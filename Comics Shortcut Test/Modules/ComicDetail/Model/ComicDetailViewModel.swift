//
//  ComicDetailViewModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Combine
import SwiftUI
import RealmSwift

final class ComicDetailViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var comic: ComicModel
    @Published var favoritedColor: Color = .gray {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var error: Bool = false {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    init(comic: ComicModel) {
        self.comic = comic
        
        decideFavoriteStarColor()
    }
    
    func decideFavoriteStarColor() {
        favoritedColor = comicIsFavorited() ? .yellow: .gray
    }
    
    func comicIsFavorited() -> Bool {
        RealmHelper.shared.comicIsFavorited(comic: comic)
    }
    
    func faveClicked() {
        if RealmHelper.shared.toggleFavorite(comic: comic) {
            decideFavoriteStarColor()
            comic.isFavorite = !comic.isFavorite
        } else {
            error = true
        }
    }
}
