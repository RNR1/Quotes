//
//  Quote.swift
//  Quotes
//
//  Created by Ron Braha on 26/02/2020.
//  Copyright © 2020 Ron Braha. All rights reserved.
//

import Foundation

struct QuoteData: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let quoteText: String
    let quoteAuthor: String
}
