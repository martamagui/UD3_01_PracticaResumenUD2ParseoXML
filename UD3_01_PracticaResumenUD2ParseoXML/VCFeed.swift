//
//  VCFeed.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 15/12/21.
//

import UIKit

class VCFeed:  UITableViewController, XMLParserDelegate {
    
    @IBOutlet var miTabla: UITableView!
    
    var tematica = String()
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
        //Ejecuto todo lo relativo al parseo del XML
        prepararParser()
    }
    
    //Parseo de categorías
    //Preparo el parseo y le asigno el URL
    func prepararParser(){
        //Cambia el String de urlXML a Url y carga la petición en la webView
        guard let url = URL(string: urlXML) else {return}
        guard let parser = XMLParser(contentsOf: url) else { return}
        parser.delegate = self
        parser.parse()
    }
    
    //Inicia los elemntos que van a ser parseados del XML si el nombre del elemento equivale a "Item"
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
    
    //Lee cada elemento del XML y va añadiendo cada caracter a su correspondiente String
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let caracter = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !caracter.isEmpty
        {
            if nombreElemento == "title"
            {
                titulo += caracter
            }
            else if nombreElemento == "link"
            {
                link += caracter
            }
            else if nombreElemento == "description"
            {
                descripcion += caracter
            }
            else if nombreElemento == "category"
            {
                category += caracter
            }
            else if nombreElemento == "pubDate"
            {
                pubDate += caracter
            }
        }
    }
   /*Cuando termina el elemento una vez termina de leer cada item,
     si coincide la categoría con la indicada en la anterior pantalla
     lo añade a la lista de la tabla. Si no, no.
     */
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "item")
        {
            if tematica == "Todas"{
                annadirElemento()
            }
            else if tematica == category
            {
                annadirElemento()
            }
        }
    }
    
    //Función que forma una estructura "item" y lo añade a la lista de items
    func annadirElemento(){
        let arrProvisional = descripcion.components(separatedBy: "\"/>\n    \n                        ")
        descripcion = "\(arrProvisional[1])"
        let arrProvisiona2 = arrProvisional[0].components(separatedBy: "\"")
        print(description)
        img = arrProvisiona2[1]
        print(img)
        
        let datosItem = Item(title: titulo, link: link, descripcion: descripcion, category: category, pubDate: pubDate,img: img)
        itemList.append(datosItem)
    }
    
    // MARK: - Table view data source
    //Indica a la tabla que sólo hay una única sección
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //La tabla tendrá tantos elementos como sea el tamaño de la lista de Items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    // Añade el título de la noticia a la tabla.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = itemList[indexPath.row].title
        return cell
    }
    
    //Segue ejecutada al pulsar sobre un elemento de la lista.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "irADetalle", sender: nil)
    }
    
    /*Al pulsar sobre una de las celdas toma el elemento seleccionado
     y pasa ese item por parámetro a la vista de detalle.
     */
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
