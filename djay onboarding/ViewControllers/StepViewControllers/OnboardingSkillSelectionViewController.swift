//
//  OnboardingSkillSelectionViewController.swift
//  djay onboarding
//
//  Created by Marina Lunts on 08.05.25.
//


import UIKit

class OnboardingSkillSelectionViewController: UIViewController {
    
    private let buttonAction: (() -> Void)?
    
    private let titleName: String
    private let subtitle: String
    private let skills: [Skill]
    private let buttonTitle: String
    private let image: UIImage
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let tableView = UITableView()
    private let actionButton = ActionButton()
        
    private var selectedIndex: IndexPath? {
        didSet {
            tableView.reloadData()
            updateButtonView(isActive: true)
            actionButton.isEnabled = selectedIndex != nil
        }
    }
    
    private struct Constants {
        static let sidePadding: CGFloat = 32
        
        static let imageTopSpacing: CGFloat = 124
        static let imageSize: CGFloat = 80
        
        static let titleTopSpacing: CGFloat = 40
        static let subtitleTopSpacing: CGFloat = 8
        
        static let tableTopSpacing: CGFloat = 24
        static let tableHeight: CGFloat = 200
        static let buttonBottomSpacing: CGFloat = -56
        static let buttonHeight: CGFloat = 44
        static let buttonHorizontalPadding: CGFloat = 32
    }
    
    init(step: OnboardingStep, image: UIImage, buttonAction: (() -> Void)? = nil) {
        self.titleName = step.title
        self.subtitle = step.description ?? ""
        self.skills = step.skills ?? []
        self.buttonTitle = step.buttonTitle
        self.image = image
        self.buttonAction = buttonAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureContent()
        setupTableView()
    }
    
    private func setupLayout() {
        imageView.image = .icon
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .contextualPrimary
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        subtitleLabel.textColor = .contextualSecondary
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        actionButton.isEnabled = false
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        updateButtonView()
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.imageTopSpacing),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.titleTopSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.subtitleTopSpacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),
            
            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.tableTopSpacing),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),
            tableView.heightAnchor.constraint(equalToConstant: Constants.tableHeight),
            
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.buttonBottomSpacing),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.buttonHorizontalPadding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.buttonHorizontalPadding),
            actionButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
        ])
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(SkillLevelCell.self, forCellReuseIdentifier: "SkillLevelCell")
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
    
    private func configureContent() {
        titleLabel.text = titleName
        subtitleLabel.text = subtitle
        imageView.image = image

        actionButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func updateButtonView(isActive: Bool = false) {
        actionButton.layer.opacity = isActive ? 1 : 0.3
    }
}

extension OnboardingSkillSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillLevelCell", for: indexPath) as! SkillLevelCell
        let isSelected = selectedIndex == indexPath
        cell.configure(with: skills[indexPath.row].name, selected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
    }
}
