//
//  NSMutableAttributedString+Extensions.swift
//  AvitoTechTask
//
//  Created by Pavel on 25.10.22.
//

import UIKit

extension NSMutableAttributedString {
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    func changeColorText(inputString: NSMutableAttributedString, changeColorString: String) -> NSMutableAttributedString {
        inputString.setColor(color: UIColor.aluminumWhite, forText: changeColorString)
        return inputString
    }
}
