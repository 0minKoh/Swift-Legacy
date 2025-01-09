//
//  ViewController.swift
//  bazaarv2
//
//  Created by supaja on 2023/05/08.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var WebViewMain: WKWebView!
    
    let dropdownMenuContainer = UIView()
    var isDropdownVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start:: Delegate 설정
        self.WebViewMain?.navigationDelegate = self // 네비게이션 이벤트를 현재 클래스에서 처리하도록
        self.WebViewMain?.allowsBackForwardNavigationGestures = true // 뒤(앞으)로 가기 제스처 허용
        self.WebViewMain?.uiDelegate = self // 웹뷰 자체의 UI 이벤트를 현재 클래스에서 처리하도록
        // End:: Delegate 설정
        
        // Start:: Navigation Controller
        
        // logo
        let LogoRendered = UIImage(named: "MainLogo")
        if let LogoRendered = LogoRendered {
            let LogoImage = LogoRendered.withRenderingMode(.alwaysOriginal)
            let targetSize = CGSize(width: 120, height: 37)
            
            let barButtonItem = UIBarButtonItem(image: resizeImage(image: LogoImage, targetSize: targetSize).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleClickLogo))
            navigationItem.leftBarButtonItem = barButtonItem
        }
        
        func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
            let rendered = UIGraphicsImageRenderer(size: targetSize)
            return rendered.image { (context) in
                image.draw(in: CGRect(origin: .zero, size: targetSize))
            }
        }
        
        // right btn
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let hamburgerBtn = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(handleClickMenu))
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let cartBtn = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(handleClickCart))
        
        let spacing: CGFloat = 0
        fixedSpace.width = spacing
        
        navigationItem.rightBarButtonItems = [hamburgerBtn, fixedSpace, cartBtn]
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        // Dropdown
        let navigationSize = navigationController?.navigationBar.frame.size
        let dropdownMenuWidth: CGFloat = navigationSize?.width ?? 0
        let dropdownMenuHeight: CGFloat = 60
        let navigationHeight = navigationSize?.height ?? 0
        
        let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        dropdownMenuContainer.frame = CGRect(x: 0, y: navigationHeight + statusBarHeight, width: dropdownMenuWidth, height: dropdownMenuHeight)
        dropdownMenuContainer.backgroundColor = .white
        dropdownMenuContainer.isHidden = true
        
        // 드롭다운 메뉴에 들어갈 항목들을 추가 (버튼, 레이블 등)
       let menuItem1 = UIButton(type: .system)
       menuItem1.setTitle("수파자 바자회", for: .normal)
       menuItem1.frame = CGRect(x: 0, y: 0, width: dropdownMenuWidth, height: 60)
       menuItem1.addTarget(self, action: #selector(handleClickMenuItem), for: .touchUpInside)
        
        dropdownMenuContainer.addSubview(menuItem1)
        
        view.addSubview(dropdownMenuContainer)
        
        // End:: Navigation Controller

        // Start:: JavaScript 활성화
        let preferences = WKWebpagePreferences() // 기본 동작을 구성하는데 사용되는 인스턴스
        preferences.allowsContentJavaScript = true
        WebViewMain.configuration.defaultWebpagePreferences = preferences
        // End:: JavaScript 활성화
        
        // Start:: Webview 로드
        let urlStringBazaarMain = "https://gift.supaja.com/"
        if let urlBazaarMain = URL(string: urlStringBazaarMain) {
            let urlBazaarReq = URLRequest(url: urlBazaarMain)
            WebViewMain.load(urlBazaarReq) // WebView.load(URLReqest), URLReqest(url: URL(string: ""))
        }
        // End:: Webview 로드
        
        
        // Start:: user-agent 값 커스텀 설정 (잠재적 위험)
        self.WebViewMain?.evaluateJavaScript("navigator.userAgent") {(result, error) in
            let originUserAgent = String(describing: result ?? "") // originUserAgent 확인
            self.WebViewMain?.customUserAgent = "\(originUserAgent) Mobile/15E148" // user-agent 값 커스텀 변경 실시
        }
        // End:: user-agent 값 커스텀 설정
    }
    
    // Start:: Navigation Action Method
    @objc func addButtonTapped() {
        print("버튼이 눌렸음")
    }
    
    @objc func handleClickLogo() {
        WebViewMain.load(URLRequest(url: URL(string: "https://gift.supaja.com/")!))
    }
    
    @objc func handleClickMenu() {
        if isDropdownVisible {
            UIView.animate(withDuration: 0.3, animations: {
                self.dropdownMenuContainer.frame.origin.y -= self.dropdownMenuContainer.frame.size.height
            }) { _ in
                self.dropdownMenuContainer.isHidden = true
                self.dropdownMenuContainer.frame.origin.y += self.dropdownMenuContainer.frame.size.height
            }
        } else {
            dropdownMenuContainer.isHidden = false
            dropdownMenuContainer.frame.origin.y -= dropdownMenuContainer.frame.size.height
            UIView.animate(withDuration: 0.3) {
                self.dropdownMenuContainer.frame.origin.y += self.dropdownMenuContainer.frame.size.height
            }
        }
        
        isDropdownVisible.toggle()
    }
    
    @objc func handleClickCart() {
        WebViewMain.load(URLRequest(url: URL(string: "https://gift.supaja.com/baz/my")!))
    }
    
    @objc func handleClickMenuItem() {
        let supajaUrl = URL(string: "https://www.supaja.com/")
        if UIApplication.shared.canOpenURL(supajaUrl!) {
            UIApplication.shared.open(supajaUrl!, options: [:], completionHandler: nil)
        } else {
            print("URL을 열 수 없음")
        }
    }
    // End:: Navigation Action Method
    
    
    
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
        // End:: INNIpay 핸들링
        
        
        // Start:: Nice 인증
        var niceUrlHandled = false // url을 한번만 실행하기

        if !niceUrlHandled && url.absoluteString.hasPrefix("https://nice.checkplus.co.kr/") {
            print("NiceUrl \(url)")
            
            let newWebView = WKWebView() // 새로운 WKWebView를 만듭니다.
            self.view.addSubview(newWebView)
            
            // Autolayout 설정을 통해 Safe Area에 맞춰 크기를 설정합니다.
            newWebView.translatesAutoresizingMaskIntoConstraints = false
            let constraints = [
                newWebView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                newWebView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                newWebView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                newWebView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        
            newWebView.load(URLRequest(url: url)) // 원하는 설정을 적용하고 웹페이지를 로드합니다.
            
            decisionHandler(.cancel)
            niceUrlHandled = true // 코드가 실행되었음을 표시하기 위해 플래그를 true로 설정합니다.
            return
        }
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
    }
    // End:: WKNavigationDelegate 메서드 구현
    
    // Start:: 서버 리디렉션 감지 (Error Code: 3XX)
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else {
            debugPrint("error")
            return
        }
        
        debugPrint("redirect url: \(urlString)")
    }
    // End:: 서버 리디렉션 감지 (Error Code: 3XX)
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
