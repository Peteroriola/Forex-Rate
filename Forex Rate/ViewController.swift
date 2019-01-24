//
//  ViewController.swift
//  Forex Rate
//
//  Created by Peter Oriola on 21/01/2019.
//  Copyright © 2019 Peter Oriola. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 
    
    var selectedCountryName = ""
    var didSelectCountryCurrency = ""
    var baseApiURL = ""
    
    var historyCurrency = ""
    var historyApiURL = ""

    let countryCurrency = ["AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN", "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BSD", "BTC", "BTN", "BWP", "BYN", "BYR", "BZD", "CAD", "CDF", "CHF", "CLF", "CLP", "CNY", "COP", "CRC", "CUC", "CUP", "CVE", "CZK", "DJF", "DKK", "DOP", "DZD", "EGP", "ERN", "ETB", "EUR", "FJD", "FKP", "GBP", "GEL", "GGP", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "IMP", "INR", "IQD", "IRR", "ISK", "JEP", "JMD", "JOD", "JPY", "KES", "KGS", "KHR", "KMF", "KPW", "KRW", "KWD", "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LTL", "LVL", "LYD", "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRO", "MUR", "MVR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLL", "SOS", "SRD", "STD", "SVC", "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TWD", "TZS", "UAH", "UGX", "USD", "UYU", "UZS", "VEF", "VND", "VUV", "WST", "XAF", "XAG", "XAU", "XCD", "XDR", "XOF", "XPF", "YER", "ZAR", "ZMK", "ZMW", "ZWL"]
    let countryName = ["United Arab Emirates Dirham", "Afghan Afghani", "Albanian Lek", "Armenian Dram", "Netherlands Antillean Guilder", "Angolan Kwanza", "Argentine Peso", "Australian Dollar", "Aruban Florin", "Azerbaijani Manat", "Bosnia-Herzegovina Convertible Mark", "Barbadian Dollar", "Bangladeshi Taka", "Bulgarian Lev", "Bahraini Dinar", "Burundian Franc", "Bermudan Dollar", "Brunei Dollar", "Bolivian Boliviano", "Brazilian Real", "Bahamian Dollar", "Bitcoin", "Bhutanese Ngultrum", "Botswanan Pula", "New Belarusian Ruble", "Belarusian Ruble", "Belize Dollar", "Canadian Dollar", "Congolese Franc", "Swiss Franc", "Chilean Unit of Account (UF)", "Chilean Peso", "Chinese Yuan", "Colombian Peso", "Costa Rican Colón", "Cuban Convertible Peso", "Cuban Peso", "Cape Verdean Escudo", "Czech Republic Koruna", "Djiboutian Franc", "Danish Krone", "Dominican Peso", "Algerian Dinar", "Egyptian Pound", "Eritrean Nakfa", "Ethiopian Birr", "Euro", "Fijian Dollar", "Falkland Islands Pound", "British Pound Sterling", "Georgian Lari", "Guernsey Pound", "Ghanaian Cedi", "Gibraltar Pound", "Gambian Dalasi", "Guinean Franc", "Guatemalan Quetzal", "Guyanaese Dollar", "Hong Kong Dollar", "Honduran Lempira", "Croatian Kuna", "Haitian Gourde", "Hungarian Forint", "Indonesian Rupiah", "Israeli New Sheqel", "Manx pound", "Indian Rupee", "Iraqi Dinar", "Iranian Rial", "Icelandic Króna", "Jersey Pound", "Jamaican Dollar", "Jordanian Dinar", "Japanese Yen", "Kenyan Shilling", "Kyrgystani Som", "Cambodian Riel", "Comorian Franc", "North Korean Won", "South Korean Won", "Kuwaiti Dinar", "Cayman Islands Dollar", "Kazakhstani Tenge", "Laotian Kip", "Lebanese Pound", "Sri Lankan Rupee", "Liberian Dollar", "Lesotho Loti", "Lithuanian Litas", "Latvian Lats", "Libyan Dinar", "Moroccan Dirham", "Moldovan Leu", "Malagasy Ariary", "Macedonian Denar", "Myanma Kyat", "Mongolian Tugrik", "Macanese Pataca", "Mauritanian Ouguiya", "Mauritian Rupee", "Maldivian Rufiyaa", "Malawian Kwacha", "Mexican Peso", "Malaysian Ringgit", "Mozambican Metical", "Namibian Dollar", "Nigerian Naira", "Nicaraguan Córdoba", "Norwegian Krone", "Nepalese Rupee", "New Zealand Dollar", "Omani Rial", "Panamanian Balboa", "Peruvian Nuevo Sol", "Papua New Guinean Kina", "Philippine Peso", "Pakistani Rupee", "Polish Zloty", "Paraguayan Guarani", "Qatari Rial", "Romanian Leu", "Serbian Dinar", "Russian Ruble", "Rwandan Franc", "Saudi Riyal", "Solomon Islands Dollar", "Seychellois Rupee", "Sudanese Pound", "Swedish Krona", "Singapore Dollar", "Saint Helena Pound", "Sierra Leonean Leone", "Somali Shilling", "Surinamese Dollar", "São Tomé and Príncipe Dobra", "Salvadoran Colón", "Syrian Pound", "Swazi Lilangeni", "Thai Baht", "Tajikistani Somoni", "Turkmenistani Manat", "Tunisian Dinar", "Tongan Paʻanga", "Turkish Lira", "Trinidad and Tobago Dollar", "New Taiwan Dollar", "Tanzanian Shilling", "Ukrainian Hryvnia", "Ugandan Shilling", "United States Dollar", "Uruguayan Peso", "Uzbekistan Som", "Venezuelan Bolívar Fuerte", "Vietnamese Dong", "Vanuatu Vatu", "Samoan Tala", "CFA Franc BEAC", "Silver (troy ounce)", "Gold (troy ounce)", "East Caribbean Dollar", "Special Drawing Rights", "CFA Franc BCEAO", "CFP Franc", "Yemeni Rial", "South African Rand", "Zambian Kwacha (pre-2013)", "Zambian Kwacha", "Zimbabwean Dollar"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        showDatePicker()
    }


    @IBOutlet weak var chosenCountrylabel: UILabel!
    @IBOutlet weak var liveCurrencyLabel: UILabel!
    @IBOutlet weak var historicalCurrencyLabel: UILabel!
   
    @IBOutlet weak var currencyPicker: UIPickerView!

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
       
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
        
    historyCurrency = dateFormatter.string(from: sender.date)
        print(historyCurrency)
        
    }
    
    
    
    @IBOutlet weak var chosenCountryOutputTextField: UITextField!

   
    func showDatePicker() {
        datePicker.datePickerMode = .date
    }
    
    
    
    
    //MARK:- Initialize Picker Function
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
  
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryCurrency.count
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryCurrency[row]
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      selectedCountryName = countryName[row]
       didSelectCountryCurrency = countryCurrency[row]
        
        print(didSelectCountryCurrency)
   
        chosenCountrylabel.text = selectedCountryName
        
        baseApiURL = "http://apilayer.net/api/live?access_key=9ff6551c664d3f2870b1eaf2e47fce5f&currencies=\(didSelectCountryCurrency)"
        
        historyApiURL = "http://apilayer.net/api/historical?access_key=9ff6551c664d3f2870b1eaf2e47fce5f&currencies=\(didSelectCountryCurrency)&date=\(historyCurrency)"
        
        print(baseApiURL)
        print(historyApiURL)
        
        getCurrencyData(url: baseApiURL)
        getHistoryCurrencyData(url: historyApiURL)
       
    }

    
    //MARK: - Networking Codes
    func getCurrencyData(url: String) {
        Alamofire.request(url, method: .get)
            .responseJSON { respose in
                if respose.result.isSuccess {
                
                print("Got the currency live rates")
                
                    let currencyJSON : JSON = JSON(respose.result.value!)
                    
                   
                    
                    self.updateLiveCurrency(json: currencyJSON)
                } else {
                    
                    
                    
                    self.liveCurrencyLabel.text = "Connection Issues"
                }
        }
    }
    
    
    
    func getHistoryCurrencyData(url: String) {
        Alamofire.request(url, method: .get)
            .responseJSON { respose in
                if respose.result.isSuccess {
                    
                    print("Got the currency history rates")
                    
                    let currencyJSON : JSON = JSON(respose.result.value!)
                    
                    
                    
                    self.updateHistoryCurrency(json: currencyJSON)
                } else {
                    
                    
                    
                    self.historicalCurrencyLabel.text = "Connection Issues"
                }
        }
    }
    //MARK: - JSON PARSING
    
    func updateLiveCurrency(json: JSON) {
    
        
        if let data:[String: JSON] = json["quotes"].dictionaryValue {

            for item in data {
                print(item.value)
                
                  liveCurrencyLabel.text = "\(item.value)"
                
            }           
          
        }
        
        else {
            liveCurrencyLabel.text = "Price Unavaliable"
        }
     
        
    }
    
    func updateHistoryCurrency(json: JSON) {
        
        if let data:[String: JSON] = json["quotes"].dictionaryValue {
            
            for item in data {
                print(item.value)
                
                historicalCurrencyLabel.text = "\(item.value)"
                
            }
            
        }
            
        else {
            historicalCurrencyLabel.text = "Price Unavaliable"
        }    }
    
}


