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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
