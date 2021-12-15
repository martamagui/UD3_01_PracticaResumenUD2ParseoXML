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
    var item : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarUI()
    }
    func configurarUI(){
        lblTitulo.text = item?.title
        lblDate.text = item?.pubDate
        btnCategoria.setTitle(item?.category, for: .normal)
        lblDescription.text = item?.descripcion
        print("EEEEEE \(item?.descripcion)")
        
        
        
        
    }
    
}
