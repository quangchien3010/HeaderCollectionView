//
//  File.swift
//  headerCollectionView
//
//  Created by Admin on 5/17/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class Forecastday {
    var date_epoch : TimeInterval
    var maxtemp_c : Double
    var mintemp_c : Double
    var icon : String
    
    init?(dict : DICT ) {
        
        guard let date_epoch = dict["date_epoch"] as? TimeInterval else {return nil}
        
        guard let day = dict["day"] as? DICT else { return nil}
        guard let maxtemp_c = day["maxtemp_c"] as? Double else { return nil }
        guard let mintemp_c = day["mintemp_c"] as? Double else { return nil }
        
        guard let condition = day["condition"] as? DICT else { return nil }
        guard let icon = condition["icon"] as? String else { return nil }
        
        self.date_epoch = date_epoch
        self.maxtemp_c = maxtemp_c
        self.mintemp_c = mintemp_c
        self.icon = "http:"+icon
        
    }
}
