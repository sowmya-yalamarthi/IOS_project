//
//  AddDetailsViewController.swift
//  BabyTrackingSystem
//
//  Created by Giridhar Addagalla on 17/11/2021.
//

import UIKit
import FittedSheets
import Toast


class AddDetailsViewController: UIViewController {

    @IBOutlet var startDateBtn: UIButton!
    @IBOutlet var endDateBtn: UIButton!
    
    var startDate = Date()
    var endDate = Date()
    
    var isStartSelected = false
    var isEndDateSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Add Details"
        self.navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.isHidden = false

        setDesing()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if GlobalMethods.isKeyPresentInUserDefaults(key: "start") {
            
            startDate = UserDefaults.standard.value(forKey: "start") as? Date ?? Date()
            endDate = UserDefaults.standard.value(forKey: "end") as? Date ?? Date()
            
            var date_Str = GlobalMethods.convertDateToString(date: startDate, format: "MMM, dd yyyy")
            isStartSelected = true
            startDateBtn.setTitle(date_Str, for: .normal)
            
            date_Str = GlobalMethods.convertDateToString(date: endDate, format: "MMM, dd yyyy")
            isEndDateSelected = true
            endDateBtn.setTitle(date_Str, for: .normal)
        }
        
        
    }
    
    func setDesing() -> Void {
        
        startDateBtn.layer.cornerRadius = 5
        endDateBtn.layer.cornerRadius = 5
        
    }
    
    func showDatePopUp(field: String, minDate: Date) -> Void {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectDateViewController") as! SelectDateViewController
        
        vc.delegate = self
        vc.field = field
        vc.minDate = minDate
        
        if field == "start" {
            vc.selectedDate = startDate
        }else{
            vc.selectedDate = endDate
        }
        
        let sheetController = SheetViewController(
            controller: vc,
            sizes: [.fixed(CGFloat(410))])
        
        sheetController.autoAdjustToKeyboard = false
        sheetController.cornerRadius = 24
        
        sheetController.dismissOnOverlayTap = true
        sheetController.dismissOnPull = true
        sheetController.contentBackgroundColor = .clear
        sheetController.overlayColor = UIColor.black.withAlphaComponent(0.6)
        
        self.present(sheetController, animated: false, completion: nil)
        
    }
    
    
    @IBAction func startBtnClidked(_ sender: Any) {
        
        self.showDatePopUp(field: "start", minDate: Date())
    }
    
    @IBAction func endBtnClicked(_ sender: Any) {
        
        self.showDatePopUp(field: "end", minDate: startDate)
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        if !isStartSelected {
            
            self.view.makeToast("Please select start date")
            
        }else if !isEndDateSelected {
            
            self.view.makeToast("Please select end date")
            
        }else{
            
            let theFirstDate = startDate
            let theSecondDate = Date()
            let theComponents = Calendar.current.dateComponents([.weekOfYear], from: theFirstDate, to: theSecondDate)
            let theNumberOfWeeks = theComponents.weekOfYear ?? 0
            
            let index = theNumberOfWeeks + 1
            let str = index < 10 ? (String(format: "0%d", index)) : (String(format: "%d", index))
            
            if index > 40 {
                
                self.view.makeToast("Congratulations you have given a birth to the baby.")
                
            }else{
                
                UserDefaults.standard.setValue(startDate, forKey: "start")
                UserDefaults.standard.setValue(endDate, forKey: "end")
                UserDefaults.standard.synchronize()
                
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "WeekDetailsViewController") as! WeekDetailsViewController
                VC.week = str
                self.navigationController!.pushViewController(VC, animated: true)
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                
            }
        }
    }
}


extension AddDetailsViewController: selectDatesDelegate {
    
    func didSelectDate(date: Date, field: String) {
        
        let date_Str = GlobalMethods.convertDateToString(date: date, format: "MMM, dd yyyy")
        if field == "start" {
            
            startDate = date
            isStartSelected = true
            startDateBtn.setTitle(date_Str, for: .normal)
        }else{
            
            endDate = date
            isEndDateSelected = true
            endDateBtn.setTitle(date_Str, for: .normal)
        }
    }
}
