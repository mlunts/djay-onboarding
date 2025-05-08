//
//  SkillLevelCell.swift
//  djay onboarding
//
//  Created by Marina Lunts on 08.05.25.
//

import UIKit

class SkillLevelCell: UITableViewCell {
    
    private enum Constants {
        static let containerCornerRadius: CGFloat = 12
        static let containerVerticalPadding: CGFloat = 6
        static let containerMinHeight: CGFloat = 48
        static let checkmarkSize: CGFloat = 24
        static let horizontalPadding: CGFloat = 16
        static let titleFontSize: CGFloat = 17
        static let selectedBorderWidth: CGFloat = 2
    }
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let checkmarkView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .contextualQuaternary
        containerView.layer.cornerRadius = Constants.containerCornerRadius
        contentView.addSubview(containerView)
        
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkView.contentMode = .center
        checkmarkView.tintColor = .contextualUnactive
        containerView.addSubview(checkmarkView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .regular)
        titleLabel.textColor = .contextualPrimary
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.containerVerticalPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.containerVerticalPadding),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.containerMinHeight),
            
            checkmarkView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.horizontalPadding),
            checkmarkView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkmarkView.widthAnchor.constraint(equalToConstant: Constants.checkmarkSize),
            checkmarkView.heightAnchor.constraint(equalToConstant: Constants.checkmarkSize),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkmarkView.trailingAnchor, constant: Constants.horizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.horizontalPadding),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func configure(with title: String, selected: Bool) {
        titleLabel.text = title
        if selected {
            containerView.layer.borderWidth = Constants.selectedBorderWidth
            containerView.layer.borderColor = UIColor.contextualTint.cgColor
            checkmarkView.image = .checkmark
            checkmarkView.tintColor = .contextualTint
        } else {
            containerView.layer.borderWidth = 0
            containerView.layer.borderColor = nil
            checkmarkView.image = UIImage(systemName: "circle")
            checkmarkView.tintColor = .contextualUnactive
        }
    }
}
