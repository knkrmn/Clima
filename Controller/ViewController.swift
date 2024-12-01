//
//  Created by Okan Karaman on 27.11.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: Properties

    
    let  mainScreen = MainScreen()
    lazy var backgroundImage = mainScreen.backgroundImage
    lazy var headerStackView = mainScreen.headerStackView
    lazy var symbol = mainScreen.symbolImage
    lazy var searchButton = mainScreen.searchButton
    lazy var searchText = mainScreen.locationTextField
    lazy var cityLabel = mainScreen.city
    lazy var temperature = mainScreen.temperatureNumber
    lazy var symbolImageView = mainScreen.symbolImageView
    lazy var locationButton = mainScreen.locationButton
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainScreen
        setupUI()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchText.delegate = self
        
        searchButton.addTarget(.none, action: #selector(searchButtonTapped), for: .touchUpInside)
        locationButton.addTarget(.none, action: #selector(locationButtonButtonTapped), for: .touchUpInside)
    }
    
    func setupUI(){
        setBackGroundImage()
    }
    
    func setBackGroundImage (){
        let backgroundImageView = UIImageView(frame:UIScreen.main.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    @objc func searchButtonTapped(){
        searchText.endEditing(true)
    }
    
  
}


//MARK: UITextFieldDelegate

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        return true
      }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchText.text {
            weatherManager.fetchWeather(cityName: city)
           // weatherManager.perfomRequest(urlString: url)
            searchText.text = ""
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
}

//MARK: WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    func didFailWithError(_ weatherManager: WeatherManager, error: any Error) {
        print("Bir hata oluştu")
        print(error.localizedDescription)
    }
    
    func didUpdateWeather(_ weatherManager : WeatherManager ,weather: WeatherModel) {
        
        let symbolImage : UIImage = {
            guard let image = UIImage(systemName: weather.conditionName,withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .medium)) else {
                fatalError("image bulunamadı")
            }
            image.withTintColor(.black)
            return image.withTintColor(.black, renderingMode: .alwaysOriginal)
        }()
        
        
        DispatchQueue.main.async {
            self.temperature.text = weather.temperatureString
            self.symbolImageView.image = symbolImage
            self.cityLabel.text = weather.cityName
        }
    }
}


//MARK: CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManager.fetchWeather(longitude : lon, latitude : lat)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Hata: \(error.localizedDescription)")
    }
    
    @objc func locationButtonButtonTapped(){
        print("locationButtonButtonTapped")
        locationManager.requestLocation()
    
    }
    
}







