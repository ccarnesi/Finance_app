//
//  TransactionsViewController.swift
//  Finance_app
//
//  Created by Chris Carnesi on 3/29/19.
//  Copyright © 2019 Carnesi. All rights reserved.
//

import UIKit


class TransactionsViewController: UIViewController{
    var transaction: [Transactions] = []
    let transactionApi: TransactionDataSource = TransactionDataSource()
    
    

    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        transactionApi.getTransData { (TransactionResults) in
            self.transaction = TransactionResults.results
            DispatchQueue.main.async {
               self.TableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
   
    
    
    
}
    
    
    
    
    
extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
        cell.textLabel?.text = transaction[indexPath.row].category
       
        return cell
    }

}
