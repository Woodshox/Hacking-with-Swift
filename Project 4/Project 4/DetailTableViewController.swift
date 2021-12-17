//
//  DetailTableViewController.swift
//  Project 4
//
//  Created by Aleksandr Pavlov on 17.12.21.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var websites = ["apple.com", "hackingwithswift.com"]
    var pictures = [String]()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.description.hasSuffix(".png") {
                    //load picture
                    pictures.append(item)
                    pictures.sort()
                    
                }
            }

            title = "Easy Browser"
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return websites.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
            cell.textLabel?.text = websites[indexPath.row]
            cell.imageView?.image = UIImage(named: pictures[indexPath.row])
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let webViewController = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController {
                webViewController.webSiteToLoad = websites[indexPath.row]
                navigationController?.pushViewController(webViewController, animated: true)
            }
        }

    
}
