//
//  BibleChapterContentModel.swift
//  RFP
//
//  Created by Apple on 24/06/2024.
//

import Foundation

struct BibleChapterContentModel: Codable {
    let data: BibleChapterContentModelData?
    let meta: Meta?
}

// MARK: - DataClass
struct BibleChapterContentModelData: Codable {
    let id, bibleID, number, bookID: String?
    let reference, copyright: String?
    let verseCount: Int?
    let content: String?
    let next, previous: Next?

    enum CodingKeys: String, CodingKey {
        case id
        case bibleID = "bibleId"
        case number
        case bookID = "bookId"
        case reference, copyright, verseCount, content, next, previous
    }
}

// MARK: - Next
struct Next: Codable {
    let id, number, bookID: String?

    enum CodingKeys: String, CodingKey {
        case id, number
        case bookID = "bookId"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let fums, fumsID, fumsJSInclude, fumsJS: String?
    let fumsNoScript: String?

    enum CodingKeys: String, CodingKey {
        case fums
        case fumsID = "fumsId"
        case fumsJSInclude = "fumsJsInclude"
        case fumsJS = "fumsJs"
        case fumsNoScript
    }
}
