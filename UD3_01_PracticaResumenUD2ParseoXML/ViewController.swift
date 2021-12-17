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
        prepararParser()
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return temas.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tematica = temas[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row:Int, forComponent component: Int) -> String? {
        return temas[row]
    }
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
        if nombreElemento == "item"
        {
            category = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let caracter = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !caracter.isEmpty
        {
            if nombreElemento == "category"{
                category += caracter
            }
        }
    }
   // Cuando termina el elemento
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

