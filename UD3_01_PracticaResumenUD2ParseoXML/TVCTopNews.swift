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
        
        guard let url = URL(string: urlXML) else {return}
        guard let parser = XMLParser(contentsOf: url) else { return}
        parser.delegate = self
        parser.parse()
        
    }

    // Configuración de la tabla
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(itemList.count)
        return itemList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let celda = miTabla.dequeueReusableCell(withIdentifier: "Celda") as! TableViewCellNoticia
        //cell.textLabel?.text = itemList[indexPath.row].title
        //let urlImg = URL(string: itemList[indexPath.row].link ?? "https://user-images.githubusercontent.com/582516/98960633-6c6a1600-24e3-11eb-89f1-045f55a1e494.png")!
        
        //celda.imagenNoticia.load(url: urlImg )
        celda.descripcionNoticia.text = itemList[indexPath.row].descripcion
        celda.tituloNoticia.text = itemList[indexPath.row].title
        return celda
    }

    
    
    
    //Parseo de categorías
   
    
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
        if (elementName == "item")
        {
                annadirElemento()
        }
    }
    
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
    

}
