//
//  CryptoViewModel.swift
//  CryptoLines
//
//  Created by Dilara Elçioğlu on 24.10.2022.
//

import Foundation

class CryptoListViewModel {
    var cryptoCurrencyList : [CryptoCurrency] = []
}

extension CryptoListViewModel {
    
    func numberOfRowsInSection () -> Int{
        return cryptoCurrencyList.count
    }
    
    func cryptoAtIndex (_ index: Int) -> CryptoViewModel {
        let crypto = self.cryptoCurrencyList[index]
        return CryptoViewModel(cryptoCurrency: crypto)
    }
    
    func getData(completionHandler : @escaping () -> () ){
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrencies(url: url) { [weak self] cryptos in
            guard let self = self else {
                return
            }
            if let  cryptos = cryptos {
                self.cryptoCurrencyList = cryptos
                completionHandler()
            }
        }
    }
}

struct CryptoViewModel {
    let cryptoCurrency : CryptoCurrency
    var name : String{
        return self.cryptoCurrency.currency
    }
    
    var price : String{
        return self.cryptoCurrency.price
    }
}

