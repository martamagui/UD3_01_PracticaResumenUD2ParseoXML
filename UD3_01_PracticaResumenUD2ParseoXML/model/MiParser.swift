//
//  MiParser.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 17/12/21.
//

import UIKit

class MiParser: NSObject, XMLParserDelegate {
    
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
    func iniciarParseo(){
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
}
