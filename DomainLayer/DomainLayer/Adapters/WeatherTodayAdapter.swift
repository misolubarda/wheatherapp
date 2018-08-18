//
//  TodaysWeatherAdapter.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 7/31/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import Foundation

class WeatherTodayAdapter {
    static func getWeatherToday(from currentWeather: CurrentWeather, currentUvIndex: CurrentUvIndex) -> WeatherToday {
        return WeatherToday(temperature: currentWeather.temperature, uvIndex: currentUvIndex.value, humidity: currentWeather.humidity , minTemp: currentWeather.minTemp , maxTemp: currentWeather.maxTemp)
    }
}
