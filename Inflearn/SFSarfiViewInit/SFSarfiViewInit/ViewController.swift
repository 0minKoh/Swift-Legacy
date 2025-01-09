//
//  ViewController.swift
//  SFSarfiViewInit
//
//  Created by supaja on 2023/06/20.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate  {
    
    @IBOutlet weak var WebViewMain: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initUrl = URL(string: "https://warm-starlight-84b019.netlify.app/")
        if let url = initUrl {
            let urlRequest = URLRequest(url: url)
            WebViewMain.load(urlRequest)
        }
        
        // Start:: Delegate 설정
        self.WebViewMain?.navigationDelegate = self // 네비게이션 이벤트를 현재 클래스에서 처리하도록
        self.WebViewMain?.allowsBackForwardNavigationGestures = true // 뒤(앞으)로 가기 제스처 허용
        self.WebViewMain?.uiDelegate = self // 웹뷰 자체의 UI 이벤트를 현재 클래스에서 처리하도록
        // End:: Delegate 설정
        
        // Start:: JavaScript 활성화
        let preferences = WKWebpagePreferences() // 기본 동작을 구성하는데 사용되는 인스턴스
        preferences.allowsContentJavaScript = true
        WebViewMain.configuration.defaultWebpagePreferences = preferences
        // End:: JavaScript 활성화
    }
    
    
}

