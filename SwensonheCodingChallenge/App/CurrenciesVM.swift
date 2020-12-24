//
//  CurrenciesVM.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/22/20.
//
import Foundation
protocol CurrenciesVMProtocol {
    func loadCurrencies()
    func convertCurrency(value: Double, currency: Currency)->Double
    func formattedNameWithFlag(currency: Currency)->String
    func formattedNumber(currency: Currency)->String
    var currencies:[Currency] {get set}
    var masterCurrencies:[Currency] {get set}
    var APIDataManager: APIDataManagerInputProtocol? { get set }
    var selectedCurrency:Currency { get set }
    var delegate: CurrenciesListVCOutputProtocol? { get set }
}

class CurrenciesVM: CurrenciesVMProtocol {
    func formattedNameWithFlag(currency: Currency)->String{
        var ccode = currency.name
        ccode.removeLast()
        return ccode.flag() + "  " + currency.name
    }
    func formattedNumber(currency: Currency)->String{
        return String(format: "%\(0.5)f", currency.ratio)
    }
    var APIDataManager: APIDataManagerInputProtocol? = APIManager()
    var currencies: [Currency] = []
    var masterCurrencies:[Currency] = [] {
        didSet{
            currencies = masterCurrencies
        }
    }
    var selectedCurrency:Currency = Currency(name: "EUR", ratio: 1.0){
        didSet{
          //selected currency changed ---> update to new rates
            var newCurrencies:[Currency] = []
            masterCurrencies.forEach { (currency) in
                newCurrencies.append(Currency(name: currency.name, ratio:  currency.ratio / selectedCurrency.ratio))
            }
            currencies = newCurrencies
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.finishLoadingCurrencies(success: true)
            }
        }
    }
    var delegate: CurrenciesListVCOutputProtocol?
    func convertCurrency(value: Double, currency: Currency)->Double{
        return currency.ratio*value
    }
    func loadCurrencies() {
        self.APIDataManager?.fetchCurrencyFromServerWithData("EGP",
                                                             completion:
                                                                {[weak self] response in
                                                                    self?.masterCurrencies = response.sorted(by: { (a, b) -> Bool in
                                                                        a.name < b.name
                                                                    })
                                                                    self?.delegate?.finishLoadingCurrencies(success: true)
                                                                },failed: {[weak self] error in                                        self?.delegate?.finishLoadingCurrencies(success: false)
                                                                    
                                                                    print(error)
                                                                })
    }
}

protocol CurrenciesListVCOutputProtocol{
    func finishLoadingCurrencies(success: Bool)
}
