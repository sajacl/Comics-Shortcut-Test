//
//  FullImageViewController.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import Kingfisher
import SwiftUI

enum ImageOrURL {
    case image(UIImage)
    case url(URL)
}

struct FullImageComicViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    /// Comic name to be used as view's title in navigation bar.
    let name: String
    
    /// Comic image/url.
    let pair: ImageOrURL
    
    init(name: String, pair: ImageOrURL) {
        self.pair = pair
        self.name = name
    }

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<Self>
    ) -> Self.UIViewControllerType {
        return FullImageComicViewController(title: name, pair: pair)
    }

    func updateUIViewController(
        _ uiViewController: Self.UIViewControllerType,
        context: UIViewControllerRepresentableContext<Self>
    ) {
        // no op
    }
}

private final class FullImageComicViewController: UIViewController {
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
    
    private static let placeHolderImage = UIImage(named: "shortcut-icon")
    
    private lazy var imageDownloadTask: DownloadTask? = nil
    
    private let pair: ImageOrURL
    
    // MARK: - LifeCycles
    init(title: String, pair: ImageOrURL) {
        self.pair = pair
        
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override final func viewDidLoad() {
        super.viewDidLoad()
        
        configViewController()
        addViews()
        constraintViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch pair {
        case let .image(image):
            imageScrollView.display(image: image)
            
        case let .url(url):
            imageDownloadTask =
            KF.url(url, cacheKey: "\(url.absoluteString)")
                .placeholder(Self.placeHolderImage)
                .loadDiskFileSynchronously()
                .cacheOriginalImage()
                .fade(duration: 0.1)
                .onSuccess { [weak self] result in
                    self?.displayImage(result.image)
                }.set(to: comicImageView)
        }
    }
    
    deinit {
        imageDownloadTask?.cancel()
    }
    
    private func displayImage(_ image: UIImage) {
        UIView.transition(
            with: imageScrollView,
            duration: 0.4,
            options: .transitionCrossDissolve,
            animations: {
                self.imageScrollView.display(image: image)
            }
        )
    }
    
    func configViewController() {
        addLightBlurEffect()
    }
    
    func addViews() {
        self.view.addSubviews(
            titleLabel,
            imageScrollView
        )
    }
    
    func constraintViews() {
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
    
    private func addLightBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
}
