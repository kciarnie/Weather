//
//  ViewController.swift
//  Weather
//
//  Created by Kevin Ciarniello on 2020-06-12.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

/**
 This is the main View Controller when the app launches and shows the list of cities
 */
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
    
    func pushCity(_ city: City) {
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
        cell.configure(cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CityCellTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushCity(cities[indexPath.row])
    }
}
