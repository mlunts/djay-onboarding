//
//  OnboardingPageViewController.swift
//  djay onboarding
//
//  Created by Marina Lunts on 05.05.25.
//
import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private let pageControl = UIPageControl()
    private let gradientLayer = CAGradientLayer()
    
    private var steps: [OnboardingStep] = [
        OnboardingStep(title: "Welcome to djay!", description: "Welcome to djay!", buttonTitle: "Continue"),
        OnboardingStep(title: "Mix Your Favorite Music", description: "", buttonTitle: "Continue"),
        OnboardingStep(title: "Welcome DJ",
                       description: "What’s your DJ skill level?",
                       buttonTitle: "Let's go", skills: [
                        Skill(name: "I'm new to DJing"),
                        Skill(name: "I've used DJ apps before"),
                        Skill(name: "I'm a professional DJ")
                       ]),
        OnboardingStep(title: "", buttonTitle: "Done")
    ]
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = nil // Disable swiping
        delegate = self
        
        setupUI()
        
        if let firstVC = viewController(at: 0) {
            setViewControllers([firstVC], direction: .forward, animated: false)
        }
        
        setupPageControl()
    }
    
    // MARK: - View Controller Setup
    
    private func viewController(at index: Int) -> UIViewController? {
        guard index >= 0, index < steps.count else { return nil }
        switch index {
        case 0:
            return OnboardingWelcomeStepViewController(
                step: steps[index],
                image: .logo) { [weak self] in
                    self?.handleNextStep()
                }
        case 1:
            return OnboardingInfoStepViewController(
                step: steps[index],
                logoImage: .logo,
                heroImage: .hero,
                adaImage: .ADA) { [weak self] in
                    self?.handleNextStep()
                }
        case 2:
            return OnboardingSkillSelectionViewController(
                step: steps[index],
                image: .icon) { [weak self] in
                    self?.handleNextStep()
                }
        case 3:
            return OnboardingWelcomeStepViewController(
                step: steps[index],
                image: nil) { [weak self] in
                    self?.handleNextStep()
                }
        default:
            return nil
        }
    }
    
    // MARK: - Handle Next Step
    
    private func handleNextStep() {
        let nextIndex = currentIndex + 1
        if nextIndex < steps.count, let nextVC = viewController(at: nextIndex) {
            
            setViewControllers([nextVC], direction: .forward, animated: false) { [weak self] _ in
                guard let self = self else { return }
                
                // Custom transition for 0 → 1
                if currentIndex == 0 && nextIndex == 1 {
                    nextVC.view.alpha = 0
                    nextVC.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    
                    UIView.animate(withDuration: 0.6,
                                   delay: 0,
                                   usingSpringWithDamping: 0.8,
                                   initialSpringVelocity: 0.5,
                                   options: [.curveEaseInOut],
                                   animations: {
                        nextVC.view.alpha = 1
                        nextVC.view.transform = .identity
                    })
                } else if currentIndex == 1 && nextIndex == 2 {
                    // 1 → 2 Slide transition
                    let containerView = self.view!
                    
                    let fromView = containerView.subviews.first(where: { $0 is UIView && $0 != self.pageControl })!
                    let toView = nextVC.view!
                    
                    let width = containerView.bounds.width
                    toView.frame = containerView.bounds.offsetBy(dx: width, dy: 0)
                    containerView.addSubview(toView)
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
                        fromView.frame = containerView.bounds.offsetBy(dx: -width, dy: 0)
                        toView.frame = containerView.bounds
                    }, completion: { _ in
                        fromView.removeFromSuperview()
                    })
                    
                } else {
                    // Fade transition for others
                    nextVC.view.alpha = 0
                    UIView.animate(withDuration: 0.4) {
                        nextVC.view.alpha = 1
                    }
                }
                
                
                // Update index & page control
                self.currentIndex = nextIndex
                self.pageControl.currentPage = nextIndex
            }
            
        } else {
            dismiss(animated: true)
        }
    }
    
    // MARK: - UIPageViewController Data Source (disabled)
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil // Swiping disabled
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil // Swiping disabled
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        addGradient()
    }
    
    private func addGradient() {
        gradientLayer.colors = [UIColor.gradientTop.cgColor, UIColor.gradientBottom.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = steps.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
