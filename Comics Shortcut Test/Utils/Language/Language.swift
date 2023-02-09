//
//  Language.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import UIKit

private var bundleKey: UInt8 = 0

final class BundleExtension: Bundle {
    override func localizedString(
        forKey key: String,
        value: String?,
        table tableName: String?
    ) -> String {
        lazy var superLocalizedString = super.localizedString(
            forKey: key,
            value: value,
            table: tableName
        )
        
        return (objc_getAssociatedObject(self, &bundleKey) as? Bundle)?
            .localizedString(
                forKey: key, value: value, table: tableName
            ) ?? superLocalizedString
    }
}

extension Bundle {
    static let once: Void = { object_setClass(Bundle.main, type(of: BundleExtension())) }()
    
    static func set(language: Language) {
        Bundle.once
        
        let isLanguageRTL = Locale.characterDirection(forLanguage: language.code) == .rightToLeft
        
        let viewOrientation: UISemanticContentAttribute = isLanguageRTL == true ?
            .forceRightToLeft :
            .forceLeftToRight
        
        UIView.appearance().semanticContentAttribute = viewOrientation
        
        let languageSemanticOverrides: [String : Any] = [
            "AppleTe  zxtDirection": isLanguageRTL,
            "NSForceRightToLeftWritingDirection": isLanguageRTL,
            "AppleLanguages": [language.code],
            "app_lang": language.code
        ]
        
        languageSemanticOverrides.forEach { pair in
            UserDefaults.standard.set(pair.value, forKey: pair.key)
        }
        UserDefaults.standard.synchronize()
        
        guard let path = Bundle.main.path(forResource: language.code, ofType: "lproj") else {
            return
        }
        
        objc_setAssociatedObject(
            Bundle.main,
            &bundleKey,
            Bundle(path: path),
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
}

enum Language: Equatable {
    case english
    case swedish
    
    init?(languageCode: String?) {
        guard let languageCode = languageCode else {
            return nil
        }
        
        switch languageCode {
        case "en":                  self = .english
        case "sv":                  self = .swedish
        default:                    return nil
        }
    }
    
    var code: String {
        switch self {
        case .english:              return "en"
        case .swedish:              return "sv"
        }
    }
    
    var name: String {
        switch self {
        case .english:              return "English (US)"
        case .swedish:              return "Svenska"
        }
    }
}
