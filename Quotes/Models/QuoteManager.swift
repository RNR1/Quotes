//
//  QuoteManager.swift
//  Quotes
//
//  Created by Ron Braha on 26/02/2020.
//  Copyright © 2020 Ron Braha. All rights reserved.
//

import Foundation

protocol QuoteManagerDelegate {
    func didUpdateQuote(_ quoteManager: QuoteManager, quote: QuoteModel)
    func didFailWithError(error: Error)
}

class QuoteManager {
    
    let quoteURL = "https://quote-garden.herokuapp.com/quotes/all"
    var quotes: [QuoteModel] = []
    
    var delegate: QuoteManagerDelegate?
    
    func fetchRandomQuote() {
        if let url = URL(string: quoteURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ quoteData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(QuoteData.self, from: quoteData)
            for result in decodedData.results {
                let content = result.quoteText
                let author = result.quoteAuthor.isEmpty ? "Anonymous" : result.quoteAuthor
                let year = String(Int.random(in: 1920...2020))
                quotes.append(QuoteModel(content: content, author: author, year: year))
            }
            delegate?.didUpdateQuote(self, quote: getRandomQuote())
            
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func getRandomQuote() -> QuoteModel {
        let random = Int.random(in: 0..<quotes.count)
        let quote = quotes[random]
        return quote
    }
}
