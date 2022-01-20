//
//  ViewController.swift
//  Project 2
//
//  Created by Woodshox on 09.12.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScoreBarItem))
        
        countries += ["estonia", "france","germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "us", "uk"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
         
    }
    
    func askQuestion (action: UIAlertAction! = nil) {
        countries.shuffle()
        
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "Your score is \(score)! Choose \(countries[correctAnswer].uppercased()) flag"
        
        
    }
    
    func startNewGame(action: UIAlertAction) {
        score = 0
        
        totalAnswer = 0
        askQuestion()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            totalAnswer += 1
        } else {
            title = "Wrong! Thats the flag of \(countries[sender.tag].uppercased())"
            score -= 1
            totalAnswer += 1
        }
         
        // прекратить вызывать этот алерт когда totalAnswer == 10, и вызвать алерт END с итоговым score  и началом новой игры
        if totalAnswer < 10 {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let finalAlertController = UIAlertController(title: "Game over!", message: "Your score is \(score).", preferredStyle: .alert)
            finalAlertController.addAction(UIAlertAction(title: "Start new game!", style: .destructive, handler: startNewGame))
            present(finalAlertController, animated: true)
            
        }

        
        
        
        
    }
    
    @objc func showScoreBarItem() {
        let scoreAlert = UIAlertController(title: "Hello man", message: "Ur score is \(score)", preferredStyle: .alert)
        scoreAlert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(scoreAlert, animated: true)
    }
}

