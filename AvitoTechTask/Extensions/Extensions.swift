//
//  Extensions.swift
//  AvitoTechTask
//
//  Created by Pavel on 24.10.22.
//

import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - 32
        return CGSize(width: width, height: 200)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkManager.companyModel?.company.employees.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmployeeCollectionViewCell.self), for: indexPath) as! EmployeeCollectionViewCell
        var dataSource = networkManager.companyModel!.company.employees
        dataSource.sort(by: {$0.name < $1.name})
        let dataSourceAtIndexPath = dataSource[indexPath.row]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        var attributedString = changeColorText(inputString: makeStringWithDifferentFonts(firstString: "Name\n", secondString: dataSourceAtIndexPath.name), changeColorString: "Name")
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        cell.nameLabel.attributedText = attributedString
        
        attributedString = changeColorText(inputString: makeStringWithDifferentFonts(firstString: "Phone number\n", secondString: dataSourceAtIndexPath.phoneNumber), changeColorString: "Phone number")
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        cell.phoneNumberLabel.attributedText = attributedString
        
        attributedString = changeColorText(inputString: makeStringWithDifferentFonts(firstString: "Skills\n", secondString: dataSourceAtIndexPath.skills.joined(separator: ", ")), changeColorString: "Skills")
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        cell.skillsLabel.attributedText = attributedString
        
        title = networkManager.companyModel!.company.name
        return cell
    }
    
    func makeStringWithDifferentFonts(firstString: String, secondString: String) -> NSMutableAttributedString {
        var stringWithDifferentFonts = NSMutableAttributedString(string: firstString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]);
        stringWithDifferentFonts.append(NSMutableAttributedString(string: secondString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]));
        return stringWithDifferentFonts
    }
    
    func changeColorText(inputString: NSMutableAttributedString, changeColorString: String) -> NSMutableAttributedString {
        inputString.setColor(color: UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1), forText: changeColorString)
        return inputString
    }
}

extension NSMutableAttributedString {
    func setColor(color: UIColor, forText stringValue: String) {
       let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
