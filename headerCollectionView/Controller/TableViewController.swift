//
//  TableViewController.swift
//  headerCollectionView
//
//  Created by Admin on 5/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var weatherDays: [Forecastday] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        collectionView.layoutCollection(numberOfItem: 5, padding: 10)
        NotificationCenter.default.addObserver(self, selector: #selector(handler), name: Notification.Name.init("update"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlerr), name: Notification.Name.init("updateday"), object: nil)
        DataServices.shared.getDataAPI()
        DataServices.shared.getDatAPIday()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @objc func handler(){
        collectionView.reloadData()
        //  print(DataServices.shared.weathers)
        
    }
    
    @objc func handlerr() {
        
        guard let weather = DataServices.shared.weather else { return }
        
        print(weather.name, weather.text)
        
        weatherDays = weather.forecastdays
        print(weatherDays.count)
        tableView.reloadData()
        //  print(DataServices.shared.weathers)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherDays.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return collectionView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as!  TableViewCell
        
        let weatherday = weatherDays[indexPath.row]
        
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: weatherday.date_epoch)
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "vi-VN")
        
        cell.lb_thu.text = String(describing: dateFormatter.string(from: date))
        cell.imgIcon.download(from: weatherday.icon)
        cell.lb_nhietdo.text = String(weatherday.maxtemp_c)
        return cell
    }
    
}



extension TableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataServices.shared.weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell" , for: indexPath) as! CollectionViewCell
        let weather = DataServices.shared.weathers[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let date = Date(timeIntervalSince1970: weather.time)
        dateFormatter.locale = Locale(identifier: "vi-VN")
        print(dateFormatter.string(from: date))
        
        cell.lb_dt_txt.text = String(describing: dateFormatter.string(from: date))
        cell.lb_temp.text = String(Int(weather.temp - 273))
        cell.lb_descreption.text = weather.main
        
        return cell
    }
    
    
    
}
