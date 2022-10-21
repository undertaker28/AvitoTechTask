//
//  Company.swift
//  AvitoTechTask
//
//  Created by Pavel on 22.10.22.
//

import Foundation

// MARK: - ParseModel
struct ParseModel: Codable {
    let company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    let name, phoneNumber: String
    let skills: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
