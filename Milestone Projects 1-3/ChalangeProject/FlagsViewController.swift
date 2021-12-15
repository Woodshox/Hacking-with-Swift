//
//  FlagsViewController.swift
//  ChalangeProject
//
//  Created by Aleksandr Pavlov on 14.12.21.
//

import UIKit

class FlagsViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
    }

    @objc func shareTapped() {
        guard let image = imageView.image else {
            print("Error")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage?.replacingOccurrences(of: "@3x.png", with: "").uppercased() as Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
