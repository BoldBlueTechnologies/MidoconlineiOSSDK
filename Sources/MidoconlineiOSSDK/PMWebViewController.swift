//
//  PMWebViewController.swift
//  PacienteMidoconlineSDK
//
//  Created by Christian Martinez on 23/06/25.
//


import WebKit
import UIKit
import AVKit

@MainActor final class PMWebViewController: UIViewController, WKNavigationDelegate {

    private let targetURL = URL(string: "https://paciente.midoconline.com/")!
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        clearCacheThenLoad()
    }

    private func configureWebView() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.allowsPictureInPictureMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        view = webView
    }

    private func clearCacheThenLoad() {
        let types: Set<String> = [WKWebsiteDataTypeDiskCache,
                                  WKWebsiteDataTypeMemoryCache]
        WKWebsiteDataStore.default().removeData(
            ofTypes: types,
            modifiedSince: .distantPast) { [weak self] in
                self?.webView.load(URLRequest(url: self!.targetURL))
        }
    }

  
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       
    }
}
@available(iOS 15.0, *)
extension UIApplication {
    static var topMost: UIViewController? {
        guard let keyWindow = shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow }).first,
              var top = keyWindow.rootViewController else { return nil }
        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }
}
