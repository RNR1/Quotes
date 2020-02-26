//
//  ViewController.swift
//  Quotes
//
//  Created by Ron Braha on 26/02/2020.
//  Copyright © 2020 Ron Braha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    var quoteManager = QuoteManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        quoteManager.delegate = self
        generateButton.isEnabled = false
        quoteManager.fetchRandomQuote()
    }
    
    @IBAction func generatePressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        sender.setTitle("Loading...", for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        let quote = quoteManager.getRandomQuote()
        sender.setTitle("Generate", for: .normal)
        self.quoteLabel.text = "\"\(quote.content)\""
        self.authorLabel.text = "- \(quote.author), \(quote.year)"
        
    }
    
}

//MARK: - QuoteManagerDelegate

extension ViewController: QuoteManagerDelegate {
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.generateButton.setTitle("Generate", for: .normal)
            self.quoteLabel.text = "Check your network connection."
            self.authorLabel.text = "- Ron Braha, 2020"
        }
    }
    
    func didUpdateQuote(_ quoteManager: QuoteManager, quote: QuoteModel) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.generateButton.isEnabled = true
            self.generateButton.setTitle("Generate", for: .normal)
            self.quoteLabel.text = "\"\(quote.content)\""
            self.authorLabel.text = "- \(quote.author), \(quote.year)"
        }
    }
}

