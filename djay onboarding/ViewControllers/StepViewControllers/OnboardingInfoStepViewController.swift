//
//  OnboardingInfoStepViewController.swift
//  djay onboarding
//
//  Created by Marina Lunts on 07.05.25.
//

import UIKit

class OnboardingInfoStepViewController: UIViewController {
    
    var step: OnboardingStep?
    var logoImage: UIImage?
    var heroImage: UIImage?
    var adaimage: UIImage?
    
    private let titleLabel = UILabel()
    
    private let logoImageView = UIImageView()
    private let heroImageView = UIImageView()
    private let adaImageView = UIImageView()
    
    private var imageViews: [UIImageView] {
        return [logoImageView, heroImageView, adaImageView]
    }
    
    private struct Constants {
        static let imageHeight: CGFloat = 64

        static let logoTopSpacing: CGFloat = 120
        static let logoSidePadding: CGFloat = 90
        
        static let heroTopSpacing: CGFloat = 32
        static let heroSidePadding: CGFloat = 41.5
        static let heroHeight: CGFloat = 140
        
        static let titleTopSpacing: CGFloat = 32
        static let titleSidePadding: CGFloat = 32
        
        static let adaTopSpacing: CGFloat = 32
        static let adaSidePadding: CGFloat = 95.3
    }
    
    init(step: OnboardingStep?, logoImage: UIImage?, heroImage: UIImage?, adaImage: UIImage?) {
        self.step = step
        self.logoImage = logoImage
        self.heroImage = heroImage
        self.adaimage = adaImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupLayout()
        configureContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEntrance()
    }
    
    private func setupLayout() {
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .contextualPrimary
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        imageViews.forEach({ $0.contentMode = .scaleAspectFill })
        
        [logoImageView, heroImageView,titleLabel, adaImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // Logo Image View
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.logoTopSpacing),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.logoSidePadding),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.logoSidePadding),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            // Hero Image View
            heroImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.heroTopSpacing),
            heroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.heroSidePadding),
            heroImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.heroSidePadding),
            heroImageView.heightAnchor.constraint(equalToConstant: Constants.heroHeight),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: Constants.titleTopSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleSidePadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleSidePadding),
            
            // ADA Image View
            adaImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.adaTopSpacing),
            adaImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.adaSidePadding),
            adaImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.adaSidePadding),
            adaImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
        ])
    }
    
    private func animateEntrance() {
        // Set initial states
        let images = [adaImageView, heroImageView]
        images.forEach { imageView in
            imageView.alpha = 0
            imageView.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }
        
        titleLabel.alpha = 0
        titleLabel.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)

        // Animate them in
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            images.forEach { imageView in
                imageView.alpha = 1
                imageView.transform = .identity
            }
            self.titleLabel.alpha = 1
            self.titleLabel.transform = .identity
        })
    }

    
    private func configureContent() {
        guard let step = step else { return }
        titleLabel.text = step.title
      
        logoImageView.image = logoImage
        adaImageView.image = adaimage
        heroImageView.image = heroImage
    }
}
