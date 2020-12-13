//
//  ViewController.swift
//  LighterN
//
//  Created by Nick on 12.12.2020.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    
    private var screenColorIndex = 0
    private var isRealLightOn = false
    private let button = UIButton(type: .system)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
        updateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateUI()
    }
    
    /// Turn On/Off the Device Torch and Switch the Button Title.
    @objc private func buttonAction() {
        isRealLightOn.toggle()
        setupRealLight()
        
        var title = ""
        title = isRealLightOn ? "Torch Off": "Torch On"
        button.setTitle(title, for: .normal)
    }
    
    /// Create Button for control the Device Torch
    private func createButton() {
        let width: CGFloat = 200
        let height: CGFloat = 50
        
        button.frame = CGRect(x: self.view.frame.midX - width / 2,
                              y: self.view.frame.maxY - self.view.frame.midY/2,
                              width: width,
                              height: height)
        button.backgroundColor = .black
        button.setTitle("Torch On", for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(nil, action: #selector(buttonAction), for: .touchUpInside)
        button.tintColor = .white
        
        self.view.addSubview(button)
    }
    
    /// Control the Device Torch Status.
    private func setupRealLight() {
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
    
    /// Update the Screen Color
    fileprivate func updateUI() {
        
        switch screenColorIndex {
        case 0: view.backgroundColor = .red
        case 1: view.backgroundColor = .yellow
        case 2: view.backgroundColor = .green
        default:
            break
        }
        
        screenColorIndex += 1
        if screenColorIndex == 3{
            screenColorIndex = 0
        }
    }
}
