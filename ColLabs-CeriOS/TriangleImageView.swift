//
//  TriangleView.swift
//  ColLabs-CeriOS
//
//  Created by Rey Cerio on 2017-03-20.
//  Copyright © 2017 CeriOS. All rights reserved.
//

import UIKit

protocol TriangImageViewDelegate: class {
    func didTapImage(image: UIImage)
}

class TriangleImageView: UIView {
    
    //assuming that width is height/2
    
    var images = [UIImage]()
    
    var delegate: TriangImageViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //add the imageViews..3 imageViews
        for i in 1...3 {
            let imageView = UIImageView()
            imageView.tag = i
            imageView.isUserInteractionEnabled = true
            self.addSubview(imageView)
        }
        
        //add the gesture recognizer
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TriangleImageView.handleTap)))
    }
    
    //drawing the rectangle that will contain the triangles
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let width = rect.size.width
        let height = rect.size.height
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let pointA = CGPoint(x: 0, y: 0)
        let pointB = CGPoint(x: width * 0.79, y: 0)
        let pointC = CGPoint(x: width, y: 0)
        let pointD = CGPoint(x: width * 0.534, y: height * 0.29)
        let pointE = CGPoint(x: 0, y: height * 0.88)
        let pointF = CGPoint(x: 0, y: height)
        let pointG = CGPoint(x: width * 0.874, y: height)
        let pointH = CGPoint(x: width, y: height)
        
        let path1 = [pointA, pointB, pointD, pointE]
        let path2 = [pointE, pointD, pointG, pointF]
        let path3 = [pointB, pointC, pointH, pointG, pointD]
        
        let paths = [path1, path2, path3]
        
        for i in 1...3 {
            let imageView = (self.viewWithTag(i) as! UIImageView)
            imageView.image = images[i - 1]
            imageView.frame = frame
            addMask(view: imageView, points: paths[i - 1])
        }
    }
    
    //adding mask to the imageView
    func addMask(view: UIView, points: [CGPoint]){
        let maskPath = UIBezierPath()   //bezierPath implemented here
        maskPath.move(to: points[0])
        
        for i in 1..<points.count {
            maskPath.addLine(to: points[i])
        }
        
        maskPath.close()
        
        //forming a shape where bezier path closes
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }
    
    //handle tap gesture
    func handleTap(recognizer: UITapGestureRecognizer) {
        let point = recognizer.location(in: recognizer.view)
        //3 views
        for i in 1...3 {
            let imageView = (self.viewWithTag(i) as! UIImageView)
            let layer = (imageView.layer.mask as! CAShapeLayer)
            let path = layer.path
            
            //let contains = CGPathContainsPoint(path, nil, point, false)
            let contains = path?.contains(point)
            
            if contains == true {
                delegate?.didTapImage(image: imageView.image!)
            }
        }
    }
}
