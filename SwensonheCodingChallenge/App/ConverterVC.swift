//
//  ConverterVC.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/21/20.
//

import UIKit

class ConverterVC: UIViewController {
    var currency: Currency?
    @IBOutlet weak var mainCurrencyLabel:UILabel!
    @IBOutlet weak var secondCurrencyLabel:UILabel!
    @IBOutlet weak var mainCurrencyText:UITextField!
    @IBOutlet weak var secondCurrencyText:UITextField!
    var vm: CurrenciesVMProtocol?{
        didSet {
            vm?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let curr = currency {
            var ccode = curr.name
            ccode.removeLast()
            secondCurrencyLabel.text = "\(flag(country: ccode)) \(curr.name)"
        }
        mainCurrencyLabel.text = vm?.selectedCurrency.name
        textChanged()
        mainCurrencyText.becomeFirstResponder()
    }
    @IBAction func textChanged(){
        let value = Double(mainCurrencyText.text!) ?? 0.0
        if let curr = currency, let result = vm?.convertCurrency(value: value, currency: curr) {
            secondCurrencyText.text = String(format: "%\(0.5)f", result)
        }
    }
}

extension ConverterVC: CurrenciesListVCOutputProtocol{
    func finishLoadingCurrencies(success: Bool) {
        if success{
        }else{
        }
    }
}
