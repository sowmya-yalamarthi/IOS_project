//
//  SelectDateViewController.swift
//  BabyTrackingSystem
//
//  Created by Giridhar Addagalla on 17/11/2021.
//

import UIKit

protocol selectDatesDelegate {
    
    func didSelectDate(date: Date, field: String)
    
}

class SelectDateViewController: UIViewController {
    
    var delegate: selectDatesDelegate?
    @IBOutlet var dtPicker: UIDatePicker!
    
    
    var minDate = Date()
    
    var selectedDate = Date()
    var field = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dtPicker.overrideUserInterfaceStyle = .light
        dtPicker.setDate(selectedDate, animated: false)
        
        if field == "start" {
            
            dtPicker.maximumDate = minDate
        }
        
        if field == "end" {
            
            dtPicker.minimumDate = minDate
        }
        
    }
    
    
    @IBAction func okBtnClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        delegate?.didSelectDate(date: selectedDate, field: field)
        
    }
    
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func pickerValueChanged(_ sender: Any) {
        
        selectedDate = dtPicker.date
        
    }
}


extension UIDatePicker {

     var textColor: UIColor? {
         set {
              setValue(newValue, forKeyPath: "textColor")
             }
         get {
              return value(forKeyPath: "textColor") as? UIColor
             }
     }

     var highlightsToday : Bool? {
         set {
              setValue(newValue, forKeyPath: "highlightsToday")
             }
         get {
              return value(forKey: "highlightsToday") as? Bool
             }
     }
 }
