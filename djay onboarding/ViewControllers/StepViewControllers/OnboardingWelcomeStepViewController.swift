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
    var buttonAction: (() -> Void)
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let actionButton = ActionButton()
    private struct Constants {
        // Image View Constraints
        static let imageTopSpacing: CGFloat = 255
        static let imageLeadingPadding: CGFloat = 81
        static let imageTrailingPadding: CGFloat = -99
        static let imageHeight: CGFloat = 64
        
        // Button Constraints
        static let buttonBottomSpacing: CGFloat = -56
        static let buttonHorizontalPadding: CGFloat = 32
        static let buttonHeight: CGFloat = 44
        
        // Title Label Constraints
        static let titleBottomSpacingToButton: CGFloat = -24
        static let titleHorizontalPadding: CGFloat = 41
    }
    
    init(step: OnboardingStep, image: UIImage?, buttonAction: @escaping (() -> Void)) {
        self.step = step
        if let image {
            self.image = image
        }
        
        self.buttonAction = buttonAction
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
        
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        [titleLabel, imageView, actionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // Image View
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.imageTopSpacing),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.imageLeadingPadding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.imageTrailingPadding),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            // Button
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.buttonBottomSpacing),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonHorizontalPadding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonHorizontalPadding),
            actionButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            // Title Label
            titleLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: Constants.titleBottomSpacingToButton),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleHorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.titleHorizontalPadding),
        ])
    }
    
    private func configureContent() {
        titleLabel.text = step.title
        imageView.image = image
        actionButton.setTitle(step.buttonTitle, for: .normal)
    }
    
    @objc private func buttonTapped() {
        buttonAction()
    }
}
