//
//  StudentViewController.swift
//  Webview_Test
//
//  Created by supaja on 2023/01/01.
//

import UIKit
import WebKit

class TeacherViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var WebViewTeacher: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebViewTeacher.navigationDelegate = self
        // Do any additional setup after loading the view.
        
        self.WebViewTeacher?.allowsBackForwardNavigationGestures = true
        
        // 당겨서 새로고침 허용
        self.WebViewTeacher?.scrollView.isScrollEnabled = true
        self.WebViewTeacher?.scrollView.refreshControl = UIRefreshControl()
        self.WebViewTeacher?.scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        //1. url string
        let urlString = "https://crm.supaja.co.kr/teacher_list"
        
        //2. url > request
        if let url = URL(string: urlString) { //unwrap
            let urlReq = URLRequest(url: url)
                
        //3. request > webview load
            WebViewTeacher.load(urlReq)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            decisionHandler(.cancel)
            webView.load(navigationAction.request)
        } else {
            decisionHandler(.allow)
        }
    }
    
    // 당겨서 새로고침 이벤트 함수
    @objc func refresh() {
        self.WebViewTeacher?.reload()
        self.WebViewTeacher.scrollView.refreshControl?.endRefreshing()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //1. url string
        let urlString = "https://crm.supaja.co.kr/teacher_list"
        
        //2. url > request
        if let url = URL(string: urlString) { //unwrap
            let urlReq = URLRequest(url: url)
                
        //3. request > webview load
            WebViewTeacher.load(urlReq)
        }
    }
}
