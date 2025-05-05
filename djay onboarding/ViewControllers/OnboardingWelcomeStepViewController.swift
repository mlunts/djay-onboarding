//
//  OnboardingStepViewController.swift
//  djay onboarding
//
//  Created by Marina Lunts on 05.05.25.
//
import UIKit

class OnboardingWelcomeStepViewController: UIViewController {
    
    var step: OnboardingStep?
    var buttonAction: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let actionButton = ActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupLayout()
        configureContent()
    }
    
    private func setupLayout() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .contextualPrimary
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .scaleAspectFit
        
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        [titleLabel, imageView, actionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 240),
            imageView.heightAnchor.constraint(equalToConstant: 240),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                 
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureContent() {
        guard let step = step else { return }
        titleLabel.text = step.title
        imageView.image = step.imageName != nil ? UIImage(named: step.imageName!) : nil
        actionButton.setTitle(step.buttonTitle, for: .normal)
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
