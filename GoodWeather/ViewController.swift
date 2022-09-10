//
//  ViewController.swift
//  GoodWeather
//
//  Created by Ibrahim on 9/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextFeild: UITextField!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextFeildEvent()
    }
    
    fileprivate func cityTextFeildEvent() {
        cityNameTextFeild.rx.controlEvent(.editingDidEndOnExit)
            .map { self.cityNameTextFeild.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            tempretureLabel.text = "\(weather.temp) ℉"
            humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            tempretureLabel.text = "🫣"
            humidityLabel.text = "🚫"
        }
    }
    
    private func fetchWeather(by city : String) {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: encodedCity)
        else { return  }
        
        let resource = Resource<WeatherResult>.init(url: url)
        
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catchAndReturn(WeatherResult.empty)
        
        search.map { "\($0.main.temp)℉" }
            .bind(to: self.tempretureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) 💦" }
            .bind(to: self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
    }


}

