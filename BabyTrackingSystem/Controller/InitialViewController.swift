//
//  InitialViewController.swift
//  BabyTrackingSystem
//
//  Created by Giridhar Addagalla on 17/11/2021.
//

import UIKit
import FittedSheets

class InitialViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    func setDesign() -> Void {
        
        GlobalMethods.CreateCardView(radius: 16, view: contentView)
    }
    
    @IBAction func continueBtnClicked(_ sender: Any) {
        
        if GlobalMethods.isKeyPresentInUserDefaults(key: "start") {
            
            let theFirstDate = UserDefaults.standard.value(forKey: "start") as? Date ?? Date()
            let theSecondDate = Date()
            let theComponents = Calendar.current.dateComponents([.weekOfYear], from: theFirstDate, to: theSecondDate)
            let theNumberOfWeeks = theComponents.weekOfYear ?? 0
            
            let index = theNumberOfWeeks + 1
            let str = index < 10 ? (String(format: "0%d", index)) : (String(format: "%d", index))
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "WeekDetailsViewController") as! WeekDetailsViewController
            VC.week = str
            VC.fromView = "initial"
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            
        }else{
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddDetailsViewController") as! AddDetailsViewController
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}
