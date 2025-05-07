//
//  OnboardingPageViewController.swift
//  djay onboarding
//
//  Created by Marina Lunts on 05.05.25.
//
import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var steps: [OnboardingStep] = [
        OnboardingStep(title: "Welcome to djay!", description: "Welcome to djay!", imageName: "logo", buttonTitle: "Continue")
    ]
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        setupUI()
        
        if let firstVC = viewController(at: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    private func viewController(at index: Int) -> OnboardingWelcomeStepViewController? {
        guard index >= 0, index < steps.count else { return nil }
        let vc = OnboardingWelcomeStepViewController()
        vc.step = steps[index]
        vc.buttonAction = { [weak self] in
            self?.handleNextStep()
        }
        return vc
    }
    
    private func handleNextStep() {
        if currentIndex < steps.count - 1 {
            currentIndex += 1
            if let nextVC = viewController(at: currentIndex) {
                setViewControllers([nextVC], direction: .forward, animated: true)
            }
        } else {
            dismiss(animated: true)
        }
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard currentIndex > 0 else { return nil }
        return self.viewController(at: currentIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard currentIndex < steps.count - 1 else { return nil }
        return self.viewController(at: currentIndex + 1)
    }
}

extension OnboardingPageViewController {
    private func setupUI() {
        addGradient()
    }
    
    private func addGradient() {
        let gradientLayer =  CAGradientLayer()
        gradientLayer.colors = [UIColor.gradientTop.cgColor, UIColor.gradientBottom.cgColor]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
