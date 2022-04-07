//
//  ComicDecodableModel.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation

// MARK: - ComicDecodableModel
struct ComicDecodableModel: Decodable {
    let month: String?
    let num: Int?
    let link, year, news, safeTitle: String?
    let transcript, alt: String?
    let img: String?
    let title, day: String?

    enum CodingKeys: String, CodingKey {
        case month, num, link, year, news
        case safeTitle = "safe_title"
        case transcript, alt, img, title, day
    }
}
