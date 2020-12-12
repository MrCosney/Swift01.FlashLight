//
//  ViewController.swift
//  LighterN
//
//  Created by Nick on 12.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var isLightOn: Bool = true
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }


    fileprivate func updateUI() {
        view.backgroundColor = isLightOn ? .white: .black
    }
    
    @IBAction func ButtonPressed() {
        isLightOn.toggle()
        updateUI()
    }
}

