//
//  OnboardingStepViewController.swift
//  djay onboarding
//
//  Created by Marina Lunts on 05.05.25.
//
import UIKit

class OnboardingWelcomeStepViewController: UIViewController {
    
    var step: OnboardingStep
    var image: UIImage?
    var onNextTapped: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    private var imageViewTopConstraint: NSLayoutConstraint!
    
    private struct Constants {
        // Image View Constraints
        static let imageTopSpacing: CGFloat = 255
        static let imageLeadingPadding: CGFloat = 90
        static let imageTrailingPadding: CGFloat = -90
        static let imageHeight: CGFloat = 64
        
        static let logoTopSpacing: CGFloat = 120
        static let logoSidePadding: CGFloat = 90
        
        // Title Label Constraints
        static let titleBottomSpacingToButton: CGFloat = -124
        static let titleHorizontalPadding: CGFloat = 41
    }
    
    init(step: OnboardingStep, image: UIImage?) {
        self.step = step
        if let image {
            self.image = image
        }
        
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
    
    private func setupLayout() {
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        titleLabel.textColor = .contextualPrimary
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        
        [titleLabel, imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.imageTopSpacing)
        
        NSLayoutConstraint.activate([
            // Image View
            imageViewTopConstraint,
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageLeadingPadding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageTrailingPadding),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            // Title Label
            titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.titleBottomSpacingToButton),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleHorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleHorizontalPadding),
        ])
    }
    
    private func configureContent() {
        titleLabel.text = step.title
        imageView.image = image
    }
    
    func animate(completion: @escaping () -> Void) {
        imageViewTopConstraint.constant = Constants.logoTopSpacing
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.titleLabel.frame = CGRect(x: self.titleLabel.frame.origin.x, y: self.titleLabel.frame.origin.y + 60, width: self.titleLabel.frame.width, height: self.titleLabel.frame.height)
        }, completion: { _ in
            completion()
        })
    }
}
