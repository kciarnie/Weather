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
    private lazy var weatherService = DarkSkyWeatherService(apiKey: DARKSKY_API_KEY)
    
    var spinner: UIActivityIndicatorView!

    @IBOutlet var location: UILabel!
    @IBOutlet var summary: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var iconString: UILabel!
    @IBOutlet var refreshButton: UIButton!
    
    
    init?(coder: NSCoder, city: City) {
        self.city = city
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
    
    private func setupUI() {
        self.navigationController?.navigationBar.barTintColor = Constants.backgroundColor
        hideNavigationLine()
        hideLabels(true)
        addRefreshButton()
    }
    
    private func addRefreshButton() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
    private func hideNavigationLine() {
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    private func hideLabels(_ isHidden: Bool) {
        let group = [location, summary, temperature, iconString]
        for field in group {
            field?.isHidden = isHidden
        }
    }
    
    private func fetchWeather() {
        weatherService.getCurrentWeather(city: city, success: { (weather, city) in
            let model = DarkSkyViewModel(model: weather, city: city)
            self.updateDisplay(model: model)
        }, failure: { (error) in
            self.showError(error: error)
        })

    }
    
    func updateDisplay(model: DarkSkyViewModel) {
        DispatchQueue.main.async {
            self.location.text = model.location
            self.location.addCharactersSpacing(spacing: 8.0, txt: model.currentLocation())
            self.summary.text = model.summary
            self.temperature.text = model.temperature
            self.iconString.text = model.icon
            self.hideLabels(false)
            self.spinner.stopAnimating()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        weatherService.cancel()
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    private func showActivityIndicator() {
        if (spinner == nil) {
            spinner = UIActivityIndicatorView(style: .large)
            spinner.color = Constants.textColor
            spinner.center = self.view.center
            self.view.addSubview(spinner)
        }
        spinner.startAnimating()
        spinner.isHidden = false
    }
    
    @objc func refresh() {
        showActivityIndicator()
        fetchWeather()
    }
}
