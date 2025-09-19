//
//  BibleChapterModel.swift
//  RFP
//
//  Created by Apple on 24/06/2024.
//

import Foundation

struct BibleChapterModel: Codable {
    let data: [BibleChapterData]?
}

// MARK: - Datum
struct BibleChapterData: Codable {
    let id: String?
    let bibleID: String?
    let bookID: String?
    let number, reference: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case bibleID = "bibleId"
        case bookID = "bookId"
        case number, reference
    }
}
