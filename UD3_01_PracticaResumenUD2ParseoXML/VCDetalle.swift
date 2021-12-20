//
//  VCDetalle.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 15/12/21.
//

import UIKit

class VCDetalle: UIViewController {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var btnCategoria: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnLeerMas: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ivNoticia: UIImageView!
    //Recibe a través del segue el objeto Item del que obtiene los datos para cargarlos en la vista.
    var item : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configura todos los elementos de la vista
        configurarUI()
    }
    //Asigna a cada elemento los datos pasados en el objeto item
    func configurarUI(){
        lblTitulo.text = item?.title
        lblDate.text = item?.pubDate
        btnCategoria.setTitle(item?.category, for: .normal)
        lblDescription.text = item?.descripcion
        let imgUrl: URL = URL(string: item?.img ?? "https://user-images.githubusercontent.com/582516/98960633-6c6a1600-24e3-11eb-89f1-045f55a1e494.png")!
        ivNoticia.load(url: imgUrl)
    }
    //Función por la cual al pinchar sobre el botón de "leer más" pasa  la vista de la web.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irAWeb"
        {
            let vistaWeb = segue.destination as! VCWebView
            print(link)
            vistaWeb.contenidoWeb = item?.link ?? "https://user-images.githubusercontent.com/582516/98960633-6c6a1600-24e3-11eb-89f1-045f55a1e494.png"
        }
    }
    
}
