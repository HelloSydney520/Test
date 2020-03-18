//
//  ArticleDetailsViewController.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailsViewController: ViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var url: String?
    var headline: String?
    
    private var observation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update progress view
        observation = webView.observe(\WKWebView.estimatedProgress, options: .new) { [weak self] _, _ in
            if let progress = self?.webView.estimatedProgress {
                self?.progressView.progress = Float(progress)
                if progress >= 1.0 {
                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
                        self?.progressView.alpha = 0
                    })
                }
            }
        }
        
        if let url = url, let loadURL = URL(string: url) {
            webView.load(URLRequest(url: loadURL))
        }
        
        self.title = headline
    }
    
    deinit {
        self.observation = nil
    }
    
}
