//
//  WeekDetailsViewController.swift
//  BabyTrackingSystem
//
//  Created by Giridhar Addagalla on 17/11/2021.
//

import UIKit
import Firebase


class WeekDetailsViewController: UIViewController {
    
    
    @IBOutlet var view1: UIView!
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var view2: UIView!
    @IBOutlet var detailsLbl: UILabel!
    
    @IBOutlet var showAllBtn: UIButton!
    
    var week = ""
    var fromView = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = String(format: "Week-%@ Details", week)
        setDesign()
        
        GlobalMethods.delegate = self
        GlobalMethods.getWeeklyDetails()
        
        showData()
    }
    
    @objc func editDetailsClicked() -> Void {
        
        if fromView == "initial" {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddDetailsViewController") as! AddDetailsViewController
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            
        }else{
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func setDesign() -> Void {
        
        self.navigationController?.navigationBar.isHidden = false
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "edit"), style: .done, target: self, action: #selector(editDetailsClicked))
        rightBarButtonItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        
        view1.layer.cornerRadius = 16
        view1.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view1.clipsToBounds = true
        
        view2.layer.cornerRadius = 16
        view2.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func showData() -> Void {
        
        var index = Int(week) ?? 1
        index -= 1
        
        let dict = weeklyDetails[index] as? NSDictionary ?? NSDictionary()
        print(dict)
        
        let htmlStringCode = dict.value(forKey: "detail") as? String ?? ""
        guard let data = htmlStringCode.data(using: .utf8) else {
            return
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return
        }
        
        detailsLbl.attributedText = attributedString
        
        let urlString = dict.value(forKey: "image") as? String ?? ""
        if urlString != "" {
            
            view1.isHidden = false
            let Ref = Storage.storage().reference(forURL: urlString)

            Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if error != nil {
                    print("Error: Image could not download!")
                } else {
                    self.imgView.image = UIImage(data: data!)
                }
            }
        }else{
            
            view1.isHidden = true
        }
    }
    
    @IBAction func showAllBtnClicked(_ sender: Any) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "WeeksViewController") as! WeeksViewController
        VC.delegate = self
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
}


extension WeekDetailsViewController: selectWeekDelegate {
    
    func didSelectWeek(str: String) {
        
        week = str
        self.navigationItem.title = String(format: "Week-%@ Details", week)
        self.showData()
        
    }
    
}

extension WeekDetailsViewController: fetchDataFirebase{
    
    func didFetchData() {
        
        showData()
        
    }
    
}
