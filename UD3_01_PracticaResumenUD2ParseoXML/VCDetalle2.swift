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
        //Configura el cargar el contenido de la vista.
        configureView()
    }
    
    private func configureView(){
        //Cambia el String recibido por el segue a Url y carga la petición en la webView
        guard let urlRecibida = contenidoWeb else { return }
        guard let url = URL(string: urlRecibida) else {return}
        print(url)
        let request: URLRequest = URLRequest(url: url)
        webview.load(request)
        webview.navigationDelegate = self
    }
    
    //Ejecuta la animación del ActivityIndicatorView
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadAnim.startAnimating()
    }
    //Una vez ha carado el contenido de la web pausa la animación y esconde la ruedecita
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadAnim.stopAnimating()
        loadAnim.hidesWhenStopped = true
    }
    
}
