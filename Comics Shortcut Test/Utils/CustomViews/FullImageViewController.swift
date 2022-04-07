//
//  FullImageViewController.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import Kingfisher
import SwiftUI

struct FullImageComicViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = FullImageComicViewController
    
    let imageURL: URL
    let comicName: String
    
    init(imageURL: URL, comicName: String) {
        self.imageURL = imageURL
        self.comicName = comicName
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<FullImageComicViewControllerWrapper>) -> FullImageComicViewControllerWrapper.UIViewControllerType {

        return FullImageComicViewController(imageURL: imageURL, comicName: comicName)
    }

    func updateUIViewController(_ uiViewController: FullImageComicViewControllerWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<FullImageComicViewControllerWrapper>) {}
}

class FullImageComicViewController: ParentViewControllerClass {
    private lazy var imageScrollView: ImageScrollView = {
        let parent = ImageScrollView()
        parent.setup()
        parent.imageContentMode = .aspectFit
        parent.initialOffset = .begining
        parent.translatesAutoresizingMaskIntoConstraints = false
        return parent
    }()
    
    private lazy var comicImageView: UIImageView = UIImageView()
    private lazy var titleLabel: UILabel = {
        let parent = UILabel()
        parent.textColor = .black
        parent.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        parent.textAlignment = .center
        parent.translatesAutoresizingMaskIntoConstraints = false
        return parent
    }()
    
    // MARK: - LifeCycles
    convenience init(imageURL: URL, comicName: String) {
        self.init()
        
        KF.url(imageURL, cacheKey: "\(imageURL.absoluteString)")
            .placeholder(UIImage())
            .loadDiskFileSynchronously()
            .cacheOriginalImage()
            .fade(duration: 0.1)
            .set(to: comicImageView)
        
        titleLabel.text = comicName
    }
    
    convenience init(image: UIImage, comicName: String) {
        self.init()
        
        comicImageView.image = image
        titleLabel.text = comicName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.imageScrollView.zoomView == nil, let image = comicImageView.image {
            UIView.transition(with: imageScrollView, duration: 0.4, options: .transitionCrossDissolve, animations: {
                self.imageScrollView.display(image: image)
            })
        }
    }
    
    override func configViewController() {
        addLightBlurEffect()
    }
    
    override func addViews() {
        self.view.addSubviews(
            titleLabel,
            imageScrollView
        )
    }
    
    override func constraintViews() {
        titleLabel
            .topAnchor(equalTo: view.topAnchor, constant: 10)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 10)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -10)
            .heightAnchor(constant: 35)
        
        imageScrollView
            .topAnchor(equalTo: titleLabel.bottomAnchor, constant: 10)
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 10)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: -10)
            .bottomAnchor(equalTo: view.bottomAnchor, constant: -10)
    }
    
    func addLightBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
}
