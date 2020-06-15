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

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var iconString: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var cloudiness: UILabel!
    @IBOutlet weak var windspeed: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
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
        tableView.register(ForecastTableViewCell.nib(), forCellReuseIdentifier: ForecastTableViewCell.identifier)

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
        scrollView.isHidden = true
        setupTableView()
        addRefreshButton()
    }
    
    private func setupTableView() {
        tableView.register(ForecastTableViewCell.nib(), forCellReuseIdentifier: ForecastTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = Constants.backgroundColor
        tableView.isHidden = true
        tableView.allowsSelection = false
    
    }
    
    private func addRefreshButton() {
       // Add the refresh control to your UIScrollView object.
       scrollView.refreshControl = UIRefreshControl()
       scrollView.refreshControl?.addTarget(self, action:
                                          #selector(refresh),
                                          for: .valueChanged)
    }
    
    private func hideNavigationLine() {
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.backgroundColor = Constants.backgroundColor
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.scrollView.isHidden = true
            self.showActivityIndicator()
            self.tableView.isHidden = true
        }
        fetchWeather()
    }

    // MARK: - Table Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
        cell.configure(with: models[indexPath.row], city: self.city)
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
            self.location.text = model?.location
            self.location.addCharactersSpacing(spacing: 8.0, txt: model?.location ?? "")
            self.summary.text = model?.summary
            self.temperature.text = model?.temperature
            self.lowTemp.text = model?.lowTemperature
            self.highTemp.text = model?.highTemperature
            self.iconString.text = model?.icon
            self.feelsLike.text = model?.feelsLike
            self.sunrise.text = model?.sunrise
            self.sunset.text = model?.sunset
            self.humidity.text = model?.humidity
            self.pressure.text = model?.pressure
            self.cloudiness.text = model?.cloudiness
            self.windspeed.text = model?.windSpeed

            self.spinner.stopAnimating()
            self.scrollView.isHidden = false
            self.tableView.isHidden = false
            guard let models = model?.daily else {
                return
            }
            self.models = models
            self.tableView.reloadData()
        }
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
        scrollView.isHidden = false
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
        scrollView.isHidden = true
        scrollView.refreshControl?.endRefreshing()
    }
}
