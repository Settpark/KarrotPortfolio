//
//  UIButton+.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/16/25.
//

import UIKit

extension UIButton {
    func setUnderlinedTitle(
        title: String,
        color: UIColor,
        font: UIFont,
        highlightAlpha: CGFloat = 0.5
    ) {
        let underlineStyle: NSUnderlineStyle = .single
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: underlineStyle.rawValue,
            .foregroundColor: color,
            .font: font
        ]
        let normalAttributedTitle = NSAttributedString(string: title, attributes: normalAttributes)
        self.setAttributedTitle(normalAttributedTitle, for: .normal)
        
        let highlightedAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: underlineStyle.rawValue,
            .foregroundColor: color.withAlphaComponent(highlightAlpha),
            .font: font
        ]
        let highlightedAttributedTitle = NSAttributedString(string: title, attributes: highlightedAttributes)
        self.setAttributedTitle(highlightedAttributedTitle, for: .highlighted)
    }
}
