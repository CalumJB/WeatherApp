//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by calum boustead on 20/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    var weather: LocalWeatherData?
    
    let backroundColor = UIColor(red: 242, green: 242, blue: 242, alpha: 1)


    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loaded Table View Controller")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
  
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let days = weather!.daily!.count
        return 4 + days
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        // Configure the cell...
        if indexPath.row == 0 {
            
            let cellIdentifier = "LocationTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationTableViewCell else {
                    fatalError("The dequeued cell is not an instance of LocationTableViewCell.")
            }
            //cell.locationLabel.text = WeatherData.weatherData.weather.
            //cell.dateLabel.text = weather?.current.dt
            cell.locationLabel.text = String(describing: weather!.location!)
            cell.dateLabel.text = weather!.current!.weather![0].main!
            return cell
            
            
        } else if indexPath.row == 1 {
            
            let cellIdentifier = "TempTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TempTableViewCell else {
                    fatalError("The dequeued cell is not an instance of TempTableViewCell.")
            }
            cell.temperatureLabel.text = tempToMetricorImperial(unitTemp: weather!.daily![0].temp!.max!)
            cell.maxTemperatureLabel.text = tempToMetricorImperial(unitTemp: weather!.daily![0].temp!.max!)
            cell.minTemperatureLabel.text = tempToMetricorImperial(unitTemp: weather!.daily![0].temp!.min!)
            return cell
            
        } else if indexPath.row == 2 {
            let cellIdentifier = "HourlyTempTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HourlyTempTableViewCell else {
                    fatalError("The dequeued cell is not an instance of HourlyTempTableViewCell.")
            }
            //cell.hourlyTempCollectionView.
            cell.hourlyWeatherData = weather!.hourly!
            return cell
        }
        else if indexPath.row == 3 {
            let cellIdentifier = "DescriptionTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DescriptionTableViewCell else {
                    fatalError("The dequeued cell is not an instance of DescriptionTableViewCell.")
            }
            cell.descriptionLabel.text = "Currently \(weather!.current!.weather![0].description!). The high will be \(tempToMetricorImperial(unitTemp: weather!.daily![0].temp!.max!)). The low tonight will be \(tempToMetricorImperial(unitTemp: weather!.daily![0].temp!.min!))"
            return cell
        } else if 4 ... (3+weather!.daily!.count)  ~= indexPath.row {
            let cellIdentifier = "WeekdayTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeekdayTableViewCell else {
                    fatalError("The dequeued cell is not an instance of DescriptionTableViewCell.")
            }
            cell.weekDayLabel.text = getWeekDay(unixTime: weather!.daily![indexPath.row-4].dt!)
            cell.maxTempLabel.text = tempToMetricorImperial(unitTemp: weather!.daily![indexPath.row-4].temp!.max!)
            cell.minTempLabel.text = tempToMetricorImperial(unitTemp: weather!.daily![indexPath.row-4].temp!.min!)
            cell.iconImageView.image = weathericon(main: weather!.daily![indexPath.row-4].weather![0].main!)
            return cell
        }
        
        
        let cellIdentifier = "LocationTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationTableViewCell else {
                fatalError("The dequeued cell is not an instance of LocationTableViewCell.")
        }
        cell.locationLabel.text = "nil"
        cell.backgroundColor = backroundColor
        print("Nil cell returned")
        return cell

        
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
