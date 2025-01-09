//
//  ViewController.swift
//  supaja-bazaar
//
//  Created by supaja on 2023/04/18.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var WebViewMain: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.WebViewMain?.allowsBackForwardNavigationGestures = true
        
        let urlStringBazaarMain = "https://www.supaja.com/"
        
        if let urlBazaarMain = URL(string: urlStringBazaarMain) {
            let urlBazaarReq = URLRequest(url: urlBazaarMain)
            WebViewMain.load(urlBazaarReq)
        }
    }
}

