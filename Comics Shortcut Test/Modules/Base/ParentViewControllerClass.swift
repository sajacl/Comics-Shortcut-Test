//
//  ParentViewControllerClass.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import UIKit

class ParentViewControllerClass: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        addViews()
        constraintViews()
    }
    
    func configViewController() {}
    func addViews() {}
    func constraintViews() {}
}
