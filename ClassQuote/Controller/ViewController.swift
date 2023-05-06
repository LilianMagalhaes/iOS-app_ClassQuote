//
//  ViewController.swift
//  ClassQuote
//
//  Created by Lilian MAGALHAES on 2023-03-29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuoteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startApp ()
    }
    
    private func startApp () {
        quoteLabel.text = ""
        authorLabel.text = ""
        tappedNewQuoteButton ()
        addShadowToQuoteLabel()
    }
    
    private func addShadowToQuoteLabel () {
    quoteLabel.layer.shadowColor = UIColor.black.cgColor
    quoteLabel.layer.shadowOpacity = 0.9
    quoteLabel.layer.shadowOffset=CGSize(width:1,height:1)
    }

    @IBAction func tappedNewQuoteButton () {
        toggleActivityIndicator(shown: true)
        
        QuoteService.shared.getQuote { success, quote in
            self.toggleActivityIndicator(shown: false)
            guard let quote = quote, success == true else{
                self.presentAlert()
            return
        }
            self.updateQuote(quote: quote)
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        newQuoteButton.isHidden = shown
        activityIndicator.isHidden = !shown
        
    }
    
    private func updateQuote(quote: Quote) {
        imageView.image = UIImage(data: quote.imageData)
        quoteLabel.text = quote.text
        authorLabel.text = quote.author
    }
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Quote download failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

