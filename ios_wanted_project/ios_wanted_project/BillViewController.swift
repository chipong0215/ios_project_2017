//
//  BillViewController.swift
//  ios_wanted_project
//
//  Created by valerie's mac on 2017/6/19.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit

class BillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var privatelist1 = ["11","22"]
    var privatelist2 = ["111","222"]
    var privatelist3 = ["1111","2222"]
    
    
    @IBOutlet weak var Control: UISegmentedControl!
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillCell1", for: indexPath)
        
        switch(Control.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = privatelist1[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = privatelist2[indexPath.row]
            break
        case 2:
            cell.textLabel?.text = privatelist3[indexPath.row]
            break
        default :
            break
        }
        
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
       switch(Control.selectedSegmentIndex)
       {
       case 0:
        returnValue = privatelist1.count
        
        break
       case 1:
        returnValue = privatelist2.count
        break
       case 2:
        returnValue = privatelist3.count
        break
       default :
        break
        }
        
    return returnValue
        
    }
    
    
    @IBAction func ControlAction(_ sender: Any) {
        
        TableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
