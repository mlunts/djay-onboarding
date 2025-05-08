//
//  ActionButton.swift
//  djay onboarding
//
//  Created by Marina Lunts on 30.04.25.
//

import UIKit

@IBDesignable class ActionButton: UIButton {
    enum Constants {
        static let spacing: CGFloat = 12
    }
    
    fileprivate lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = tintColor
        return view
    }()
    
    
    var lineHeight: CGFloat = 2 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup(){
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(.contextualPrimary, for: .normal)
        
        backgroundColor = .contextualTint
        layer.cornerRadius = 8
        
        addSubview(lineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        lineView.frame.size.height = lineHeight
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        lineView.backgroundColor = .init(named: "contextualTint")
    }
}
