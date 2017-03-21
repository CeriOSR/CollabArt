//
//  ViewController.swift
//  ColLabs-CeriOS
//
//  Created by Rey Cerio on 2017-03-20.
//  Copyright © 2017 CeriOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customTriangleView: TriangleImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        customTriangleView.images = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]
        customTriangleView.delegate = self
        
    }

}

extension ViewController: TriangImageViewDelegate {
    func didTapImage(image: UIImage) {
        print("Image Tapped: \(image)")
    }
}

