//
//  ViewController.swift
//  Project 4
//
//  Created by Aleksandr Pavlov on 15.12.21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var webSiteToLoad: String?
    


    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        

        let url = URL(string: "https://" + webSiteToLoad!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "←", style: .done, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: "→", style: .done, target: webView, action: #selector(webView.goForward))

        toolbarItems = [progressButton, back, forward, spacer, refresh]
        navigationController?.isToolbarHidden = false

        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host {
            if host.contains(webSiteToLoad!) {
                decisionHandler(.allow)
                
                return
            }
            let ac = UIAlertController(title: "Opps", message: "This site is blocked", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Stay here", style: .cancel, handler: nil))
            present(ac, animated: true)
        }
    decisionHandler(.cancel)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
