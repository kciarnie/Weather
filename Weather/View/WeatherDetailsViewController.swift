//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Kevin on 2020-06-14.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    private var city: City
    
    private var darkSkyViewModel: DarkSkyViewModel?

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
        self.navigationController?.navigationBar.barTintColor = Constants.backgroundColor
        hideNavigationLine()
        scrollView.isHidden = true
        addRefreshButton()
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
    }
    
    @objc func refresh() {
        DispatchQueue.main.async {
            self.scrollView.isHidden = true
            self.showActivityIndicator()
        }
        fetchWeather()
    }

    // MARK: - Networking
    
    private func fetchWeather() {
        darkSkyViewModel?.fetchWeather(success: {
            self.updateDisplay()
        }, failure: { (error) in
            self.showError(error: error)
        })
    }
    
    // MARK: - Displaying
    
    func updateDisplay() {
        DispatchQueue.main.async {
            self.location.text = self.darkSkyViewModel?.location
            self.location.addCharactersSpacing(spacing: 8.0, txt: self.darkSkyViewModel?.location ?? "")
            self.summary.text = self.darkSkyViewModel?.summary
            self.temperature.text = self.darkSkyViewModel?.temperature
            self.lowTemp.text = self.darkSkyViewModel?.lowTemperature
            self.highTemp.text = self.darkSkyViewModel?.highTemperature
            self.iconString.text = self.darkSkyViewModel?.icon
            self.feelsLike.text = self.darkSkyViewModel?.feelsLike
            self.sunrise.text = self.darkSkyViewModel?.sunrise
            self.sunset.text = self.darkSkyViewModel?.sunset
            self.humidity.text = self.darkSkyViewModel?.humidity
            self.pressure.text = self.darkSkyViewModel?.pressure
            self.cloudiness.text = self.darkSkyViewModel?.cloudiness
            self.windspeed.text = self.darkSkyViewModel?.windSpeed

            self.spinner.stopAnimating()
            self.scrollView.isHidden = false
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
        scrollView.isHidden = true
        scrollView.refreshControl?.endRefreshing()
    }
}
