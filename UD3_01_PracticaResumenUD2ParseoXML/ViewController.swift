//
//  ViewController.swift
//  UD3_01_PracticaResumenUD2ParseoXML
//
//  Created by Marta Molina Aguilera on 15/12/21.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, XMLParserDelegate{
    @IBOutlet weak var pickerTema: UIPickerView!
    
    var parser: XMLParser = XMLParser()
    let urlXML="https://www.muyinteresante.es/rss"

    var temas = ["Todas"]
    var category = String()
    var tematica : String = "Todas"
    var nombreElemento = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Ejecuto todo lo relativo al parseo del XML
        prepararParser()
    }
    //Solo hay una columna en el picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //Será tan grande, cómo elementos haya en el Array de categorías.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temas.count
    }
    //Añade al pickerView el string indicado por la row de la lista de temas/categorías
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tematica = temas[row]
    }
    //Retorna el contenido del String del array
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int, forComponent component: Int) -> String? {
        return temas[row]
    }
    /*Si una vez elegida la categoría de las noticias el segue del botón de equivale al cambio de pantallas con el feed.
    entonces establece el filtro de la temática.*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aFeed" {
            let controlador =  segue.destination as! VCFeed
            controlador.tematica = tematica
        }
    }
    
    //Parseo de categorías
    //Preparo el parseo y le asigno el URL
    func prepararParser(){
        guard let url = URL(string: urlXML) else {return}
        guard let parser = XMLParser(contentsOf: url) else { return}
        parser.delegate = self
        parser.parse()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        nombreElemento = elementName
        //Si el elemento actual equivale e un item, cojo únicamente la category
        if nombreElemento == "item"
        {
            category = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //Remuevo los espaios en blanco y los saltos de línea
        let caracter = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        //Si el caracter actual no está vacío y el nombre del elemento equivale a categoría, lo añado a mi String Categoría
        if (!caracter.isEmpty && nombreElemento == "category")
        {
            category += caracter
        }
    }
    
   // Cuando termina el elemento lo añado a la lista de categorías que se mostrará en el picker view.
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"
        {
            if (!temas.contains(category))
            {
                temas.append(category)
                category = ""
                pickerTema.reloadAllComponents()
            }
            
        }
    }
}

