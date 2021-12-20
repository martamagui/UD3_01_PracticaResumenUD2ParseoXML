//
//  TableViewCellNoticia.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 17/12/21.
//

import UIKit

class TableViewCellNoticia: UITableViewCell {
    @IBOutlet weak var imagenNoticia: UIImageView!
    @IBOutlet weak var tituloNoticia: UILabel!
    @IBOutlet weak var descripcionNoticia: UILabel!
    
    /*
     Inicializa la celda de la vista de "resumen" y declara sus elementos para poner acceder a ellos al crear la tabla.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        degradado()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func degradado(){
        let gradient = CAGradientLayer()
        gradient.frame = imagenNoticia.bounds
        let startColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0).cgColor
        let colorMedio = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3).cgColor
        let colorMedio2 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7).cgColor
        let endColor = UIColor(ciColor: .white).cgColor
        gradient.colors = [startColor, colorMedio,colorMedio2,endColor]
        imagenNoticia.layer.insertSublayer(gradient, at: 0)
    }

}
