//
//  ClassViewController.swift
//  CRM_supaja
//
//  Created by supaja on 2023/01/30.
//

import UIKit
import WebKit

class ClassViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var WebViewClass: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebViewClass.navigationDelegate = self
        
        // gesture - swipe back
        self.WebViewClass?.allowsBackForwardNavigationGestures = true
        
        // 당겨서 새로고침 허용
        self.WebViewClass?.scrollView.isScrollEnabled = true
        self.WebViewClass?.scrollView.refreshControl = UIRefreshControl()
        self.WebViewClass?.scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        // 1. url string
        let urlStringClass = "https://crm.supaja.co.kr/student_cs_list?menu_cat=student&cat_name=%ED%95%99%EC%83%9D&menu_name=%EC%B2%B4%ED%97%98%EC%88%98%EC%97%85&cs_sts=T"
        
        // 2. url > request
        if let urlClass = URL(string: urlStringClass) { //unwrap
            let urlClassReq = URLRequest(url: urlClass)
            
            //3. request > webview load
            WebViewClass.load(urlClassReq)
        }
    }
    
    // 당겨서 새로고침 이벤트 함수
    @objc func refresh() {
        self.WebViewClass?.reload()
        self.WebViewClass.scrollView.refreshControl?.endRefreshing()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            decisionHandler(.cancel)
            webView.load(navigationAction.request)
        } else {
            decisionHandler(.allow)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.WebViewClass?.allowsBackForwardNavigationGestures = true
        
        //1. url string
        let urlStringClass = "https://crm.supaja.co.kr/live/cls_apply_list?menu_cat=live&cat_name=LIVE&menu_name=%EC%88%98%EC%97%85%EC%8B%A0%EC%B2%AD"
        
        // 2. url > request
        if let urlClass = URL(string: urlStringClass) { //unwrap
            let urlClassReq = URLRequest(url: urlClass)
            
            //3. request > webview load
            WebViewClass.load(urlClassReq)
        }
    }

}
