//
//  EmployeeCollectionViewCell.swift
//  AvitoTechTask
//
//  Created by Pavel on 22.10.22.
//

import UIKit

class EmployeeCollectionViewCell: UICollectionViewCell {
    
    lazy var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 2
        nameLabel.font = .systemFont(ofSize: 14)
        return nameLabel
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        var phoneNumberLabel = UILabel()
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.numberOfLines = 2
        phoneNumberLabel.font = .systemFont(ofSize: 14)
        return phoneNumberLabel
    }()
    
    lazy var skillsLabel: UILabel = {
        var skillsLabel = UILabel()
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsLabel.numberOfLines = 2
        skillsLabel.font = .systemFont(ofSize: 14)
        return skillsLabel
    }()
    
    lazy var separatorViewUnderNameLabel: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray5
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    lazy var separatorViewUnderPhoneNumberLabel: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray5
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(separatorViewUnderNameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(separatorViewUnderPhoneNumberLabel)
        contentView.addSubview(skillsLabel)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            nameLabel.heightAnchor.constraint(equalToConstant: 43),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            separatorViewUnderNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            separatorViewUnderNameLabel.heightAnchor.constraint(equalToConstant: 0.5),
            separatorViewUnderNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            separatorViewUnderNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            phoneNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 52),
            phoneNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            separatorViewUnderPhoneNumberLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            separatorViewUnderPhoneNumberLabel.heightAnchor.constraint(equalToConstant: 0.5),
            separatorViewUnderPhoneNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            separatorViewUnderPhoneNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
            
            skillsLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 12),
            skillsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            skillsLabel.heightAnchor.constraint(equalToConstant: 52),
            skillsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
