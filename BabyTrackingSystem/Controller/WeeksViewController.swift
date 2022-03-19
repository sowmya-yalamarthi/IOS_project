//
//  WeeksViewController.swift
//  BabyTrackingSystem
//
//  Created by Giridhar Addagalla on 17/11/2021.
//

import UIKit

protocol selectWeekDelegate {
    
    func didSelectWeek(str: String) -> Void
    
}


class WeeksViewController: UIViewController {
    
    var delegate: selectWeekDelegate?
    
    
    @IBOutlet var dataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Select Week"
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.backgroundColor = .clear
        
    }
}

extension WeeksViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("weekTableViewCell", owner: self, options: nil)?.first as! weekTableViewCell
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        
        let index = indexPath.row + 1
        let str = index < 10 ? (String(format: "0%d", index)) : (String(format: "%d", index))
        
        cell.weekNumberLbl.text = "Week-\(str)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row + 1
        let str = index < 10 ? (String(format: "0%d", index)) : (String(format: "%d", index))
        
        delegate?.didSelectWeek(str: str)
        self.navigationController?.popViewController(animated: true)
    }
}
