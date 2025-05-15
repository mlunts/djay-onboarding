# djay Onboarding Demo

## Overview

This is a demo iOS application implementing a 4-step onboarding flow using UIKit, designed to closely follow the provided Figma prototype and specification. The flow is fully responsive, handling both portrait and landscape orientations.

## Task Requirements
### Task:
Create a 4-step onboarding flow for an iPhone application, implementing design and transitions for steps 1-3 based on the provided Figma Design.
For step 4, use the selected DJ skill level to show a final congratulations-style screen.

### Requirements:
Use UIKit (no SwiftUI).
The UI should be responsive for both portrait and landscape orientations.
Must work on all screen sizes, from iPhone SE (1st Gen) to iPhone 16 Pro Max.
Smooth, native-feeling transition animations.

## Onboarding Flow
Welcome Screen — App introduction with logo and primary action button.
Feature Overview — Highlights app features with supporting imagery.
Skill Selection — User selects their DJ skill level.
Congratulations Screen — Displays a final screen tailored to the selected skill level.

## Tech & Approach

UIKit-based implementation, without storyboards.
Custom onboarding UIPageViewController handling onboarding screens and navigation.
CAGradientLayer background for consistent visual style.
Custom ActionButton component with dynamic enable/disable states.
UITableView-driven skill selection in step 3.
Orientation handling integrated into each screen, using viewWillTransition for layout updates.
Dynamic font sizing to maintain readability across screen sizes.

### Installation

Clone the repository:
git clone https://github.com/yourusername/djay-onboarding-demo.git
cd djay-onboarding-demo
Open djay-onboarding-demo.xcodeproj in Xcode 15 (or compatible).
Run the project on an iPhone simulator or physical device.

## Screenshots
#### Portrait 
<img src="https://github.com/user-attachments/assets/45cbad8c-b4dd-4b02-9b96-ba9171b0619c" width=200> <img src="https://github.com/user-attachments/assets/159e3d65-91a0-40ec-ad1f-169073d9673c" width=200>
<img src="https://github.com/user-attachments/assets/bdd34f9f-6c73-4d4b-aafd-3d08f4f5dab1" width=200> <img src="https://github.com/user-attachments/assets/3eabb14a-d4c3-4369-bc05-e595b932b2c3" width=200>
#### Landscape  
<img src="https://github.com/user-attachments/assets/af87dd01-5fe3-48e4-bc21-f737c00e86d4" width=500> <img src="https://github.com/user-attachments/assets/5676a935-cf89-48d0-8ee5-4900b785b1fa" width=500>
<img src="https://github.com/user-attachments/assets/f99a18a6-9d87-4338-9fb2-6c431f077b8b" width=500> 
