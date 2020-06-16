//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var city: City
    private var darkSkyViewModel: DarkSkyViewModel?
    private var models = [DailyDataPoint]()
    
    var spinner: UIActivityIndicatorView!

    @IBOutlet weak var tableView: UITableView!
    
    var timezone: TimeZone?
    
    // MARK: - LifeCycle Elements
    
    init?(coder: NSCoder, city: City) {
        self.city = city
        self.darkSkyViewModel = DarkSkyViewModel(city: city)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        refresh()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.darkSkyViewModel?.cancel()
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    // MARK: - UI Elements
    
    private func setupUI() {
        hideNavigationLine()
        setupTableView()
        addRefreshAction(true)
    }
    
    private func setupTableView() {
        tableView.register(ForecastTableViewCell.nib(), forCellReuseIdentifier: ForecastTableViewCell.identifier)
        tableView.register(HeaderTableViewCell.nib(), forCellReuseIdentifier: HeaderTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = Constants.backgroundColor
        tableView.isHidden = true
        tableView.allowsSelection = false
    }
    
    // Use this method in order to quickly turn on/off the refresh to pull-down feature
    private func addRefreshAction(_ toggle: Bool) {
        if toggle {
            // Add the refresh control to your UIScrollView object.
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action:
                                               #selector(refresh),
                                               for: .valueChanged)
            tableView.refreshControl?.tintColor = UIColor.white
        }
    }
    
    // Hides the navigation line for a seemless UI experience
    private func hideNavigationLine() {
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.backgroundColor = Constants.backgroundColor
    }
    
    @objc func refresh() {
        fetchWeather()
        DispatchQueue.main.async {
            self.showActivityIndicator()
            self.tableView.isHidden = true
        }
    }

    // MARK: - Table Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ForecastTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
        cell.configure(with: models[indexPath.row], city: self.city, timezone: self.timezone!)
        return cell
    }
    
    // MARK: - Networking
    
    private func fetchWeather() {
        darkSkyViewModel?.fetchWeather(success: {
            self.configure(with: self.darkSkyViewModel)
        }, failure: { (error) in
            self.showError(error: error)
        })
    }
    
    // MARK: - Displaying
    
    func configure(with model: DarkSkyViewModel?) {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.tableView.isHidden = false
            guard var models = model?.daily else {
                return
            }
            
            // Remove the first one
            models.removeFirst()
            
            self.models = models
            self.timezone = model?.timezone
            self.configureHeaderView(model)
            self.tableView.reloadData()
        }
    }
    
    func configureHeaderView(_ model: DarkSkyViewModel?) {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.configure(with: model, city: self.city)
        self.tableView.tableHeaderView = cell
    }

    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func hideActivityIndicator() {
        spinner?.stopAnimating()
        tableView.isHidden = false
    }
    
    private func showActivityIndicator() {
        if (spinner == nil) {
            spinner = UIActivityIndicatorView(style: .large)
            spinner.color = Constants.textColor
            spinner.center = self.view.center
            spinner.hidesWhenStopped = true
            self.view.addSubview(spinner)
        }
        spinner.startAnimating()
        spinner.isHidden = false
        tableView.isHidden = true
        tableView.refreshControl?.endRefreshing()
    }
}
