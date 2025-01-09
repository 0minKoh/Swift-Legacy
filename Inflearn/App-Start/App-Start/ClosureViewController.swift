//
//  ClosureViewController.swift
//  App-Start
//
//  Created by supaja on 2022/12/24.
//

import UIKit

class ClosureViewController: UIViewController {
    
    var myClosure: ((String) -> Void)? //return 없을 시 void
    
    @IBAction func closurePassData(_ sender: Any) {
        myClosure?("closure string")
    }
    
}
