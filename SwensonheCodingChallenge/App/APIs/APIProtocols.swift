//
//  APIProtocols.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/21/20.
//

protocol APIDataManagerInputProtocol: class
{
    func fetchCurrencyFromServerWithData(_ baseCurrencyCode: String, completion: (([Currency]) -> Void)!, failed:((AnyObject) -> Void)!)
}
