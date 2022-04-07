//
//  Language.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import UIKit

private var bundleKey: UInt8 = 0

final class BundleExtension: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return (objc_getAssociatedObject(self, &bundleKey) as? Bundle)?.localizedString(forKey: key, value: value, table: tableName) ??
            super.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    static let once: Void = { object_setClass(Bundle.main, type(of: BundleExtension())) }()
    static func set(language: Language) {
        Bundle.once
        let isLanguageRTL = Locale.characterDirection(forLanguage: language.code) == .rightToLeft
        UIView.appearance().semanticContentAttribute = isLanguageRTL == true ? .forceRightToLeft : .forceLeftToRight
        UserDefaults.standard.set(isLanguageRTL, forKey: "AppleTe  zxtDirection")
        UserDefaults.standard.set(isLanguageRTL, forKey: "NSForceRightToLeftWritingDirection")
        UserDefaults.standard.set([language.code], forKey: "AppleLanguages")
        UserDefaults.standard.set(language.code, forKey: "app_lang")
        UserDefaults.standard.synchronize()
        guard let path = Bundle.main.path(forResource: language.code, ofType: "lproj") else {
            return
        }
        objc_setAssociatedObject(Bundle.main,
                                 &bundleKey,
                                 Bundle(path: path),
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

enum Language: Equatable {
    case english(English)
    case swedish
    
    enum English {
        case us
        case uk
        case australian
        case canadian
        case indian
    }
    enum Chinese {
        case simplified
        case traditional
        case hongKong
    }
}

extension Language {
    var code: String {
        switch self {
        case .english(let english):
            switch english {
            case .us:                return "en"
            case .uk:                return "en-GB"
            case .australian:        return "en-AU"
            case .canadian:          return "en-CA"
            case .indian:            return "en-IN"
            }
        case .swedish:              return "sv"
        }
    }
    var name: String {
        switch self {
        case .english(let english):
            switch english {
            case .us:                return "English (US)"
            case .uk:                return "English (UK)"
            case .australian:        return "English (Australia)"
            case .canadian:          return "English (Canada)"
            case .indian:            return "English (India)"
            }
        case .swedish:               return "Svenska"
        }
    }
}
extension Language {
    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        switch languageCode {
        case "en", "en-US":     self = .english(.us)
        case "en-GB":           self = .english(.uk)
        case "en-AU":           self = .english(.australian)
        case "en-CA":           self = .english(.canadian)
        case "en-IN":           self = .english(.indian)
        case "sv":              self = .swedish
        default:                self = .english(.us)
        }
    }
}
struct LocaleManager {
    /// "ko-US" → "ko"
    static var languageCode: String? {
        guard var splits = Locale.preferredLanguages.first?.split(separator: "-"), let first = splits.first else { return nil }
        guard 1 < splits.count else { return String(first) }
        splits.removeLast()
        return String(splits.joined(separator: "-"))
    }
    static var language: Language? {
        return Language(languageCode: languageCode)
    }
}
