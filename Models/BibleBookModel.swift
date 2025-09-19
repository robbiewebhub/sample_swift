//
//  BibleBookModel.swift
//  RFP
//
//  Created by Apple on 04/07/2024.
//

import Foundation

struct BibleBookModel: Codable {
    let data: [BibleBookData]?
}

// MARK: - Datum
struct BibleBookData: Codable {
    let id: String?
    let bibleID: String?
    let abbreviation, name, nameLong: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bibleID = "bibleId"
        case abbreviation, name, nameLong
    }
}
