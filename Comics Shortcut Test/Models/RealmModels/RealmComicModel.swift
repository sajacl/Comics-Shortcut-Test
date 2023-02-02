//
//  RealmComicModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import Foundation
import RealmSwift

final class RealmComicModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var month: String = ""
    @objc dynamic var num: Int = -1
    @objc dynamic var link : String = ""
    @objc dynamic var year : String = ""
    @objc dynamic var news : String = ""
    @objc dynamic var safeTitle: String = ""
    @objc dynamic var transcript = ""
    @objc dynamic var alt: String = ""
    @objc dynamic var img: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var day: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    func imageURL() throws -> URL {
        guard let url = URL(string: img) else {
            throw URLError(.badURL)
        }

        return url
    }

    override static func primaryKey() -> String? {
        return #keyPath(RealmComicModel.id)
    }
}

extension RealmComicModel {
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
