//
//  ViewController.swift
//  ChalangeProject
//
//  Created by Aleksandr Pavlov on 14.12.21.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.description.hasSuffix("3x.png") {
                //load picture
                pictures.append(item)
                pictures.sort()
                
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row].replacingOccurrences(of: "@3x.png", with: "").uppercased()
        cell.imageView?.image = UIImage(named: pictures[indexPath.row])
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Flags") as? FlagsViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "This is \(pictures[indexPath.row].replacingOccurrences(of: "@3x.png", with: "").uppercased()) flag."
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

