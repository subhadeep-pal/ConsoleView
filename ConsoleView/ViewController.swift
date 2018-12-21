//
//  ViewController.swift
//  ConsoleView
//
//  Created by Subhadeep Pal on 21/12/18.
//  Copyright © 2018 Subhadeep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var console: ConsoleView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        console.log(message: "Hello world", type: .debug)
        console.log(message: "Hello world error", type: .error)
        console.log(message: "Hello world verbose", type: .verbose)
        console.log(message: "Hello world warning", type: .warning)
    }

    @IBAction func addLogTapped(_ sender: Any) {
        let length = arc4random_uniform(50) + 10
        let message = randomString(length: Int(length))
        let remainder = length % 4
        console.log(message: message, type: LogType(rawValue: Int(remainder))!)
    }

    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }

}

