//
//  weathertether.swift
//  WeatherTether
//
//  Created by Amogh Kalyan on 7/23/20.
//
import Foundation
import UIKit

class weatherdata{
    
    //all private variables used for calls
    //set to null values. Will be changed depending on input and calls.
    private var temperature:Double = 0
    private var weather:String = ""
    private var humidity:Int = 0
    private var description:String = ""
    private var temp_max:Double = 0
    private var temp_min:Double = 0
    private var wind_speed:Double = 0
    private var wind_degree:Int = 0
    
    //temp variables
    private var temp_f:Double = 0
    private var temp_c:Double = 0
    //mins
    private var temp_f_min:Double = 0
    private var temp_c_min:Double = 0
    //maxes
    private var temp_f_max:Double = 0
    private var temp_c_max:Double = 0
    
    private var cityname:String = "New%20York"

    
    //placeholder string used for cutting and displaying
    private var obtaineddata:String = ""
    
    //Function getWeather() uses API link and finds information on weather
    func getWeather(completion: @escaping (Bool) -> Void)
    {
        // Use URLSession class (embedded in appcode) to create a SharedSession for data requests
        let session = URLSession.shared
    
        //contructing the URL used for the API info
        let weatherRequestURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityname)&appid=1db97979a606cf6f88ee7ef04d4c7996")!
    
        //The data task retrieves and requests data from the API URL
        //We use the dataTask(with: ...) function to get the data from the URL
        // *******[self] is used for something...
        let dataTask = session.dataTask(with: weatherRequestURL)
        { [self]
          (data: Data?, response: URLResponse?, error: Error?) in
            
            //From dataTask(with ...) we have cases
            //Case "error" will allow us to see if there is an error with retrieving/receiving data
            if let error = error
            {
                print("Error:\n\(error)")
            }
            
            else
            {
                //converts and prints the raw data into string format using String.Encoding.uft8
                let dataString = String(data: data!, encoding: String.Encoding.utf8)
                //self.obtaineddata = dataString! as String
                obtaineddata = dataString!
                if obtaineddata == "{\"cod\":\"404\",\"message\":\"city not found\"}"
                        {
                            cityname = "Error! Please reinput!"
                            temp_f = 0
                            temp_c = 0
                        }
                
                if let range = obtaineddata.range(of: ",\"feels_like")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "temp\":")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        temperature = (String(substringthing) as NSString).doubleValue
                    }
                }
                
                if let range = obtaineddata.range(of: "\",\"description\"")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "main\":\"")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        weather = String(substringthing)
                    }
                }
                
                if let range = obtaineddata.range(of: "\",\"icon\"")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "description\":\"")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        description = String(substringthing)
                    }
                }
                
                if let range = obtaineddata.range(of: "},\"visibility")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "humidity\":")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        let aaaaa = String(substringthing)
                        humidity = (aaaaa as NSString).integerValue
                    }
                }
                
                if let range = obtaineddata.range(of: ",\"pressure")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "temp_max\":")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        temp_max = (String(substringthing) as NSString).doubleValue
                    }
                }
                
                if let range = obtaineddata.range(of: ",\"temp_max")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "temp_min\":")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        temp_min = (String(substringthing) as NSString).doubleValue
                    }
                }
                
                if let range = obtaineddata.range(of: ",\"deg")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "speed\":")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        wind_speed = (String(substringthing) as NSString).doubleValue
                    }
                }
                
                if let range = obtaineddata.range(of: "},\"clouds")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "deg\":")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        let aaaaa = String(substringthing)
                        wind_degree = (aaaaa as NSString).integerValue
                    }
                }
                
                if let range = obtaineddata.range(of: "\",\"cod")
                {
                    let firstPart = obtaineddata[(obtaineddata.startIndex)..<range.lowerBound]
                    if let range = firstPart.range(of: "name\":\"")
                    {
                        let substringthing = firstPart[range.upperBound...]
                        cityname = (String(substringthing))
                    }
                }
                
                //print("Human-readable data:\n\(dataString!)")
                completion(true)
            }
        }
        
        //The data task is only defined from this point
        //We activate the dataTask using .resume()
        dataTask.resume()
    }
    
    //all temp return functions
    func returntemp() -> Double {
        return temperature
    }
    func returntemp_f_max() -> Double {
        return temp_f_max
    }
    func returntemp_f_min() -> Double {
        return temp_f_min
    }
    func returntemp_c_max() -> Double {
        return temp_c_max
    }
    func returntemp_c_min() -> Double{
        return temp_c_min
    }
    
    //return functions
    func returnweather() -> String {
         return weather
    }
    func returndescription() -> String {
        return description
    }
    func returnhumidity() -> Int {
        return humidity
    }
    func returnwind_speed() -> Double{
        return wind_speed
    }
    func returnwind_degree() -> Int{
        return wind_degree
    }
    
    
    func returncityname() -> String{
        return cityname
    }
    func returnFahrenheit() -> Int{
        return Int(temp_f)
    }
    func returnCelsius() -> Int{
        return Int(temp_c)
    }
    
    
    func replaceCityNameWithInput(_ cityInput:String) -> Void{
        cityname = cityInput.replacingOccurrences(of: " ", with: "%20")
    }
    func autoconvert() -> Void
        {
            switch temperature
            {
            case 0:
                temp_c = 0
                temp_f = 0
                temp_max = 0
                temp_min = 0
                temp_f_min = 0
                temp_c_min = 0
                temp_f_max = 0
                temp_c_max = 0
                
            default:
                var returndata:Double = temperature             //declares returndata and sets to tempurature (currently set to 0)
                returndata = returndata - 273                   //returndata is now equal to -273
                    temp_c = returndata
                    temp_f = 9/5 * returndata + 32
                returndata = temp_min
                returndata = returndata - 273                   //returndata is now equal to -273
                    temp_c_min = returndata
                    temp_f_min = 9/5 * returndata + 32
                returndata = temp_max                  //returndata is now equal to -273
                returndata = returndata - 273
                    temp_c_max = returndata
                    temp_f_max = 9/5 * returndata + 32
        }
    }
}

//global variables
var switcher:String = "Fahrenheit"
let weather:weatherdata = weatherdata()
