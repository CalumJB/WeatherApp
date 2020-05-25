//
//  HourlyTempTableViewCell.swift
//  WeatherApp
//
//  Created by calum boustead on 22/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class HourlyTempTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var hourlyTempCollectionView: UICollectionView!
    //let hourlyWeatherData = [HourlyWeatherInfo.self]
    var hourlyWeatherData = [HourlyWeatherInfo]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        hourlyTempCollectionView.delegate = self
        hourlyTempCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "HourTempCollectionViewCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? HourTempCollectionViewCell else {
                fatalError("The dequeued cell is not an instance of HourTempCollectionViewCell.")
        }
        
        cell.hourLabel.text = getHour(unixTime: hourlyWeatherData[indexPath.row].dt!)
        cell.tempLabel.text = tempToMetricorImperial(unitTemp: hourlyWeatherData[indexPath.row].temp!)
        cell.iconImageView.image = weathericon(main: hourlyWeatherData[indexPath.row].weather![0].main!)
        
        return cell
        
    }
    
    //MARK: Private methods
    
    func getIcon(weatherMain: String) -> UIImage {
        switch weatherMain {
            case "Thunderstorm":
                return UIImage(named: "thunderstorm")!
            case "Drizzle":
                return UIImage(named: "shower_rain")!
            case "Rain":
                return UIImage(named: "shower_rain")!
            case "Snow":
                return UIImage(named: "snow")!
            case "Clear":
                return UIImage(named: "clear_color")!
            case "Clouds":
                return UIImage(named: "scattered_clouds")!
            default:
                return UIImage(named: "mist")!
        }
    }
}
    
   
