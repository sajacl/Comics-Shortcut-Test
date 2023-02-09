//
//  RealmComicModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import Foundation
import RealmSwift

final class ComicRealmObject: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var month: String = ""
    @Persisted var num: Int = -1
    @Persisted var link : String = ""
    @Persisted var year : String = ""
    @Persisted var news : String = ""
    @Persisted var safeTitle: String = ""
    @Persisted var transcript = ""
    @Persisted var alt: String = ""
    @Persisted var img: String = ""
    @Persisted var title: String = ""
    @Persisted var day: String = ""
    @Persisted var isFavorite: Bool = false

    convenience init(from model: ComicModel) {
        self.init()
        
        self.id = model.id
        self.month = model.month
        self.num = model.num
        self.link = model.link
        self.year = model.year
        self.news = model.news
        self.safeTitle = model.safeTitle
        self.alt = model.alt
        self.transcript = model.transcript
        self.img = model.img
        self.title = model.title
        self.day = model.day
        self.isFavorite = model.isFavorite
    }
}
