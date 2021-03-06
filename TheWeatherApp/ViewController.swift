//
//  ViewController.swift
//  TheWeatherApp
//
//  Created by macuser on 3/16/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() //убрать клавиатуру
        
        
        let urlString = "http://api.weatherstack.com/current?access_key=181e6509550bb271d8f6aca1bc3fd96a&query=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))"
        
        let url = URL(string: urlString)
        
        var locationName: String?
        var temperature: Double?
        var errorHasOccured: Bool = false
        
        
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let _ = json["error"] {
                    errorHasOccured = true
                }
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                }
                
                if let current = json["current"] {
                    temperature = current["temperature"] as? Double
                }
                
                
                DispatchQueue.main.async {
                    if errorHasOccured {
                        
                        self?.cityLabel.text = "Error has occured"
                        self?.temperatureLabel.isHidden = true
                    }
                    else {
                        self?.cityLabel.text = locationName
                        self?.temperatureLabel.text = "\(temperature!)"
                        
                        self?.temperatureLabel.isHidden = false
                    }
                    
                    
                }
                
                
                
                
            }
            catch let jsonError {
                print(jsonError)
            }
            
        }
        task.resume()
        
        
    }
}
