//
//  TVCTopNews.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 17/12/21.
//

import UIKit

class TVCTopNews: UITableViewController,XMLParserDelegate {
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
        //Ejecuta todo lo que tiene que ver con el parseo.
        prepararParser()
    }

    
    // MARK: - Table view data source
    // Configuración de la tabla
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Retorna 10 como entero
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(itemList.count)
        return 10
    }
    
    //Crea una celda TableViewCellNoticia y le asigna la descripción, titulo e imagen, pera a continucación retornar el objeto.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let celda = miTabla.dequeueReusableCell(withIdentifier: "Celda") as! TableViewCellNoticia
        celda.descripcionNoticia.text = itemList[indexPath.row].descripcion
        celda.tituloNoticia.text = itemList[indexPath.row].title
        let urlImg = URL(string: itemList[indexPath.row].img ?? "https://user-images.githubusercontent.com/582516/98960633-6c6a1600-24e3-11eb-89f1-045f55a1e494.png")!
        celda.imagenNoticia.load(url: urlImg)
        return celda
    }
    
  
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
        if elementName == "item"
        {
            annadirElemento()
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
    //Segue ejecutada al pulsar sobre un elemento de la lista.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "irADetalle2", sender: nil)
    }
    
    /*Al pulsar sobre una de las celdas toma el elemento seleccionado
     y pasa ese item por parámetro a la vista de detalle.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irADetalle2"
        {
            guard let celdaSeleccionada = miTabla.indexPathForSelectedRow?.row else {return}
            let itemSeleccionado = itemList[celdaSeleccionada]
            let vistaDetalle = segue.destination as! VCDetalle2
            vistaDetalle.contenidoWeb = itemList[celdaSeleccionada].link
        }
    }

}
