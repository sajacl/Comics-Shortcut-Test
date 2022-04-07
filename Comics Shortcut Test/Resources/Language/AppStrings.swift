//
//  AppStrings.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import Foundation

enum AppStrings: String {
    case appTitle
    case searchComics
    case seeDetail
    case loading
    case share
    case favorite
    case comicDetail
    case searchWithIdAndName
    case somethingWentWrong
    case reload
    case favoritedComics
    case noFavoriteComics
    case seeFavoriteList
    
    static func LocalizedStrings(with key: String, comment: String) -> String {
        NSLocalizedString(key, tableName: "Languages", comment: comment)
    }
    
    static func LocalizedStrings(with key: AppStrings, comment: String) -> String {
        NSLocalizedString(key.rawValue, tableName: "Languages", comment: comment)
    }
    
    static func LocalizedStrings(with key: AppStrings, comment: String, args: String...) -> String {
        String(format: NSLocalizedString(key.rawValue, tableName: "Languages", comment: comment), arguments: args)
    }
    
    static func LocalizedStrings(with key: AppStrings, comment: String, args: AppStrings...) -> String {
        return String(format: NSLocalizedString(key.rawValue, tableName: "Languages", comment: comment), arguments: args.map{ $0.rawValue })
    }
    
    static func LocalizedStrings(with key: AppStrings, comment: String, args: [AppStrings]) -> String {
        String(format: NSLocalizedString(key.rawValue, tableName: "Languages", comment: comment), arguments: args.map({ $0.rawValue }))
    }
}
