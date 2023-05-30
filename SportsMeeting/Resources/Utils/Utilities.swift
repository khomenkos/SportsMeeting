//
//  Utilities.swift
//  SportsMeeting
//
//  Created by  Sasha Khomenko on 17.03.2023.
//

import UIKit

final class Utilities {
    
    func containerView(withlabel text: String, view: UIView) -> UIStackView {
        let stack = UIStackView()
        stack.addArrangedSubview(titleLabel(with: text))
        stack.addArrangedSubview(view)
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }
    
    func imageContainerView(withImage image: UIView, textField: UIView) -> UIStackView {
        let stack = UIStackView()
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(textField)
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }
    
    private func titleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.text = text
        label.numberOfLines = 2
        label.font = UIFont(name: "Gill Sans SemiBold", size: 17)
        return label
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.backgroundColor = .secondarySystemBackground
        return textField
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}

