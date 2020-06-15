//
//  ViewController.swift
//  Weather
//
//  Created by Kevin Ciarniello on 2020-06-12.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

// tableview
// custom view: collection view
// API / request to get the data (Make file: OpenWeatherService)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var cities: [City]!

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = Constants.backgroundColor
        setupTableView()
        cities = TestData.getCities()
    }

    // MARK: - UI Elements
    
    func pushCity(city: City) {
        guard let vc =
            self.storyboard?.instantiateViewController(
                identifier: "weatherDetails", creator: { coder in
                    return WeatherDetailsViewController(coder: coder, city: city)
            }) else {
                fatalError("WeatherDetailsViewController not found")
        }

        vc.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - TableView Properties
    // Setup the table to the view and set the constrains to the entire view
    func setupTableView() {
        tableView.backgroundColor = Constants.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.alwaysBounceVertical = false

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCellTableViewCell", for: indexPath) as! CityCellTableViewCell
        let city = cities[indexPath.row]
        cell.mainTitleLabel?.text = city.name
        cell.subTitleLabel?.text = city.country
        cell.backgroundColor = Constants.backgroundColor
        cell.mainTitleLabel?.textColor = Constants.textColor
        cell.subTitleLabel?.textColor = Constants.textColor

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        pushCity(city: city)
    }
}
