//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by macuser on 3/16/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let urlString = "http://api.weatherstack.com/current?access_key=181e6509550bb271d8f6aca1bc3fd96a&query=\(searchBar.text!)"
        
        let url = URL(string: urlString)
        
        var locationName: String?
        var temperature: Double?
        
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                }
                
                if let current = json["current"] {
                    temperature = current["temp_c"] as? Double
                }
                
                
                
                
            }
            catch let jsonError {
                print(jsonError)
            }
            
        }
        task.resume()
        
        
    }
}
