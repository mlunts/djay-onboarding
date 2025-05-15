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
        [logoImageView, heroImageView, adaImageView]
    }
    
    private struct Constants {
        static let imageHeight: CGFloat = 64
        static let logoTopSpacing: CGFloat = 120
        static let logoSidePadding: CGFloat = 90
        static let heroTopSpacing: CGFloat = 32
        static let heroSidePadding: CGFloat = 41.5
        static let heroHeight: CGFloat = 140
        static let titleFontSize: CGFloat = 34
        static let titleTopSpacing: CGFloat = 32
        static let titleSidePadding: CGFloat = 32
        static let adaTopSpacing: CGFloat = 32
        static let adaSidePadding: CGFloat = 95.3
    }
    
    // MARK: Adjustable Constraints
    private var logoTopConstraint: NSLayoutConstraint!
    private var logoHeightConstraint: NSLayoutConstraint!
    private var heroTopConstraint: NSLayoutConstraint!
    private var heroHeightConstraint: NSLayoutConstraint!
    private var titleTopConstraint: NSLayoutConstraint!
    private var adaTopConstraint: NSLayoutConstraint!
    private var adaHeightConstraint: NSLayoutConstraint!
    
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.handleOrientationChange()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEntrance()
    }
    
    private func setupLayout() {
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        titleLabel.textColor = .contextualPrimary
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        imageViews.forEach { $0.contentMode = .scaleAspectFit }
        
        [logoImageView, heroImageView, titleLabel, adaImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        logoTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.logoTopSpacing)
        logoHeightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        heroTopConstraint = heroImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.heroTopSpacing)
        heroHeightConstraint = heroImageView.heightAnchor.constraint(equalToConstant: Constants.heroHeight)
        titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: Constants.titleTopSpacing)
        adaTopConstraint = adaImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.adaTopSpacing)
        adaHeightConstraint = adaImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        
        NSLayoutConstraint.activate([
            // Logo
            logoTopConstraint,
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoHeightConstraint,
            
            // Hero
            heroTopConstraint,
            heroImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroHeightConstraint,
            
            // Title
            titleTopConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleSidePadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleSidePadding),
            
            // ADA
            adaTopConstraint,
            adaImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adaHeightConstraint
        ])
    }
    
    private func animateEntrance() {
        let images = [adaImageView, heroImageView]
        images.forEach {
            $0.alpha = 0
            $0.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }
        titleLabel.alpha = 0
        titleLabel.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            images.forEach {
                $0.alpha = 1
                $0.transform = .identity
            }
            self.titleLabel.alpha = 1
            self.titleLabel.transform = .identity
        })
    }
    
    private func configureContent() {
        guard let step = step else { return }
        titleLabel.text = step.title
        logoImageView.image = logoImage
        heroImageView.image = heroImage
        adaImageView.image = adaimage
    }
    
    private func handleOrientationChange() {
        let isLandscape = UIWindow.isLandscape
        
        if isLandscape {
            logoTopConstraint.constant = Constants.logoTopSpacing / 2
            logoHeightConstraint.constant = Constants.imageHeight / 2
            heroTopConstraint.constant = Constants.heroTopSpacing / 2
            heroHeightConstraint.constant = Constants.heroHeight / 2.5
            titleTopConstraint.constant = Constants.titleTopSpacing / 2
            adaTopConstraint.constant = Constants.adaTopSpacing / 2
            adaHeightConstraint.constant = Constants.imageHeight / 1.5
            
            titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize / 2, weight: .bold)
        } else {
            logoTopConstraint.constant = Constants.logoTopSpacing
            logoHeightConstraint.constant = Constants.imageHeight
            heroTopConstraint.constant = Constants.heroTopSpacing
            heroHeightConstraint.constant = Constants.heroHeight
            titleTopConstraint.constant = Constants.titleTopSpacing
            adaTopConstraint.constant = Constants.adaTopSpacing
            adaHeightConstraint.constant = Constants.imageHeight
            
            titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        }
        
        view.layoutIfNeeded()
    }
}
