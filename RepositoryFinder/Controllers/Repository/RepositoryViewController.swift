//
//  RepositoryViewController.swift
//  RepositoryFinder
//
//  Created by SMMC on 17/10/2021.
//

import UIKit
import WebKit

class RepositoryViewController: UIViewController {

    //MARK: - Properties

    var url: URL?

    //MARK: - User Interface

    @IBOutlet weak var repoPageWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = url else { return }
        
        repoPageWebView.navigationDelegate = self
        repoPageWebView.load(URLRequest(url: url))
        repoPageWebView.allowsBackForwardNavigationGestures = true
        
        self.activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.openInSafari))
    }
    
    @objc func openInSafari() {
        guard let url = url else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

//MARK: - WKNavigationDelegate methods
extension RepositoryViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
       debugPrint("didCommit")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       debugPrint("didFail")
    }
}
