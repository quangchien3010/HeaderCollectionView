//
//  DataServices.swift
//  Weathear
//
//  Created by Admin on 5/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

class DataServices {
    
    static let shared : DataServices =  DataServices()
    
    ////////////----///////////
    private var _weathers : [WeatherHour]?
    var weathers : [WeatherHour] {
        get {
            if _weathers == nil  {
                getDataAPI()
            }
            return _weathers ?? []
        }
    }
    
    var weather: Weather?
    
    func getDataAPI() {
        
        _weathers = []
        
        //Tao ra mot URL Request
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=Hanoi&APPID=26f5c851bec66e093e6dd6919008f381"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        //Xu li toan bo cac tac vu trong Global - CurrentQue
        DispatchQueue.global().async {
            //Tao ra mot task de lay du lieu = URL Session
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let aData = data else { return }
                // Decode tu Data sang Json. Em kieu tu json ve DICT
                do {
                    if let result = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? DICT {
                        guard let list = result["list"] as? [DICT] else { return }
                        for dict in list {
                            if let weather = WeatherHour(dict: dict) {
                                self._weathers?.append(weather)
                            }
                        }
                        //Dua vao mainQue update nen UI dung Notifi
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name.init("update"), object: nil)
                        }
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
        
    }
    
    func getDatAPIday() {
        
        let urlString = "https://api.apixu.com/v1/forecast.json?key=fe5d02d695944feca8292137181204&q=Hanoi&days=7&lang=vi"
        let url = URL(string : urlString)!
        let urlRequest = URLRequest(url: url)
        
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let aData = data else {return}
                do {
                    let result = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers)
                    guard let list = result as? DICT else {return}
                    self.weather = Weather(dict : list)
                    
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name.init("updateday"), object: nil)
                    }
                    
                }
                catch {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        }
        
    }
    
}
