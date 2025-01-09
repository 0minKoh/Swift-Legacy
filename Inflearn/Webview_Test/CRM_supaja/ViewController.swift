//
//  ViewController.swift
//  Webview_Test
//
//  Created by supaja on 2023/01/01.
//

import UIKit
import WebKit

class ViewController: UIViewController, AppDelegateDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var WebViewMain: WKWebView! // webview 인스턴스를 storyboard로부터 가져옵니다.
    
    var url: URL?
    
    // url 이동함수
    func didReceiveUrlString(urlString: String) { // 이동할 url을 urlString 변수에 담아옵니다.
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) // urlString을 인코딩하여
        if let encodedString = encodedString, let url = URL(string: encodedString) { // url로 이동합니다.
            self.url = url
            self.viewDidLoad()
        }
    }
    
    // 라이프 사이클: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        WebViewMain.navigationDelegate = self //webview가 변경될 때 NavigationController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.delegate = self
        
        self.WebViewMain?.allowsBackForwardNavigationGestures = true // 뒤로가기 제스처를 허용합니다.
        
        // 당겨서 새로고침 허용
        self.WebViewMain?.scrollView.isScrollEnabled = true
        self.WebViewMain?.scrollView.refreshControl = UIRefreshControl()
        self.WebViewMain?.scrollView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        

        // 1. url: string을 받아옵니다.
        let urlStringStudent = "https://crm.supaja.co.kr/student_list" // 이동할 url 링크를 할당합니다.
        if let receivedUrl = url {
                // 만약 url에 값이 이미 할당되어 있다면 (=처음으로 앱을 킨 것이 아니면) 아무것도 실행하지 않습니다.
            } else {
                url = URL(string: urlStringStudent) // url이 nil이라면 (=처음으로 앱을 킨 것이라면) url 변수에 urlStringStudent 링크를 할당합니다.
            }
        
        // 2. url 이동을 요청합니다.
        if let urlStudent = url { // url 변수가 nil이 아닐 때 실행합니다.
            let urlStudentReq = URLRequest(url: urlStudent) // URLRequest 형태로 url을 바꿉니다.
                
        // 3. 요청 받은 링크로 webview에서 이동합니다. (WebView컴포넌트.load(URLRequest 형태의 url)
            WebViewMain.load(urlStudentReq)
        }
    }
    
    // 당겨서 새로고침 이벤트 함수
    @objc func refresh() {
        self.WebViewMain?.reload()
        self.WebViewMain.scrollView.refreshControl?.endRefreshing()
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // target_blank 처리
        if navigationAction.targetFrame == nil {
            decisionHandler(.cancel)
            webView.load(navigationAction.request) // 요청을 webview에서 로드
        } else {
            decisionHandler(.allow)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // 1. url: string을 받아옵니다.
        let urlStringStudent = "https://crm.supaja.co.kr/student_list"
        
        if let urlStudent = URL(string: urlStringStudent) {
            // 2. url 이동을 요청합니다.
            let urlStudentReq = URLRequest(url: urlStudent)
            
            // 3. 요청 받은 링크로 webview에서 이동합니다. (WebView컴포넌트.load(URLRequest 형태의 url)
            WebViewMain.load(urlStudentReq)
        }
    }
}

