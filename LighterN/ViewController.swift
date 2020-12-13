//
//  ViewController.swift
//  LighterN
//
//  Created by Nick on 12.12.2020.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    var backgroundColor = 0
    var isRealLightOn = false
    let button = UIButton(type: .system)
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @objc func buttonAction(){
        isRealLightOn.toggle()
        if isRealLightOn{
            button.setTitle("Torch Off", for: .normal)
        } else {
            button.setTitle("Torch On", for: .normal)
        }
        updateView()
    }
    
    func createButton(){
        button.frame = CGRect(x: self.view.frame.midX - self.view.frame.midX/2, y: self.view.frame.maxY - self.view.frame.midY/2, width: 200, height: 50)
        button.backgroundColor = .black
        button.setTitle("Torch On", for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tintColor = .white
        
        self.view.addSubview(button)
    }
    
    /// Control the Device Torch Status
    func updateView() {
            let device = AVCaptureDevice.default(for: AVMediaType.video)
            
            if let dev = device, dev.hasTorch {
                do {
                    try dev.lockForConfiguration()
                    dev.torchMode = isRealLightOn ? .on : .off
                    dev.unlockForConfiguration()
                } catch {
                    print(error)
                }
            } else {
                print("Device Has No Torch.")
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
        updateUI()
    }

    fileprivate func updateUI() {
        
        switch backgroundColor {
        case 1:
            view.backgroundColor = .yellow
        case 2:
            view.backgroundColor = .green
        default:
            view.backgroundColor = .red
        }
        backgroundColor += 1
        if backgroundColor == 3{
            backgroundColor = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateUI()
    }
}
