//
//  ComicDetailRouter.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation
import UIKit

final class ComicDetailRouter: RouterInterface {
    weak var presenter: ComicDetailPresenterRouterInterface!
    weak var viewController: UIViewController?
}

extension ComicDetailRouter: ComicDetailRouterPresenterInterface {}
