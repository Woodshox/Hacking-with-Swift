//
//  DetailViewController.swift
//  Project1
//
//  Created by Woodshox on 08.12.21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedPictureNumber = 0
    var  totalPictures = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "This image is \(selectedPictureNumber) of \(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(suggest))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No Image Found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage as Any], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true )
    }
    
    //    @objc func suggest() {
    //        let shareLink = "TRY https://github.com"
    //        let vc = UIActivityViewController(activityItems: [shareLink], applicationActivities: [])
    //        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    //        present(vc, animated: true)
    //    }
    
}
