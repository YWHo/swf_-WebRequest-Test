//
//  ViewController.swift
//  swf_WebRequest-Test
//
//  Created by Brian Ho on 27/03/2017.
//  Copyright © 2017 Brian Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textViewJson: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://swapi.co/api/people/1"
        let session = URLSession.shared
        let url = URL(string: urlString)
        
        if let url = url {
            session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                
                if let responseData = data {
                    
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        self.textViewJson.text = "\(jsonData)"
                        
                    } catch {
                        self.textViewJson.text = "Error: Could not serialize"
                    }
                }
                
            }).resume()
        }
    }



}

