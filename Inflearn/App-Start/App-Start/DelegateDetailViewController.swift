//
//  DeligateDetailViewController.swift
//  App-Start
//
//  Created by supaja on 2022/12/24.
//

import UIKit

protocol DelegateDetailViewControllerDelegate: AnyObject {
    func passString(string: String) // 함수 init
}

class DelegateDetailViewController: UIViewController {
    
    weak var delegate: DelegateDetailViewControllerDelegate?
    
    @IBAction func passDataToMainVc(_ sender: Any) {
        delegate?.passString(string: "delegate pass Data")
        self.dismiss(animated: true, completion: nil)
    }
}
