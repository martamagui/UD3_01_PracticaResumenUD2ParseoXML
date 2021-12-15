//
//  VCFeed.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 15/12/21.
//

import UIKit

class VCFeed: UITableViewController,XMLParserDelegate{
    @IBOutlet var miTabla: UITableView!
    
    var post = [Item]()
    var titulo = String()
    var link = String()
    var nombreElemento = String()
    
    var parser: XMLParser = XMLParser()
    
    let urlXML="https://www.muyinteresante.es/rss"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url= URL(string: urlXML) else {return}
        guard let parser = XMLParser(contentsOf: url) else { return}
        parser.delegate = self
        parser.parse()
        
    }
    
   
   

}
