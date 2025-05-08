//
//  OnboardingStep.swift
//  djay onboarding
//
//  Created by Marina Lunts on 05.05.25.
//

struct OnboardingStep {
    let title: String
    let description: String?
    let buttonTitle: String
    let skills: [Skill]?
    
    init(title: String, description: String? = nil, buttonTitle: String, skills: [Skill]? = nil) {
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.skills = skills
    }
}

struct Skill {
    let name: String
}
