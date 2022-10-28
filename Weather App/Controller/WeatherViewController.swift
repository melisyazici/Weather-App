//
//  ViewController.swift
//  Weather App
//
//  Created by Melis Yazıcı on 09.05.22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperaturLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //ask the user for permission for the location
        locationManager.requestWhenInUseAuthorization()
        // "locationManager.delegate = self" is must be top of the "locationManager.requestLocation()" otherwise the app will crash
        locationManager.delegate = self
        //request one time
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }
    //location button pressed
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dismiss the keyboard when the user click on the view (outside the UITextField
        self.view.endEditing(true)
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        // Dismiss the keyboard when clicking the button
        searchTextField.endEditing(true)
        //searchTextField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when clicking the return key (or "go" whatever you setted) on keyboard
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // If user typed something in the text field than dismiss the keyboard
        if textField.text != ""{
            return true
            // If user didn't typed in the text field than dont dismiss the keyboard and remind the user that they should "Enter a city name"
        } else {
            textField.placeholder = "Enter a city name"
            return false
            // return false so we're not going to let the textFieldDidEndEditing
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextField.text to get the weather for that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        // Empty String = Clears the textfield when the user stopped editing
        searchTextField.text = ""
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperaturLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditinName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

