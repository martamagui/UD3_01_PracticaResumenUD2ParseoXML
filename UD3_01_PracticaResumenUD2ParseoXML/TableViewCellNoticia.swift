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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
