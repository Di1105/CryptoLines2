//
//  ViewController.swift
//  CryptoLines
//
//  Created by Dilara Elçioğlu on 24.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel = CryptoListViewModel()
    
    var colorArray = [UIColor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        
        self.colorArray = [
            UIColor(red: 0/255, green: 43/255, blue: 91/255, alpha: 1.0),
            UIColor(red: 43/255, green: 72/255, blue: 101/255, alpha: 1.0),
            UIColor(red: 37/255, green: 109/255, blue: 133/255, alpha: 1.0),
            UIColor(red: 0/255, green: 103/255, blue: 102/255, alpha: 1.0)
        ]
    }
    
    func getData(){
        cryptoListViewModel.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        /*let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrencies(url: url) { cryptos in
            if let  cryptos = cryptos {
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }*/
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.currencyText.text = cryptoViewModel.name
        cell.priceText.text = cryptoViewModel.price
        cell.backgroundColor = self.colorArray[indexPath.row % 4]
        
        return cell
    }
    
}

