//
//  VCDetalle2.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 17/12/21.
//

import UIKit
import WebKit

class VCDetalle2: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var loadAnim: UIActivityIndicatorView!
    var contenidoWeb: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView(){
        guard let urlRecibida = contenidoWeb else { return }
        guard let url = URL(string: urlRecibida) else {return}
        print(url)
        let request: URLRequest = URLRequest(url: url)
        webview.load(request)
        webview.navigationDelegate = self
    }
    
    //métodos de navigation delegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadAnim.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadAnim.stopAnimating()
        loadAnim.hidesWhenStopped = true
    }
    
}
