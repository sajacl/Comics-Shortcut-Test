//
//  ComicDetailInteractor.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation
import Combine

final class ComicDetailInteractor: InteractorInterface {
    weak var presenter: ComicDetailPresenterInteractorInterface!
}

extension ComicDetailInteractor: ComicDetailInteractorPresenterInterface {}
