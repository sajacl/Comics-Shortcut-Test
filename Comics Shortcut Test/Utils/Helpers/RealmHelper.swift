//
//  RealmHelper.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import RealmSwift

class RealmHelper {
    // MARK: - Publics
    static let shared = RealmHelper()
    
    // MARK: - Privates
    private let realm: Realm
    
    // MARK: - Initializers
    internal init() {
        do {
            realm = try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Comic Interactions
    
    /// To save a specific comic into DB.
    ///
    /// - Warning: It has be used from the main thread, Realm db concurency issue.
    ///
    /// Usage:
    ///
    ///     1: saveComic(comic: ComicModel())
    ///
    /// - Parameter comic: ComicModel to save in DB.
    ///
    open func saveComic(comic: ComicModel) {
        self.realm.beginWrite()
        let ComicData = RealmComicModel(from: comic)
        self.realm.add(ComicData, update: .modified)
        do {
            try self.realm.commitWrite()
        } catch {
            LError(error.localizedDescription)
        }
    }
    
    /// To fetch a specific comic from DB.
    ///
    /// - Warning: It has be used from the main thread, It will result nil if there is not a comic with  given id in DB.
    ///
    /// Usage:
    ///
    ///     1: let optionalComic = fetchComic(id: 1)
    ///
    /// - Parameter id: Comic id for applying to predicate on search.
    ///
    /// - Returns: A specific optional comic with given Id.
    open func fetchComic(id: Int) -> ComicModel? {
        let allComics = realm.objects(RealmComicModel.self)
            .filter("\(#keyPath(RealmComicModel.id)) == %@", id)
        
        if let comic = allComics.first {
            return ComicModel(from: comic)
        }
        
        return nil
    }
    
    /// To fetch all comics we have from DB.
    ///
    /// - Warning: It has be used from the main thread, It will result empty array if there are no comics in DB.
    ///
    /// Usage:
    ///
    ///     1: let comics = fetchAllComics()
    ///
    /// - Returns: List of ComicModel.
    open func fetchAllComics() -> [ComicModel] {
        realm.objects(RealmComicModel.self).map { ComicModel(from: $0) }
    }
    
    /// To fetch all comics that user has made it favorite.
    ///
    /// - Warning: It has be used from the main thread, It will result empty array if there are no favorited comics in DB.
    ///
    /// Usage:
    ///
    ///     1: let favorites = fetchFavoritedComics()
    ///
    /// - Returns: List of favorited ComicModel.
    open func fetchFavoritedComics() -> [ComicModel] {
        realm.objects(RealmComicModel.self)
            .filter("\(#keyPath(RealmComicModel.isFavorite)) == %@", true)
            .map { ComicModel(from: $0) }
    }
    
    /// To check if a comic is favorited in Database.
    ///
    /// - Warning: It has be used from the main thread, It will result false if there is not a comic with specific model.
    ///
    /// Usage:
    ///
    ///     1: let isFavoriteComic = comicIsFavorited(comic: ComicModel())
    ///
    /// - Parameter comic: ComicModel for applying to predicate on search.
    ///
    /// - Returns: Boolean for value of isFavorited.
    open func comicIsFavorited(comic: ComicModel) -> Bool {
        let allComics = realm.objects(RealmComicModel.self).filter("\(#keyPath(RealmComicModel.id)) == %@", Int(comic.id))
        
        if let comic = allComics.first {
            return comic.isFavorite
        }
        
        return false
    }
    
    /// To check if a comic is favorited in Database.
    ///
    /// - Warning: It has be used from the main thread, It will result false if there is an error on save, Result is discardable.
    ///
    /// Usage:
    ///
    ///     1: toggleFavorite(comic: ComicModel())
    ///
    /// - Parameter comic: ComicModel for changing its isFavorited value.
    ///
    /// - Returns: Boolean for if save succeeded.
    @discardableResult
    open func toggleFavorite(comic: ComicModel) -> Bool {
        self.realm.beginWrite()
        let newComic = RealmComicModel(from: ComicModel(model: comic, isFavorite: !comic.isFavorite))
        self.realm.add(newComic, update: .modified)
        
        do {
            try self.realm.commitWrite()
            return true
        } catch {
            LError(error.localizedDescription)
            return false
        }
    }
}
