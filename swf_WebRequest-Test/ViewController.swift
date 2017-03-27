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
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelBirthYear: UILabel!
    @IBOutlet weak var labelHairColor: UILabel!
    
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
                        
                        print(jsonData)
                        let rawString = String(describing: jsonData)
                        
                        DispatchQueue.main.async {
                            self.textViewJson.text = rawString
                        }
                        
                        if let dict = jsonData as? Dictionary<String, Any> {
                            if let name = dict["name"] as? String, let height = dict["height"] as? String, let birthYear = dict["birth_year"] as? String, let hairColor = dict["hair_color"] as? String {
                                
                                let person = SWPerson(name: name, height: height, birthYear: birthYear, hairColor: hairColor)
                                
                                DispatchQueue.main.async {
                                    self.labelName.text = person.name
                                    self.labelHeight.text = person.height
                                    self.labelBirthYear.text = person.birthYear
                                    self.labelHairColor.text = person.haircolor
                                }

                                
                            }
                        }
                        
                        
                    } catch {
                        self.textViewJson.text = "Error: Could not serialize"
                    }
                }
                
            }).resume()
        }
    }



}

