//
//  LiveViewController.swift
//  CRM_supaja
//
//  Created by supaja on 2023/01/30.
//

import UIKit
import WebKit

class LiveViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var WebViewLive: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebViewLive.navigationDelegate = self
        
        self.WebViewLive?.allowsBackForwardNavigationGestures = true
        
        // 당겨서 새로고침 허용
        self.WebViewLive?.scrollView.isScrollEnabled = true
        self.WebViewLive?.scrollView.refreshControl = UIRefreshControl()
        self.WebViewLive?.scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        //1. url string
        let urlStringLive = "https://crm.supaja.co.kr/live/cls_apply_list?menu_cat=live&cat_name=LIVE&menu_name=%EC%88%98%EC%97%85%EC%8B%A0%EC%B2%AD"
        
        //2. url > request
        if let urlLive = URL(string: urlStringLive) { //unwrap
            let urlLiveReq = URLRequest(url: urlLive)
            
            //3. request > webview load
            WebViewLive.load(urlLiveReq)
        }
    }
    
    // 당겨서 새로고침 이벤트 함수
    @objc func refresh() {
        self.WebViewLive?.reload()
        self.WebViewLive.scrollView.refreshControl?.endRefreshing()
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
        self.WebViewLive?.allowsBackForwardNavigationGestures = true
        
        //1. url string
        let urlStringLive = "https://crm.supaja.co.kr/live/cls_apply_list?menu_cat=live&cat_name=LIVE&menu_name=%EC%88%98%EC%97%85%EC%8B%A0%EC%B2%AD"
        
        //2. url > request
        if let urlLive = URL(string: urlStringLive) { //unwrap
            let urlLiveReq = URLRequest(url: urlLive)
            
            //3. request > webview load
            WebViewLive.load(urlLiveReq)
        }
    }
}
