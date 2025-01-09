//
//  ViewController.swift
//  App-Start
//
//  Created by supaja on 2022/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification
        let notificationName = Notification.Name("sendSomeString")
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSomeString), name: notificationName, object: nil)
    }
    
    @objc func showSomeString(notification: Notification) {
        if let str = notification.userInfo?["str"] as? String {
            self.dataLabel.text = str
        }
    }
    
    
    @IBAction func moveToNoti(_ sender: Any) {
        let detailVC = NotiDetailViewController(nibName: "NotiDetailViewController", bundle: nil)
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    
    
    // 실행 - command + R
    
    @IBOutlet weak var testButton: UIButton!
    //@IBOutlet 화면과 연결해주는 기능
    
    @IBAction func toDoSomething(_ sender: Any) {
        //@IBAction 작동과 연결해주는 기능
        testButton.backgroundColor = .orange // UIcolor 생략가능(타입 생략)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as DetailVC
        
        self.present(detailVC, animated: true, completion: nil)
        
        
    }
    
    
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueDetail" {
            if let detailVC = segue.destination as? SegueDetailViewController {
                detailVC.dataString = "abcd"
            }
        }
    }
    
    // instance
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBAction func moveToInstance(_ sender: Any) {
        let detailVC = InstanceDetailViewContainer(nibName: "InstanceDetailViewController", bundle: nil)
        
        detailVC.mainVC = self
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    // deligate
    @IBAction func moveToDelegate(_ sender: Any) {
        let detailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        detailVC.delegate = self //모든 요소가 아닌, 규격을 준수하는 요소에 한해서 할당됨 (extension 부분만)
        self.present(detailVC, animated: true, completion: nil)
    }
    
    // closure
    // deligate와 유사하게 호출부와 선언(구현)부가 분리
    
    @IBAction func moveToClosure(_ sender: Any) {
        let detailVC = ClosureViewController(nibName: "ClosureDatailController", bundle: nil)
        
        detailVC.myClosure = { str in
            self.dataLabel.text = str
        }
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    
}

extension ViewController: DelegateDetailViewControllerDelegate {
    // protocol 준수
    func passString(string: String) {
        self.dataLabel.text = string
    }
}

