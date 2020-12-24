//
//  SelectMainCurrencyVC.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/21/20.
//

import UIKit
protocol SelectMainCurrencyVCProtocol: class{
    func selectMainCurrency(currency: Currency)
}
class SelectMainCurrencyVC: UIViewController {
    var delegate:SelectMainCurrencyVCProtocol?
    var APIDataManager: APIDataManagerInputProtocol?
    @IBOutlet weak var currenciesTableView:UITableView!
    private let reuseId = "CurrencyCell"
    var currencies:[Currency] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        currenciesTableView.dataSource = self
        currenciesTableView.delegate = self
        currenciesTableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        currenciesTableView.rowHeight = UITableView.automaticDimension
        APIDataManager = APIManager()
    }
}


extension SelectMainCurrencyVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectMainCurrency(currency: currencies[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SelectMainCurrencyVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! CurrencyCell
        let currency = currencies[indexPath.row]
        if currency.name.count > 0{
            var ccode = currency.name
            ccode.removeLast()
            cell.currencyNameLabel.text = flag(country: ccode) + "  " + currency.name
            cell.currencyValueLabel.text = "\(currency.ratio)"
        }
        return cell
    }
    
}

