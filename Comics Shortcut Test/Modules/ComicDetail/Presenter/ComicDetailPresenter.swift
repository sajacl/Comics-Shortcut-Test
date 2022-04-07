//
//  ComicDetailPresenter.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation
import Combine
import SwiftUI

final class ComicDetailPresenter: PresenterInterface {
    internal var router: ComicDetailRouterPresenterInterface!
    var interactor: ComicDetailInteractorPresenterInterface!
    weak var viewModel: ComicDetailViewModel!
}

extension ComicDetailPresenter: ComicDetailPresenterRouterInterface {}

extension ComicDetailPresenter: ComicDetailPresenterInteractorInterface {}

extension ComicDetailPresenter: ComicDetailPresenterViewInterface {
    
}
