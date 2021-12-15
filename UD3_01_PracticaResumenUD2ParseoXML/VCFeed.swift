//
//  VCFeed.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 15/12/21.
//

import UIKit

class VCFeed:  UITableViewController, XMLParserDelegate {
   
    @IBOutlet var miTabla: UITableView!
    
    var itemList = [Item]()
    var titulo = String()
    var link = String()
    var nombreElemento = String()
    var descripcion = String()
    var category = String()
    var pubDate =  String()
    var img = String()
    var parser: XMLParser = XMLParser()
   
    
    let urlXML="https://www.muyinteresante.es/rss"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: urlXML) else {return}
        guard let parser = XMLParser(contentsOf: url) else { return}
        parser.delegate = self
        parser.parse()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        nombreElemento = elementName
        if nombreElemento == "item"
        {
            titulo = String()
            link = String()
            descripcion = String()
            category = String()
            pubDate = String()
            img = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let caracter = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !caracter.isEmpty
        {
            if nombreElemento == "title"
            {
                titulo += caracter
            }else if nombreElemento == "link"{
                link += caracter
            }else if nombreElemento == "description"{
                descripcion += caracter
            }else if nombreElemento == "category"{
                category += caracter
            }else if nombreElemento == "pubDate"{
                pubDate += caracter
            }
        }
    }
   // Cuando termina el elemento
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"
        {
            print(descripcion)
            let datosItem = Item(title: titulo, link: link, descripcion: descripcion, category: category, pubDate: pubDate)
            print(titulo)
            itemList.append(datosItem)
        }
    }
   
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = itemList[indexPath.row].title
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "irADetalle", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irADetalle"
        {
            guard let celdaSeleccionada = miTabla.indexPathForSelectedRow?.row else {return}
            let itemSeleccionado = itemList[celdaSeleccionada]
            let vistaDetalle = segue.destination as! VCDetalle
            print(link)
            vistaDetalle.item = itemSeleccionado
        }
    }
    
}
