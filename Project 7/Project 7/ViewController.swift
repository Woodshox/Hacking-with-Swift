//
//  ViewController.swift
//  Project 7
//
//  Created by Aleksandr Pavlov on 31.01.22.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var savePetitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filtredPetition))
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "http://hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "http://hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                
            } else {
                showError()
            }
        } else {
            showError()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "Try one more time", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
            savePetitions = petitions
        }
    }
    
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "The data comes from the 'We The People API of the Whitehouse.'", message: "", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    
    @objc func filtredPetition() {
        let ac = UIAlertController(title: "Search", message: "", preferredStyle: .alert)
        ac.addTextField()
        let findAction = UIAlertAction(title: "Find", style: .default) { _ in
            guard let text = ac.textFields?[0].text else { return }
            self.findPetitions(text)
        }
        
        let resetAction = UIAlertAction(title: "Reset all", style: .destructive) { _ in
            self.resetButton()
        }

        ac.addAction(findAction)
        ac.addAction(resetAction)
        present(ac, animated: true)
    }
    
    
    func findPetitions (_ text: String) {
        filteredPetitions.removeAll()
        for petition in savePetitions {
            if petition.body.lowercased().contains(text.lowercased()) {
                filteredPetitions.append(petition)
            }
        }
        if filteredPetitions.isEmpty { return }
        petitions = filteredPetitions
        tableView.reloadData()
    }
    
    func resetButton() {
        petitions = savePetitions
        tableView.reloadData()
    }
   
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.body
        cell.detailTextLabel?.text = petition.title 
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

