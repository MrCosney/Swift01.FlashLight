//
//  ViewController.swift
//  LighterN
//
//  Created by Nick on 12.12.2020.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    var isLightOn = true
    var isRealLightOn = false
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @objc func buttonAction(button: UIButton){
        if isRealLightOn{
            isRealLightOn.toggle()
            button.setTitle("Turn On", for: .normal)
            updateView()
        } else {
            isRealLightOn.toggle()
            button.setTitle("Turn Off", for: .normal)
            updateView()
        }
    }
    
    func createButton(){
        let button = UIButton(type: .system)
        button.frame = CGRect(x: self.view.frame.midX - self.view.frame.midX/2, y: self.view.frame.maxY - self.view.frame.midY/2, width: 200, height: 50)
        button.backgroundColor = .cyan
        button.setTitle("Turn On", for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func updateView() {
            let device = AVCaptureDevice.default(for: AVMediaType.video)
            
            if let dev = device, dev.hasTorch {
                view.backgroundColor = .black
                do {
                    try dev.lockForConfiguration()
                    dev.torchMode = isLightOn ? .on : .off
                    dev.unlockForConfiguration()
                } catch {
                    print(error)
                }
            } else {
                print("No FlashLight")
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
        updateUI()
    }

    fileprivate func updateUI() {
        view.backgroundColor = isLightOn ? .white: .black
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isLightOn.toggle()
        updateUI()
    }
}


