//
//  LocationTableViewController.swift
//  WeatherApp
//
//  Created by calum boustead on 28/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController  {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //MARK: Celcius/Fahrenheit selection

    //MARK: ViewController
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("View did appear")
        print(WeatherData.weatherData)
        self.tableView.reloadData()
    }

    //MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return WeatherData.weatherData.weather.count + 1
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("index", indexPath.row)
        print("count", WeatherData.weatherData.weather.count)
        if indexPath.row < WeatherData.weatherData.weather.count {
            // Configure the cell...
            let cellIdentifier = "MyLocationTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyLocationTableViewCell else {
                fatalError("The dequeued cell is not an instance of MyLocationTableViewCell.")
            }
            
            cell.locationLabel.text = String(WeatherData.weatherData.weather[indexPath.row].location!)
            cell.tempLabel.text = tempToMetricorImperial(unitTemp: WeatherData.weatherData.weather[indexPath.row].current!.temp!)
            cell.timeLabel.text = getTime(unixTime: WeatherData.weatherData.weather[indexPath.row].current!.dt!)
            WeatherData.weatherData.weather[indexPath.row].index = indexPath.row

             return cell
        } else {
            // Configure the cell...
            let cellIdentifier = "AddLocationTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AddLocationTableViewCell else {
                fatalError("The dequeued cell is not an instance of AddLocationTableViewCell.")
            }
            if(WeatherData.weatherData.unitCelcius){
                cell.celcuisButton.setTitleColor(.black, for: .normal)
                cell.fahrenheitBtutton.setTitleColor(.gray, for: .normal)
               
            }else{
                cell.celcuisButton.setTitleColor(.gray, for: .normal)
                cell.fahrenheitBtutton.setTitleColor(.black, for: .normal)
            }
           
             return cell
        }
    }
   
    // When a user select a location, navigate to weather page
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //check that the chosen table view cell is a location
        if(indexPath.row<WeatherData.weatherData.weather.count){
            performSegue(withIdentifier: "showWeatherSegue", sender: self)
        }
        
    }
    
    //MARK: Celcius/Fahrenheit selection
    @IBAction func celcuisPressed(_ sender: UIButton) {
        if(!WeatherData.weatherData.unitCelcius){
            WeatherData.weatherData.unitCelcius = true
            self.tableView.reloadData()
        }
    }
    
    @IBAction func fahrenheitPressed(_ sender: UIButton) {
        if(WeatherData.weatherData.unitCelcius){
            WeatherData.weatherData.unitCelcius = false
            self.tableView.reloadData()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
