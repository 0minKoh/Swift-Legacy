//
//  ViewController.swift
//  Tab_Master
//
//  Created by supaja on 2022/12/30.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var WebViewGoogle: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.WebViewGoogle?.allowsBackForwardNavigationGestures = true
        
        self.view.backgroundColor = UIColor.yellow
        
        self.title = "title"
        
        let urlNaverStr = "https://www.google.co.kr/"
        if let urlNaver = URL(string: urlNaverStr) {
            let urlNaverRequest = URLRequest(url: urlNaver)
            
            WebViewGoogle.load(urlNaverRequest)
        }
        
    }
}

