//
//  ViewController.swift
//  TimerApp
//
//  Created by Aman Khoja on 6/20/19.
//  Copyright © 2019 Aman Khoja. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    //@IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var StartButton: UIButton!
    var seconds = 60
    var timer = Timer()
    var timerRunning = false
    var optionPick = [String]()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Pickerview method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return optionPick.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return optionPick[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.timerLabel.text = optionPick[row]
        
        if optionPick[row].elementsEqual("1 Minute")
        {
            seconds = 60
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        else if optionPick[row].elementsEqual("2 Minute")
        {
            seconds = 60 * 2
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        else if optionPick[row].elementsEqual("5 Minute")
        {
            seconds = 60 * 5
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        else if optionPick[row].elementsEqual("10 Minute")
        {
            seconds = 60 * 10
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        else if optionPick[row].elementsEqual("30 Minute")
        {
            seconds = 60 * 30
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        else if optionPick[row].elementsEqual("1 hour")
        {
            seconds = 60 * 60
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        else{
            timerLabel.text = "Incorrect Option"
        }
    }
    
  /*  func numberOfComponents(in picker: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 10
        } else {
            return 100
        }
    }
    
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "First \(row)"
        } else {
            return "Second \(row)"
        }
    }*/
    
    
    
    @IBAction func Start(_ sender: Any) {
        //if no timer running, run timer
        if timerRunning == false {
          //  self.StartButton.setTitle("Stop", for: .normal)
            runTimer()
            self.StartButton.isEnabled = false
            timerRunning = true
            stopButton.isEnabled = true
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        timerRunning = false
        timer.invalidate()
        StartButton.isEnabled = true
        stopButton.isEnabled = false

    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        timerRunning = true
    }
    
    @objc func updateTimer(){
        if seconds < 1 {
            timer.invalidate()
            timerRunning = false
        }
        else {
        seconds -= 1
        timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String{
        let hours = Int(time) / 3600
        let mins = Int(time) / 60%60
        let sec = Int(time) % 60
        return String(format: "%02i:%02i:%02i ", hours, mins, sec)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         optionPick = ["1 Minute" , "2 Minute", "5 Minute", "10 Minute", "30 Minute","1 hour"]
        stopButton.isEnabled = false
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
}

