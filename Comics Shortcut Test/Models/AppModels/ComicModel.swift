//
//  ComicModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation
import SwiftUI

struct ComicModel: Identifiable {
    let id: Int
    let month: String
    let num: Int
    let link, year, news, safeTitle: String
    let transcript, alt: String
    let img: String
    let title, day: String
    var isFavorite: Bool
    
    /// Creating `Image-URL` from string url.
    /// - Warning: Can throw bad url error.
    func createImageURL() throws -> URL {
        guard let url = URL(string: img) else {
            throw URLError(.badURL)
        }
        
        return url
    }
    
    /// Constructing string from comics `Year`, `Month`, `Day` representing date.
    var stringDate: String {
        return "\(year)/\(month)/\(day)"
    }
}

extension ComicModel {
    /// Only used for previews.
    init() {
        self.id = -1
        self.month = ""
        self.num = -1
        self.link = ""
        self.year = ""
        self.news = ""
        self.safeTitle = ""
        self.transcript = ""
        self.alt = ""
        self.img = ""
        self.title = ""
        self.day = ""
        self.isFavorite = false
    }
    
    /// Used for constructing comic model from api side model.
    init(from decodableModel: ComicDecodableModel) {
        self.id = decodableModel.num ?? -1
        self.month = decodableModel.month ?? ""
        self.num = decodableModel.num ?? -1
        self.link = decodableModel.link ?? ""
        self.year = decodableModel.year ?? ""
        self.news = decodableModel.news ?? ""
        self.safeTitle = decodableModel.safeTitle ?? ""
        self.transcript = decodableModel.transcript ?? ""
        self.alt = decodableModel.alt ?? ""
        self.img = decodableModel.img ?? ""
        self.title = decodableModel.title ?? ""
        self.day = decodableModel.day ?? ""
        self.isFavorite = false
    }
    
    /// Used for re-constructing comic model with toggle-able favorite.
    init(model: ComicModel, isFavorite: Bool) {
        self.id = model.num
        self.month = model.month
        self.num = model.num
        self.link = model.link
        self.year = model.year
        self.news = model.news
        self.safeTitle = model.safeTitle
        self.transcript = model.transcript
        self.alt = model.alt
        self.img = model.img
        self.title = model.title
        self.day = model.day
        self.isFavorite = isFavorite
    }
    
    /// Used for constructing comic model from realm object.
    init(from realmObject: ComicRealmObject) {
        self.id = realmObject.num
        self.month = realmObject.month
        self.num = realmObject.num
        self.link = realmObject.link
        self.year = realmObject.year
        self.news = realmObject.news
        self.safeTitle = realmObject.safeTitle
        self.transcript = realmObject.transcript
        self.alt = realmObject.alt
        self.img = realmObject.img
        self.title = realmObject.title
        self.day = realmObject.day
        self.isFavorite = realmObject.isFavorite
    }
}
