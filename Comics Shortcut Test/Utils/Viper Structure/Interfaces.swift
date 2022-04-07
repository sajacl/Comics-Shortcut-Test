//
//  Interfaces.swift
//  XKCDComics
//
//  Created by Sajad Vishkai on 4/5/22.
//

import Foundation

public protocol BaseEntityInterface {}

// MARK: - "i/o" transitions

public protocol BaseRouterPresenterInterface: AnyObject {}
public protocol BaseInteractorPresenterInterface: AnyObject {}
public protocol BasePresenterRouterInterface: AnyObject {}
public protocol BasePresenterInteractorInterface: AnyObject {}
public protocol BasePresenterViewInterface: AnyObject {}

// MARK: - VIPER

public protocol RouterInterface: BaseRouterPresenterInterface {
    associatedtype PresenterRouter

    var presenter: PresenterRouter! { get set }
}

public protocol InteractorInterface: BaseInteractorPresenterInterface {
    associatedtype PresenterInteractor
    
    var presenter: PresenterInteractor! { get set }
}

public protocol PresenterInterface: BasePresenterRouterInterface & BasePresenterInteractorInterface & BasePresenterViewInterface {
    associatedtype RouterPresenter
    associatedtype InteractorPresenter
    /*associatedtype ViewPresenter*/

    var router: RouterPresenter! { get set }
    var interactor: InteractorPresenter! { get set }
    /*var view: ViewPresenter! { get set }*/
}

public protocol ViewInterface/*: ViewPresenterInterface*/ {
    associatedtype PresenterView
    
    var presenter: PresenterView! { get set }
}

// MARK: - module

public protocol ModuleInterface {
    associatedtype View where View: ViewInterface
    associatedtype Presenter where Presenter: PresenterInterface
    associatedtype Router where Router: RouterInterface
    associatedtype Interactor where Interactor: InteractorInterface
    
    func assemble(/*view: View, */presenter: Presenter, router: Router, interactor: Interactor)
}

public extension ModuleInterface {
    func assemble(/*view: View, */presenter: Presenter, router: Router, interactor: Interactor) {
        /*
        view.presenter = (presenter as! Self.View.PresenterView)
        
        presenter.view = (view as! Self.Presenter.ViewPresenter)
        */
        presenter.interactor = (interactor as! Self.Presenter.InteractorPresenter)
        presenter.router = (router as! Self.Presenter.RouterPresenter)
        
        interactor.presenter = (presenter as! Self.Interactor.PresenterInteractor)
        
        router.presenter = (presenter as! Self.Router.PresenterRouter)
    }
}
