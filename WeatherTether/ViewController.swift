//
//  ViewController.swift
//  WeatherTether
//
//  Created by Amogh Kalyan on 7/17/20.
//

import UIKit
import Foundation
 
class ViewController: UIViewController, UITextFieldDelegate {

    //labels!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    
    //Temp Min StackView
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var DisplayLow: UILabel!
    
    //Temp Max StackView
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var DisplayHigh: UILabel!
    
    //City Input Text Field
    @IBOutlet weak var cityNameInput: UITextField!
    
    //viewDidLoad / HandlerBlock
    override func viewDidLoad() {
    super.viewDidLoad()
        
        //for textfield input
        self.cityNameInput.delegate = self
        
        //*********DEFAULT HANDLER BLOCK*************//
        
        let handlerBlock: (Bool) -> Void =
        {
            if $0
            {
                DispatchQueue.main.async(execute:{
                    
                    weather.autoconvert()
                    
                    self.tempLabel.text = (String(Int(weather.returnFahrenheit()))) + " °F"
                    
                    self.tempMinLabel.text = (String(Int(weather.returntemp_f_min()))) + " °F"
                    self.tempMaxLabel.text = (String(Int(weather.returntemp_f_max()))) + " °F"
                    self.descriptLabel.text = (String(weather.returndescription()))
                    self.cityLabel.text = (String(weather.returncityname()))
                    self.weatherLabel.text = (String(weather.returnweather()))
                })
            }
        }
        weather.getWeather(completion: handlerBlock)
    }
    
    
    
    //********functions after ViewDidLoad***********
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //for button
    private func configureTapGesture()
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap()
    {
        view.endEditing(true)
    }
    
    
    @IBOutlet weak var degreeSwitch: UISwitch!
    
    @IBAction func degreeSwitchAction(_ sender: Any)
    {
        if(weather.returncityname() == "Error! Please reinput!")
        {
            self.tempLabel.text = ""
            self.tempMinLabel.text = ""
            self.tempMaxLabel.text = ""
            self.weatherLabel.text = ""
            self.DisplayLow.text = ""
            self.DisplayHigh.text = ""
            self.descriptLabel.text = ""
            self.cityLabel.text = (String(weather.returncityname()))
        }
        
        else if(degreeSwitch.isOn == true)
        {
            switcher = "Celsius"
            self.tempLabel.text = (String(Int(weather.returnCelsius()))) + " °C"
            self.tempMinLabel.text = (String(Int(weather.returntemp_c_min()))) + " °C"
            self.tempMaxLabel.text = (String(Int(weather.returntemp_c_max()))) + " °C"
            self.DisplayHigh.text = "High:"
            self.DisplayLow.text = "Low:"
            self.cityLabel.text = (String(weather.returncityname()))
        }
        
        else if (degreeSwitch.isOn == false){
            switcher = "Fahrenheit"
            self.tempLabel.text = (String(Int(weather.returnFahrenheit()))) + " °F"
            self.tempMinLabel.text = (String(Int(weather.returntemp_f_min()))) + " °F"
            self.tempMaxLabel.text = (String(Int(weather.returntemp_f_max()))) + " °F"
            self.DisplayHigh.text = "High:"
            self.DisplayLow.text = "Low:"
            self.cityLabel.text = (String(weather.returncityname()))
        }
    }
    
    //allows user to click return and enter city
    @IBAction func primaryActionTriggercityInputName(_ sender: Any) {
        
        cityNameInput.resignFirstResponder()  //if desired
        giveWeatherButton((Any).self)
    }
    
    //Get the Weather! button
    @IBAction func giveWeatherButton(_ sender: Any)
    {
        weather.replaceCityNameWithInput(String(cityNameInput.text!))
        
        let handlerBlock: (Bool) -> Void =
        {
            if $0
            {
                DispatchQueue.main.async(execute:{
                    
                    weather.autoconvert()
                    
                    if(weather.returncityname() == "Error! Please reinput!")
                    {
                        self.tempLabel.text = ""
                        self.tempMinLabel.text = ""
                        self.tempMaxLabel.text = ""
                        self.weatherLabel.text = (String(""))
                        self.DisplayLow.text = ""
                        self.DisplayHigh.text = ""
                        self.descriptLabel.text = ""
                        self.cityLabel.text = (String(weather.returncityname()))
                    }
                    
                    if(switcher == "Fahrenheit" && weather.returncityname() != "Error! Please reinput!")
                    {
                        self.tempLabel.text = (String(Int(weather.returnFahrenheit()))) + " °F"
                        self.tempMinLabel.text = (String(Int(weather.returntemp_f_min()))) + " °F"
                        self.tempMaxLabel.text = (String(Int(weather.returntemp_f_max()))) + " °F"
                        self.cityLabel.text = (String(weather.returncityname()))
                        self.weatherLabel.text = (String(weather.returnweather()))
                        self.descriptLabel.text = (String(weather.returndescription()))
                        self.DisplayHigh.text = "High:"
                        self.DisplayLow.text = "Low:"
                    }
                    
                    if(switcher == "Celsius" && weather.returncityname() != "Error! Please reinput!")
                    {
                        self.tempLabel.text = (String(Int(weather.returnCelsius()))) + " °C"
                        self.tempMinLabel.text = (String(Int(weather.returntemp_c_min()))) + " °C"
                        self.tempMaxLabel.text = (String(Int(weather.returntemp_c_max()))) + " °C"
                        self.cityLabel.text = (String(weather.returncityname()))
                        self.weatherLabel.text = (String(weather.returnweather()))
                        self.descriptLabel.text = (String(weather.returndescription()))
                        self.DisplayHigh.text = "High:"
                        self.DisplayLow.text = "Low:"
                    }
                })
            }
        }
        weather.getWeather(completion: handlerBlock)
        view.endEditing(true)
    }
}


//touch return sends keyboard away
func textFieldShouldReturn(_ textField: UITextField) -> Bool
{
    textField.resignFirstResponder()
    return true
}
