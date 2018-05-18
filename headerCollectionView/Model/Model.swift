//
//  Model.swift
//  headerCollectionView
//
//  Created by Admin on 5/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

typealias  DICT = Dictionary<AnyHashable, Any>



class WeatherHour {
    var time : TimeInterval
    var temp : Double
    var main : String
    
    init?(dict : DICT) {
        guard let time = dict["dt"] as? TimeInterval else { return nil }
        guard let Dmain = dict["main"] as? DICT else  { return nil }
        guard let temp = Dmain["temp"] as? Double else { return nil }
        guard let weather = dict["weather"] as? [DICT] else { return nil }
        guard let main = weather[0]["main"] as? String else {return nil}
        
        self.time = time
        self.temp = temp
        self.main = main
        
    }
}
class Weather {
    var name : String   //location
    var temp_c : Double //Current
    var text : String   //Current // Condition
    var forecastdays : [Forecastday] = []
    
    
    init?(dict : DICT) {
        
        guard let location = dict["location"] as? DICT else {return nil}
        guard let name = location["name"] as? String else {return nil}
        
        guard let current = dict["current"] as? DICT else {return nil}
        guard let temp_c = current["temp_c"] as? Double else {return nil}
        guard let condition = current["condition"] as? DICT else { return nil }
        guard let text = condition["text"] as? String else {return nil}
        
        
        guard let forecast = dict["forecast"] as? DICT  else { return nil }
        guard let forecastday = forecast["forecastday"] as? [DICT] else { return nil }
        
        for _forecastday in forecastday {
            if let days = Forecastday(dict : _forecastday) {
                self.forecastdays.append(days)
            }
        }
        
        self.name = name
        self.temp_c = temp_c
        self.text = text
        
    }
}



