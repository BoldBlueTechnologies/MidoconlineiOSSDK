//
//  PMWebViewController.swift
//  PacienteMidoconlineSDK
//
//  Created by Christian Martinez on 23/06/25.
//

import UIKit
import WebKit
import AVKit

@MainActor
final class PMWebViewController: UIViewController, WKNavigationDelegate {


    private let targetURL = URL(string: "https://paciente.midoconline.com/")!

  
    private var webView: WKWebView!
    private let topBar  = UIView()
    private let closeBtn = UIButton(type: .system)
    private let titleLbl = UILabel()
    private let urlLbl   = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        clearCacheThenLoad()
    }


    private func buildUI() {


        topBar.backgroundColor = UIColor(red: 0/255, green: 2/255, blue: 81/255, alpha: 1)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 44)
        ])

        closeBtn.setTitle("✕", for: .normal)
        closeBtn.setTitleColor(.white, for: .normal)
        closeBtn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        closeBtn.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(closeBtn)

        NSLayoutConstraint.activate([
            closeBtn.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 12),
            closeBtn.centerYAnchor.constraint(equalTo: topBar.centerYAnchor)
        ])

 
        titleLbl.text = "Midoconline"
        titleLbl.font = UIFont(name: "Montserrat-Regular", size: 12)
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center

        urlLbl.text   = targetURL.absoluteString
        urlLbl.font   = UIFont(name: "Montserrat-Regular", size: 10)
        urlLbl.textColor = .white
        urlLbl.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [titleLbl, urlLbl])
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: topBar.centerYAnchor)
        ])

        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.allowsPictureInPictureMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.defaultWebpagePreferences.allowsContentJavaScript = true

        webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never

        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

 
    private func clearCacheThenLoad() {
        let types: Set<String> = [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache]
        WKWebsiteDataStore.default().removeData(ofTypes: types,
                                                modifiedSince: .distantPast) { [weak self] in
            guard let self else { return }
            self.webView.load(URLRequest(url: self.targetURL))
        }
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
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
