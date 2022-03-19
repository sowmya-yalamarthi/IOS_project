//
//  SplashViewController.swift
//  OnlineMaid
//
//  Created by Giridhar Addagalla on 25/06/2020.
//  Copyright © 2020 Giridhar Addagalla. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalMethods.getWeeklyDetails()
        perform(#selector(MoveToView), with: nil, afterDelay: 3.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func MoveToView() -> Void {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
}
