//
//  NotiDetailViewController.swift
//  App-Start
//
//  Created by supaja on 2022/12/24.
//

import UIKit

class NotiDetailViewController: UIViewController {
    
    @IBAction func notiAction(_ sender: Any) {
        let notificationName = Notification.Name("sendSomeString")
        
        let strDic = ["str": "noti string"]
        
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: strDic)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
