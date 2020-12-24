//
//  CurrenciesListVC.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/20/20.
//

import UIKit

class CurrenciesListVC: UIViewController {
    @IBOutlet weak var currenciesTableView:UITableView!
    private let reuseId = "CurrencyCell"
    var vm: CurrenciesVMProtocol?{
        didSet {
            vm?.delegate = self
        }
    }
    let label = UILabel()
    @objc func tapGestureRecognizerHandler(_ sender: UITapGestureRecognizer) {
        //change main currency
        if (vm?.currencies.count ?? 0) > 0{
            if let vc = storyboard?.instantiateViewController(identifier: "SelectMainCurrencyVC") as? SelectMainCurrencyVC{
                vc.delegate = self
                if let currencies = vm?.currencies{
                    vc.currencies = currencies
                }
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = CurrenciesVM()
        vm?.loadCurrencies()
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 40),
            ])
        currenciesTableView.dataSource = self
        currenciesTableView.delegate = self
        currenciesTableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        currenciesTableView.rowHeight = UITableView.automaticDimension
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .medium)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        var c = vm?.selectedCurrency.name ?? " "
        c.removeLast()
        label.text = "\(flag(country: c)) \(vm?.selectedCurrency.name ?? "")"
        label.backgroundColor = .white
        navigationItem.titleView = label
        navigationController?.navigationBar.backgroundColor = .blue
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerHandler(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(touchGesture)
    }

    func showConverterView(currency: Currency){
        if let vc = storyboard?.instantiateViewController(identifier: "ConverterVC") as? ConverterVC{
            vc.currency = currency
            vc.vm = self.vm
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension CurrenciesListVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currency = vm?.currencies[indexPath.row]{
            showConverterView(currency: currency)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CurrenciesListVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.currencies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! CurrencyCell
        if let currency = vm?.currencies[indexPath.row]{
            cell.currencyNameLabel.text = vm?.formattedNameWithFlag(currency: currency)
            cell.currencyValueLabel.text = vm?.formattedNumber(currency: currency)
        }
        return cell
    }
    
}

extension CurrenciesListVC: CurrenciesListVCOutputProtocol{
    func finishLoadingCurrencies(success: Bool) {
        if success{
            currenciesTableView.reloadData()
        }else{       
        }
    }
}

extension CurrenciesListVC: SelectMainCurrencyVCProtocol{
    func selectMainCurrency(currency: Currency) {
        vm?.selectedCurrency = currency
        var ccode = currency.name
        ccode.removeLast()
        label.text = vm?.formattedNameWithFlag(currency: currency)
    }
}

