//
//  ActiveMemberListModel.swift
//  RFP
//
//  Created by macos on 15/10/24.
//

import Foundation

struct ActiveMemberListModel: Codable {
    let success: Bool
    let code: Int
    let message: String
    let data: ActiveMemberListData
}

// MARK: - DataClass
struct ActiveMemberListData: Codable {
    let count: Int
    let joinedUsers: [String]
    let joinedUsersPhoto: [String]
    
    enum CodingKeys: String, CodingKey {
        case count
        case joinedUsers = "joined_users"
        case joinedUsersPhoto = "joined_users_photo"
    }
}
