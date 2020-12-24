//
//  APIManager.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/21/20.
//

import Foundation

class APIManager: APIDataManagerInputProtocol
{
    init() {}
    func fetchCurrencyFromServerWithData(_ baseCurrencyCode: String, completion: (([Currency]) -> Void)!, failed:((AnyObject) -> Void)!) {
        URLSession.init(configuration: .default).dataTask(with: URL.init(string: "http://data.fixer.io/api/latest?access_key=e32d14bd120f07c935fcbcec75fceced&cbase=\(baseCurrencyCode)")!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {failed?(error as AnyObject)}
            } else {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    var array:[Currency] = []
                    if let currenciesArray = jsonObject["rates"] as? [String:Double]{
                        currenciesArray.keys.forEach { (key) in
                            if let double = currenciesArray[key]{
                                array.append(Currency(name: key, ratio: double))
                            }
                        }
                        DispatchQueue.main.async {completion?(array)}
                    }
                } catch let myJSONError {
                    DispatchQueue.main.async {failed?(myJSONError as AnyObject)}
                }
            }
        }.resume()
    }
}
