//
//  MyIDViewController.swift
//  Setting-App
//
//  Created by supaja on 2022/12/29.
//

import UIKit

//file Owner가 xib를 관리

class MyIDViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
        // 해당 버튼이 로드될 때 { didset }
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // 초기에 next 버튼이 활성화되는 문제를 막는 2번째 방법
         textFieldDidChange(sender: emailTextField)
        
    }
    
    //selector는 objc 키워드가 필요
    @objc func textFieldDidChange(sender: UITextField) {
        
        if sender.text?.isEmpty == true {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
}
