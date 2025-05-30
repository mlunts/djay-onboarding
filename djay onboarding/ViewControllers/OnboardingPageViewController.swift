//
//  OnboardingPageViewController.swift
//  djay onboarding
//
//  Created by Marina Lunts on 05.05.25.
//
import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    private let pageControl = UIPageControl()
    private let gradientLayer = CAGradientLayer()
    private let actionButton = ActionButton()
    
    private var steps: [OnboardingStep] = [
        OnboardingStep(title: "Welcome to djay!", buttonTitle: "Continue"),
        OnboardingStep(title: "Mix Your Favorite Music", buttonTitle: "Continue"),
        OnboardingStep(title: "Welcome DJ",
                       description: "What’s your DJ skill level?",
                       buttonTitle: "Let's go", skills: [
                        Skill(name: "I'm new to DJing"),
                        Skill(name: "I've used DJ apps before"),
                        Skill(name: "I'm a professional DJ")
                       ]),
        OnboardingStep(title: "You're All Set!", buttonTitle: "Done")
    ]
    
    private var currentIndex = 0
    
    // MARK: - Layout Constants
    
    private struct Constants {
        static let buttonBottomSpacing: CGFloat = -56
        static let buttonHorizontalPadding: CGFloat = 32
        static let buttonHeight: CGFloat = 44
        static let pageControlBottomSpacing: CGFloat = -10
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = nil
        delegate = self
        
        setupUI()
        configureFirstPage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addGradient()
        setupButton()
        setupPageControl()
    }
    
    private func addGradient() {
        gradientLayer.colors = [UIColor.gradientTop.cgColor, UIColor.gradientBottom.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = steps.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.pageControlBottomSpacing),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupButton() {
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.buttonBottomSpacing),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonHorizontalPadding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonHorizontalPadding),
            actionButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    // MARK: - Page Management
    
    private func configureFirstPage() {
        guard let firstVC = viewController(at: 0) else { return }
        setViewControllers([firstVC], direction: .forward, animated: false)
    }
    
    private func viewController(at index: Int) -> UIViewController? {
        guard index >= 0, index < steps.count else { return nil }
        let step = steps[index]
        
        actionButton.setTitle(step.buttonTitle, for: .normal)
        
        switch index {
        case 0:
            return OnboardingWelcomeStepViewController(step: step, image: .logo)
        case 1:
            return OnboardingInfoStepViewController(step: step, logoImage: .logo, heroImage: .hero, adaImage: .ADA)
        case 2:
            updateButton(isActive: false)
            let vc = OnboardingSkillSelectionViewController(step: step, image: .icon)
            vc.onSkillSelected = { [weak self] in
                self?.updateButton(isActive: true)
            }
            return vc
        case 3:
            return OnboardingInfoStepViewController(step: step, shouldAnimate: false)
        default:
            return nil
        }
    }
    
    private func handleNextStep() {
        let nextIndex = currentIndex + 1
        guard nextIndex < steps.count, let nextVC = viewController(at: nextIndex) else {
            dismiss(animated: true)
            return
        }
        
        let shouldAnimate = currentIndex == 2 && nextIndex == 3
        
        setViewControllers([nextVC], direction: .forward, animated: shouldAnimate) { [weak self] _ in
            guard let self = self else { return }
            self.currentIndex = nextIndex
            self.pageControl.currentPage = nextIndex
        }
    }
    
    private func updateButton(isActive: Bool = false) {
        actionButton.isEnabled = isActive
        actionButton.layer.opacity = isActive ? 1.0 : 0.3
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped() {
        if let currentVC = viewControllers?.first as? OnboardingWelcomeStepViewController {
            currentVC.animate {
                self.handleNextStep()
            }
        } else {
            handleNextStep()
        }
    }
}

// MARK: - UIPageViewController Data Source (disabled)

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? { nil }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? { nil }
}
