//
//  SegueDetailViewController.swift
//  App-Start
//
//  Created by supaja on 2022/12/24.
//

import UIKit

class SegueDetailViewController: UIViewController {
    
    @IBOutlet weak var dataLable: UILabel!
    
    var dataString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataLable.text = dataString

        // Do any additional setup after loading the view.
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
