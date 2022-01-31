//
//  ViewController.swift
//  Milestone Projects 4-6
//
//  Created by Aleksandr Pavlov on 21.01.22.
//

import UIKit

class TableViewController: UITableViewController {

    var shoppingList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(getTask))
        
        //navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self
                                          , action: #selector(shareList))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshList))
        
        navigationItem.leftBarButtonItems = [refreshButton,  shareButton]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func getTask() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default)  { _ in
            guard let answer = ac.textFields?[0].text else { return }
            self.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    @objc func refreshList() {
        shoppingList = []
        tableView.reloadData()
    }
    
    @objc func shareList() {
        
        if shoppingList.isEmpty {
            print("Empty")
            let vcAlert = UIAlertController(title: "List is empty", message: nil, preferredStyle: .alert)
            present(vcAlert, animated: true)
            
            let vcAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            vcAlert.addAction(vcAlertAction)
            
        } else {
            let text = "List to buy:"
            let shareText = shoppingList.joined(separator: "\n")
            let vc = UIActivityViewController(activityItems: [text, shareText], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![0]
            present(vc, animated: true)
        }
        
//        let text1 = "List to buy:"
//        let list = shoppingList.joined(separator: "\n")
//        let vc = UIActivityViewController(activityItems: [text1, list], applicationActivities: [])
//        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![0]
//        present(vc, animated: true)
    }
    
    func submit(_ answer: String) {
        if !answer.isEmpty {
            shoppingList.insert(answer, at: 0)
            
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
}

