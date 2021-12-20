//
//  VCDetalle.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 15/12/21.
//

import UIKit

class VCDetalle: UIViewController {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblCategoria: UILabel!
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
        lblCategoria.text = item?.category
        lblDescription.text = item?.descripcion
        let imgUrl: URL = URL(string: item?.img ?? "https://user-images.githubusercontent.com/582516/98960633-6c6a1600-24e3-11eb-89f1-045f55a1e494.png")!
        ivNoticia.load(url: imgUrl)
        degradado()
    }
    
    //Crea un degradado de blanco a transparente cobre la imagen de la noticia.
    func degradado(){
        let gradient = CAGradientLayer()
        gradient.frame = ivNoticia.bounds
        let startColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0).cgColor
        let colorMedio = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3).cgColor
        let colorMedio2 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7).cgColor
        let endColor = UIColor(ciColor: .white).cgColor
        gradient.colors = [startColor, colorMedio,colorMedio2,endColor]
        ivNoticia.layer.insertSublayer(gradient, at: 0)
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
