//
//  PersonnalAccounts.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 26/08/21.
//

import Foundation

// MARK: - PersonnalAccounts
struct PersonnalAccounts: Codable {
    let accounts, cards: [Account]
}

// MARK: - Account
struct Account: Codable {
    let accountName: String?
    let accountNumber, contactNumber, currentBalance: String
    let cardType: String?

    enum CodingKeys: String, CodingKey {
        case accountName = "AccountName"
        case accountNumber = "Account Number"
        case contactNumber = "Contact Number"
        case currentBalance = "Current Balance"
        case cardType = "CardType"
    }
}

