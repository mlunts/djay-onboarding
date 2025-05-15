//
//  OnboardingSkillSelectionViewController.swift
//  djay onboarding
//
//  Created by Marina Lunts on 08.05.25.
//

import UIKit

class OnboardingSkillSelectionViewController: UIViewController {
    var onSkillSelected: (() -> Void)?

    private let titleName: String
    private let subtitle: String
    private let skills: [Skill]
    private let image: UIImage
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let tableView = UITableView()
        
    private var selectedIndex: IndexPath? {
        didSet {
            tableView.reloadData()
            onSkillSelected?()
        }
    }

    // MARK: - Adjustable Constraints
    private var imageTopConstraint: NSLayoutConstraint!
    private var imageSizeConstraint: NSLayoutConstraint!
    private var tableHeightConstraint: NSLayoutConstraint!
    private var titleTopConstraint: NSLayoutConstraint!
    
    private struct Constants {
        static let sidePadding: CGFloat = 32

        // Portrait
        static let imageTopSpacing: CGFloat = 124
        static let imageSize: CGFloat = 80
        static let titleTopSpacing: CGFloat = 40
        static let subtitleTopSpacing: CGFloat = 8
        static let tableTopSpacing: CGFloat = 24
        static let tableHeight: CGFloat = 200
        static let titleFontSize: CGFloat = 34
        static let subtitleFontSize: CGFloat = 22

        // Landscape
        static let landscapeImageTopSpacing: CGFloat = 30
        static let landscapeImageSize: CGFloat = 50
        static let landscapeTitleTopSpacing: CGFloat = 20
        static let landscapeTableHeight: CGFloat = 100
        static let landscapeTitleFontSize: CGFloat = 24
        static let landscapeSubtitleFontSize: CGFloat = 12
    }
    
    init(step: OnboardingStep, image: UIImage) {
        self.titleName = step.title
        self.subtitle = step.description ?? ""
        self.skills = step.skills ?? []
        self.image = image
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.handleOrientationChange()
        })
    }
    
    private func setupLayout() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        titleLabel.textColor = .contextualPrimary
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        subtitleLabel.font = UIFont.systemFont(ofSize: Constants.subtitleFontSize, weight: .regular)
        subtitleLabel.textColor = .contextualSecondary
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        imageTopConstraint = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.imageTopSpacing)
        imageSizeConstraint = imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize)
        tableHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: Constants.tableHeight)
        titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.titleTopSpacing)

        NSLayoutConstraint.activate([
            imageTopConstraint,
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            imageSizeConstraint,

            titleTopConstraint,
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.subtitleTopSpacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),

            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.tableTopSpacing),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sidePadding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sidePadding),
            tableHeightConstraint
        ])
        
        handleOrientationChange()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.register(SkillLevelCell.self, forCellReuseIdentifier: "SkillLevelCell")
    }
    
    private func configureContent() {
        titleLabel.text = titleName
        subtitleLabel.text = subtitle
        imageView.image = image
    }

    private func handleOrientationChange() {
        let isLandscape = UIDevice.current.orientation.isLandscape

        imageTopConstraint.constant = isLandscape ? Constants.landscapeImageTopSpacing : Constants.imageTopSpacing
        imageSizeConstraint.constant = isLandscape ? Constants.landscapeImageSize : Constants.imageSize
        titleTopConstraint.constant = isLandscape ? Constants.landscapeTitleTopSpacing : Constants.titleTopSpacing
        tableHeightConstraint.constant = isLandscape ? Constants.landscapeTableHeight : Constants.tableHeight

        titleLabel.font = UIFont.systemFont(ofSize: isLandscape ? Constants.landscapeTitleFontSize : Constants.titleFontSize, weight: .bold)
        subtitleLabel.font = UIFont.systemFont(ofSize: isLandscape ? Constants.landscapeSubtitleFontSize : Constants.subtitleFontSize, weight: .regular)
        
        tableView.isScrollEnabled = isLandscape
        
        view.layoutIfNeeded()
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
