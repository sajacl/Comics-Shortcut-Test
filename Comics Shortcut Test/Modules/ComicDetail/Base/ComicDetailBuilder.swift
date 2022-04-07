//
//  ComicDetailBuilder.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation
import UIKit
import SwiftUI
import Combine

// MARK: - Router interactions

protocol ComicDetailRouterPresenterInterface: BaseRouterPresenterInterface {}

// MARK: - Presenter interactions

protocol ComicDetailPresenterRouterInterface: BasePresenterRouterInterface {}

protocol ComicDetailPresenterInteractorInterface: BasePresenterInteractorInterface {}

protocol ComicDetailPresenterViewInterface: BasePresenterViewInterface {}

// MARK: - Interactor interactions

protocol ComicDetailInteractorPresenterInterface: BaseInteractorPresenterInterface {}

// MARK: - module builder

final class ComicDetailBuilder: ModuleInterface {
    typealias View = ComicDetail
    typealias Presenter = ComicDetailPresenter
    typealias Router = ComicDetailRouter
    typealias Interactor = ComicDetailInteractor

    func build(comic: ComicModel) -> some SwiftUI.View {
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()

        let viewModel = ComicDetailViewModel(comic: comic)
        let view = View(presenter: presenter, viewModel: viewModel)
            .environmentObject(ComicDetailEnviroment())
        presenter.viewModel = viewModel

        self.assemble(presenter: presenter, router: router, interactor: interactor)

        let viewController = UIHostingController(rootView: view)
        router.viewController = viewController
        return view
    }
}
