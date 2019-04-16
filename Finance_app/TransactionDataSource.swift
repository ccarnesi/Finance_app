//
//  transactionsDataSource.swift
//  Finance_app
//
//  Created by Chris Carnesi on 4/15/19.
//  Copyright © 2019 Carnesi. All rights reserved.
//

import Foundation
struct TransactionResults:Codable {
    let results: [Transactions]
}
struct Transactions: Codable {
    let category: String
    let _id: String
    let quantity: String
    let name: String
    let type: String
    let date: String
}

struct TransactionDataSource {
    let urlString: String = "https://protected-shelf-66694.herokuapp.com/transactions"
    
    func getTransData(completion: @escaping (TransactionResults)->()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let jsonData = data{
                do{
                    let transData = try JSONDecoder().decode(TransactionResults.self, from: jsonData)
                    completion(transData)
                }catch{
                    print("hi")
                    print(error)
                }
            }
            }.resume()
    }
}
