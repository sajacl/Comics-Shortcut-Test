//
//  StringExtensions.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import Foundation

extension String {
    init(_ key: AppStrings) {
        self = AppStrings.LocalizedStrings(with: key, comment: "")
    }
}
