//
//  ViewController+Extensions.swift
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
        return data?.company.employees.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmployeeCollectionViewCell.self), for: indexPath) as! EmployeeCollectionViewCell
        guard let employeesFiltered = employeesFiltered else { return cell }
        let dataSourceAtIndexPath = employeesFiltered[indexPath.row]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        let attributedString = NSMutableAttributedString(string: "")
        
        var coloredAttributedString = attributedString.changeColorText(inputString: makeStringWithDifferentFonts(firstString: "Name\n", secondString: dataSourceAtIndexPath.name), changeColorString: "Name")
        coloredAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, coloredAttributedString.length))
        cell.nameLabel.attributedText = coloredAttributedString
        
        coloredAttributedString = attributedString.changeColorText(inputString: makeStringWithDifferentFonts(firstString: "Phone number\n", secondString: dataSourceAtIndexPath.phoneNumber), changeColorString: "Phone number")
        coloredAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, coloredAttributedString.length))
        cell.phoneNumberLabel.attributedText = coloredAttributedString
        
        coloredAttributedString = attributedString.changeColorText(inputString: makeStringWithDifferentFonts(firstString: "Skills\n", secondString: dataSourceAtIndexPath.skills.joined(separator: ", ")), changeColorString: "Skills")
        coloredAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, coloredAttributedString.length))
        cell.skillsLabel.attributedText = coloredAttributedString
        
        title = data?.company.name
        return cell
    }
    
    func makeStringWithDifferentFonts(firstString: String, secondString: String) -> NSMutableAttributedString {
        let stringWithDifferentFonts = NSMutableAttributedString(string: firstString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]);
        stringWithDifferentFonts.append(NSMutableAttributedString(string: secondString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]));
        return stringWithDifferentFonts
    }
}
