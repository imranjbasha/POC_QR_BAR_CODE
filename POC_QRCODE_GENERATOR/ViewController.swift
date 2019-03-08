//
//  ViewController.swift
//  POC_QRCODE_GENERATOR
//
//  Created by Mitosis on 07/03/19.
//  Copyright © 2019 Mitosis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageQrCode: UIImageView!
    @IBOutlet weak var inputText: UITextField!

    @IBAction func saveQR(_ sender: Any) {
        
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        
    }
    @IBAction func generateQR(_ sender: Any) {
        
        if let enteredText = inputText.text {
            let data = enteredText.data(using: .ascii, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "InputMessage")
            
            let ciImage = filter?.outputImage
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let transFormImage = ciImage?.transformed(by: transform)
            
            let image = UIImage(ciImage: transFormImage!)
            self.imageQrCode.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    

}

