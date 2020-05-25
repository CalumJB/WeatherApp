//
//  AddLocationViewController.swift
//  WeatherApp
//
//  Created by calum boustead on 29/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit
import CoreLocation

class AddLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CLLocationManagerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewController: UITableView!
    var locationArray = [String]()
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewController.delegate = self
        viewController.dataSource = self
        searchBar.delegate = self
        manager.delegate = self
        
        //location
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        
        
        // Edit search bar
        searchBar.becomeFirstResponder()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: TableView Delegate & Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count + 1
    }
    
    
    // Populate table view with the location in the array list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellIdentifier = "CurrentLocationTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CurrentLocationTableViewCell else {
                fatalError("The dequeued cell is not an instance of CurrentLocationTableViewCell.")
            }
            
            return cell
        } else {
            // Get a cell
            let cellIdentifier = "SearchResultTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchResultTableViewCell else {
                fatalError("The dequeued cell is not an instance of AddLocationTableViewCell.")
            }
            
            // Display results returned by autocomplete
            cell.locationLabel.text = locationArray[indexPath.row-1]
            
            return cell
        }
        
        
        
    }
    
    // When a table view cell is tapped get the weather data for that location
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            //get user location
            print("requesting locaiton")
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
            //add to array
            
            //dismiss
            
        }else{
            guard let cell = tableView.cellForRow(at: indexPath) as? SearchResultTableViewCell else { return }
            
            //get address in url format
            var address = cell.locationLabel.text!.replacingOccurrences(of: ", ", with: "%20")
            address = address.replacingOccurrences(of: " ", with: "%20")
            
            //get name for display purposes
            let nameArray = cell.locationLabel.text!.components(separatedBy:",")
            let name = nameArray[0]
            // Get geometry coordinates of location and then get weather for those coordinates
            doRequestForGeomery(address: address, nameOfLocation: name) {
                //dismiss if succeeded
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        
        

    }
    
    
    
    //MARK: SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search for: " + searchText)
        
        let key = "AIzaSyAHBr0CijiFUOXaiMkbOPHIsfhCp_tXkFA"
        
        let urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
            + "input=" + searchText
            + "&key=" + key
            + "&language=en"
        
        // Get autocomplete locations
        doRequestForAutocomplete(urlString: urlString, array: self.locationArray) { ( json) in
            
            // Replace array with new autocomplete values
            self.locationArray.removeAll()
               for loc in json.predictions {
                self.locationArray.append(loc.description!)
               }
            
            // Reload data in table view
            DispatchQueue.main.async {
                self.viewController.reloadData()
            }
        }
        
       
        
    }
    
    // Return to previous view controller
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Location Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            doRequestForWeather(address: "", lat: Float(location.coordinate.latitude), lng: Float(location.coordinate.longitude), nameOfLocation: "unknown") {
                // Reload data in table view
                print("dorequestforweathercomplete")
                doRequestForReverseGeoCoding(lon: location.coordinate.latitude, lat: location.coordinate.longitude) {
                    print("dorequestforreversegeodcodng")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
  
    
    

}




//struct to store fetched locations

struct LocationData: Codable {
    var predictions = [LocationDescriptions]()
}

struct LocationDescriptions: Codable {
    let description: String?
}

// struct to store long lat
struct GeometryData: Codable {
    var results = [Geomety]()
}

struct Geomety: Codable {
    var geometry: GeometryLocation?
}

struct GeometryLocation: Codable {
    var location: GeometryLatLng?
}

struct GeometryLatLng: Codable {
    var lat: Float?
    var lng: Float?
}
