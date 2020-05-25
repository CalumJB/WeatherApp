//
//  PageViewController.swift
//  WeatherApp
//
//  Created by calum boustead on 20/04/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

// Just a note for myself here
// Previously the page view controller had some stange scrolling behaviour
// the reason for this was that i was keeping track of the index in the page
// view controller and incrementing/decrementing when the before and after funcs
// were called. This wouldnt work because these function arent just called when
// you go back/forward to a view, they execute whenever the pagecontroller needs
// a new left or right page. this means that my counter was going up and down
// without me scrolling, it immediatly lost track of the page and thus loaded
// incorrect pages
// The solution was to give tell page/view contoller its own index and before
// loading the before/after pages, check what is the current index of the page
// this means the views that are loaded for before and after the current page
// are always correct.

import UIKit

class PageViewController: UIPageViewController ,UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var vcArray = [String]()
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self

        
        
        //Create initial view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialVc = storyboard.instantiateViewController(withIdentifier: "WeatherTableViewController") as! WeatherTableViewController
        

        initialVc.weather = WeatherData.weatherData.weather[0]
        

 
        
        //Set initial view controller
        self.setViewControllers([initialVc], direction: .forward, animated: false, completion: nil)
        
    }
    

/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: DataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = pageViewController.viewControllers!.first! as! WeatherTableViewController
        guard let index = vc.weather?.index else { return nil }
        
        if index == 0 {
            return nil
        } else {
            //print("Before")
            //index -= 1
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let prevVc = storyboard.instantiateViewController(withIdentifier: "WeatherTableViewController") as! WeatherTableViewController
            //prevVc.index = index
            //prevVc.weather?.index? = index
            prevVc.weather = WeatherData.weatherData.weather[index-1]
            
            return prevVc
            
            
        }
   
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //Check that there is another vc in the list
        let vc = pageViewController.viewControllers!.first! as! WeatherTableViewController
        //var index = vc.index
        guard let index = vc.weather?.index else { return nil }
        //var index = vc.weather!.index!
        if index < WeatherData.weatherData.weather.count-1 {
            // present the vc to the right
            //print("After")
            //index += 1
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVc = storyboard.instantiateViewController(withIdentifier: "WeatherTableViewController") as! WeatherTableViewController
            //nextVc.index = index
            //nextVc.weather?.index? = index
            nextVc.weather = WeatherData.weatherData.weather[index+1]
            return nextVc
            
        } else {
            return nil
        }
    }
    
    //MARK: Delegate
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        print("Finished Animating, index: " + String(currentIndex) + " value " + WeatherData.weatherData.weather[currentIndex])
//
//    }
}
