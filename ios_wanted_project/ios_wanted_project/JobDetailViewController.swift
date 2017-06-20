//
//  JobDetailViewController.swift
//  ios_wanted_project
//
//  Created by valerie's mac on 2017/6/20.
//  Copyright © 2017年 Pong. All rights reserved.
//

import UIKit
import Firebase

class JobDetailViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var RewardLabel: UILabel!
    @IBOutlet weak var RegionLabel: UILabel!
    @IBOutlet weak var DetailTextView: UITextView!
    @IBOutlet weak var GoProfileBtn: UIButton!
    
    var titletmp = ""
    var timetmp = ""
    var rewardtmp = ""
    var regiontmp = ""
    var detailtmp = ""
    var userProfileTmp: User?
    var fileUploadDic: [String:Any]?
    var keytmp = ""
    var requestertmp = ""
    var caseCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleLabel.text = titletmp
        RewardLabel.text = rewardtmp
        RegionLabel.text = regiontmp
        DetailTextView.text = detailtmp
        TimeLabel.text = timetmp
        
        if caseCount == 0 {
            self.GoProfileBtn.setTitle("Helper Profile", for: .normal)
        }
        else if caseCount == 1 {
            self.GoProfileBtn.setTitle("Requester Profile", for: .normal)
        }
        else if caseCount == -1 {
            self.GoProfileBtn.isHidden = true
        }

        let databaseRef = Database.database().reference()
        databaseRef.child("ProfileUpload").observe(.value, with: { [weak self] (snapshot) in
            if let uploadDataDic = snapshot.value as? [String:Any] {
                self?.fileUploadDic = uploadDataDic
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "JobDetailToBillHelper" {
            let destinationController = segue.destination as! BillHelperProfileViewController
            if let dataDic = fileUploadDic {
            if let imageUrlString = dataDic[(userProfileTmp?.image)!] as? String {
                if let imageUrl = URL(string: imageUrlString) {
                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                        if error != nil {
                            print("Download Image Task Fail: \(error!.localizedDescription)")
                        }
                        else if let imageData = data {
                            DispatchQueue.main.async {
                                destinationController.ProfilePic.image = UIImage(data: imageData)
                            }
                        }
                    }).resume()
                }
            }
        }
        
        destinationController.nameTmp = (userProfileTmp?.name)!
        destinationController.emailTmp = (userProfileTmp?.email)!
        destinationController.phoneTmp = (userProfileTmp?.tel)!
        destinationController.detailTmp = (userProfileTmp?.detail)!
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

}
