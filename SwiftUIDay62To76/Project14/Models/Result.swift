//
//  Result.swift
//  SwiftUIDay62To76
//
//  Created by Vong Nyuksoon on 30/01/2022.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [String: Page]
}

struct Page: Codable, Comparable {
    let pageId: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? "No information"
    }
    
    enum CodingKeys: String, CodingKey {
        case pageId = "pageid",
             title,
             terms
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}

