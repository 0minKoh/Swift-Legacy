//
//  SubViewController.swift
//  Tab_Master
//
//  Created by supaja on 2022/12/30.
//

import UIKit
import WebKit

class SubViewController: UIViewController {

    @IBOutlet weak var WebViewNaver: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Naver"
        
        let naverUrlStr = "https://www.naver.com/"
        if let naverUrl = URL(string: naverUrlStr) {
            let naverUrlRequest = URLRequest(url: naverUrl)
            WebViewNaver.load(naverUrlRequest)
        }
        
        
    }

}
