//
//  GlobalMethods.swift
//  BabyTrackingSystem
//
//  Created by Giridhar Addagalla on 29/07/2020.
//  Copyright © 2020 Giridhar Addagalla. All rights reserved.
//

import UIKit

var weeklyDetails = NSArray()

protocol fetchDataFirebase {
    
    func didFetchData() -> Void
    
}

class GlobalMethods: NSObject {
    
    public static var delegate: fetchDataFirebase?
    
    public static func getWeeklyDetails(){
        
        DatabaseServices.shared.Refference.child("WeeklyDetails").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let id = snapshot.value as? NSArray {
                print("The value from the database: \(id)")
            
                if id.count > 0 {
                    
                    weeklyDetails = id
                    
                }else{
                    
                    weeklyDetails = NSArray()
                    
                }
                
                delegate?.didFetchData()
            }else{
                
                weeklyDetails = NSArray()
                delegate?.didFetchData()
            }
        })
        
    }
   
    public static func CreateCardView(radius: CGFloat, view: UIView){
        
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 2;
        view.layer.masksToBounds = false
        view.layer.cornerRadius = radius
        
    }
    
    public static func convertDateToString(date: Date, format: String) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        let myStringafd = formatter.string(from: yourDate!)

        return myStringafd
                
        
    }
    
    
    public static func daysBetween(start: Date, end: Date) -> Int {
       return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    public static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
