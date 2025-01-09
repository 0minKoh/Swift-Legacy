//
//  ViewController.swift
//  bazaarv2
//
//  Created by supaja on 2023/05/08.
//

import UIKit
import WebKit
import SafariServices

class TempViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var WebViewMain: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start:: WebView Url 설정과 Load
        self.WebViewMain?.navigationDelegate = self
        self.WebViewMain?.allowsBackForwardNavigationGestures = true // 뒤로가기 제스처
        self.WebViewMain?.uiDelegate = self
        
        let urlStringBazaarMain = "https://dna.supaja.com/bazaar"
        
        if let urlBazaarMain = URL(string: urlStringBazaarMain) {
            let urlBazaarReq = URLRequest(url: urlBazaarMain)
            WebViewMain.load(urlBazaarReq)
        }
        // End:: WebView Url 설정과 Load
        
        // Start:: user-agent 값 확인
        self.WebViewMain?.evaluateJavaScript("navigator.userAgent") {(result, error) in
            let originUserAgent = String(describing: result ?? "") // originUserAgent 확인
            self.WebViewMain?.customUserAgent = "\(originUserAgent) Mobile/15E148" // user-agent 값 커스텀 변경 실시
        }
        // End:: user-agent 값 확인
    }
    
    // Start:: 쿠키 설정 - 항상 허용
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        HTTPCookieStorage.shared.cookieAcceptPolicy = HTTPCookie.AcceptPolicy.always
        return true
    }
    // End:: 쿠키 설정 - 항상 허용
    
    // Start:: WKNavigationDelegate 메서드 구현
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // Start:: INNIpay 핸들링
        let request = navigationAction.request
        let optUrl = request.url
        let optUrlScheme = optUrl?.scheme
        let defaultUrl = "https://dna.supaja.com/bazaar"
        
        guard let url = optUrl, let scheme = optUrlScheme
        else {
            return decisionHandler(.cancel)
        }
        
        if (scheme != "http" && scheme != "https") {
            if (UIApplication.shared.canOpenURL(url)) {
                UIApplication.shared.open(url)
            }
        } else if (scheme == "http") {
            let onclickUrlString = optUrl?.absoluteString
            if var components = URLComponents(string: onclickUrlString ?? defaultUrl) {
                components.scheme = "https"
                
                if let newOnclickUrl = components.url {
                    webView.load(URLRequest(url: newOnclickUrl))
                    decisionHandler(.cancel)
                    return
                }
            }
        }
        
        // Start:: Nice 인증
        if url.absoluteString.hasPrefix("https://nice.checkplus.co.kr/") {
            webView.load(URLRequest(url: url))
            decisionHandler(.cancel)
            return
        }
        
//        if url.absoluteString.hasPrefix("https://nice.checkplus.co.kr/") {
//            openPassWindow(url: url.absoluteString)
//        }
//
//        func openPassWindow(url: String) {
//            let safariViewController = SFSafariViewController(url: URL(string: url)!)
//            present(safariViewController, animated: true, completion: nil)
//        }
        // End:: Nice 인증
        
        // Start:: target="_blank" 처리
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            decisionHandler(.cancel)
            return
        }
        // End:: target="_blank" 처리
        
        decisionHandler(.allow)
        
        // Start:: 디버깅
         debugPrint("url : \(url)")
         debugPrint("scheme : \(scheme)")
        // End:: 디버깅
        
        // End:: INNIpay 핸들링
    }
    // End:: WKNavigationDelegate 메서드 구현
    
    // Start:: ??
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else {
            debugPrint("error")
            return
        }
        
        debugPrint("redirect url: \(urlString)")
    }
    // End:: ??
}

// Start:: alert 적용
extension ViewController: WKUIDelegate {
      func webView(
        _ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String,
        initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void
      ) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in
          completionHandler()
        }
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
          self.present(alertController, animated: true, completion: nil)
        }
      }
}
// End:: alert 적용

extension ViewController: SFSafariViewControllerDelegate {
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        let initialUrl = "http://dna.supaja.com/baz/my"
        let initialUrlRequest = URLRequest(url: URL(string: initialUrl)!)
        WebViewMain.load(initialUrlRequest)
    }
}

// appCheck.jsp : Pass 앱 호출시 마지막 요청
// service.cb : 인증 확인 전 요청
