//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Artsiom Chekh on 20.02.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var questionCount = 0
    var currectAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        button1.layer.borderWidth = 0.3
        button2.layer.borderWidth = 0.3
        button3.layer.borderWidth = 0.3
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        askQuastion(action: nil)
    }
    
    func askQuastion(action: UIAlertAction!) {
        countries.shuffle()
        
        currectAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
                
        title = "\(countries[currectAnswer].uppercased()) \(score)"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(scoreTapped))
        
        questionCount += 1
        
        if questionCount > 10 {
            let finalAC = UIAlertController(title: "Your result:", message: "Final score is \(score).", preferredStyle: .alert)
            finalAC.addAction(UIAlertAction(title: "Restart", style: .default, handler: resetGame))
            present(finalAC, animated: true)
        }
    }
    
    @objc func scoreTapped() {
        let sc = UIAlertController(title: nil, message: "Total score is \(score).", preferredStyle: .alert)
        sc.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(sc, animated: true)
    }
    
    func resetGame(action: UIAlertAction!) {
        score = 0
        questionCount = 0
        askQuastion(action: nil)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == currectAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].capitalized)."
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuastion))
        present(ac, animated: true)
    }
}

