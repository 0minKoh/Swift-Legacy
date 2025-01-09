//
//  instanceDetailViewContainer.swift
//  App-Start
//
//  Created by supaja on 2022/12/24.
//

import UIKit

class InstanceDetailViewContainer: UIViewController {
    
    var mainVC: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendDataMainVc(_ sender: Any) {
        mainVC?.dataLabel.text = "some data"
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
