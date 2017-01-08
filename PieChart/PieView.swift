//
//  PieView.swift
//  PieChart
//
//  Created by Shengkun Wei on 1/8/17.
//  Copyright © 2017 amy. All rights reserved.
//

import UIKit

@IBDesignable
class PieView: UIView {
    var backgroundLayer: CAShapeLayer!
    @IBInspectable var backgroundLayerColor: UIColor = UIColor.cyan {
        didSet {
            updateLayerProperties()
        }
    }
    
    var backgroundImageLayer: CALayer!
    @IBInspectable var backgroundImage: UIImage? {
        didSet {
            updateLayerProperties()
        }
    }
    
    var ringLayer: CAShapeLayer!
    @IBInspectable var ringThickness: CGFloat = 2
    @IBInspectable var ringColor: UIColor = UIColor.green
    @IBInspectable var ringProgress: CGFloat = 0.75 {
        didSet {
            updateLayerProperties()
        }
    }
    
    var percentageLayer: CATextLayer!
    @IBInspectable var showPercentage: Bool = true {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable var percentagePosition: CGFloat = 100 {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable var percentageColor: UIColor = UIColor.green {
        didSet {
            updateLayerProperties()
        }
    }
    
    var lineWidth: CGFloat = 1
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createChart()
        
    }
    
    
    func createChart() {
        layoutBackgroundLayer()
        layoutBackgroundImage()
        layoutPie()
        updateLayerProperties()
    }
    
    
    func layoutBackgroundLayer() {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            self.layer.addSublayer(backgroundLayer)
            
            let rect = self.bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
            let path = UIBezierPath(ovalIn: rect)
            backgroundLayer.path = path.cgPath
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
            backgroundLayer.lineWidth = lineWidth
            
            
            
            let c = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            
            backgroundLayer.frame = layer.bounds
            
            print("layer bounds: \(layer.bounds)   self bounds: \(bounds)")
        }
        
        
    }
    
    
    func layoutBackgroundImage() {
        if backgroundImageLayer == nil {
            backgroundImageLayer = CALayer()
            self.layer.addSublayer(backgroundImageLayer)
            
            let mask = CAShapeLayer()
            let inset = lineWidth + 3
            
            let rect = self.bounds.insetBy(dx: inset, dy: inset)
            mask.path = UIBezierPath(ovalIn: rect).cgPath
            mask.frame = layer.bounds
            backgroundImageLayer.mask = mask
            backgroundImageLayer.contentsGravity = kCAGravityResizeAspectFill
            backgroundImageLayer.backgroundColor = UIColor.yellow.cgColor
            backgroundImageLayer.frame = layer.bounds
            
        }
        
        
        
    }
    
    func layoutPie() {
        if ringProgress == 0 {
            if ringLayer != nil {
                ringLayer.strokeEnd = 0
            }
        }
        
        if ringLayer == nil {
            ringLayer = CAShapeLayer()
            
            self.layer.addSublayer(ringLayer)
            
            let inset = ringThickness / 2
            let rect = self.bounds.insetBy(dx: inset, dy: inset)
            
            ringLayer.path = UIBezierPath(ovalIn: rect).cgPath
            
            ringLayer.transform = CATransform3DMakeRotation(-CGFloat(M_PI_2), 0, 0, 1)
            
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.fillColor = nil
            ringLayer.lineWidth = ringThickness
            
        }
        
        ringLayer.strokeEnd = ringProgress / 100
        ringLayer.frame = layer.bounds
        
        if percentageLayer == nil {
            percentageLayer = CATextLayer()
            layer.addSublayer(percentageLayer)
            
            percentageLayer.font = UIFont(name: "HelveticaNeue-Light", size: 80)
            percentageLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: percentageLayer.fontSize + 0)
            
            
            percentageLayer.alignmentMode = kCAAlignmentCenter
            percentageLayer.foregroundColor = percentageColor.cgColor
            percentageLayer.contentsScale = UIScreen.main.scale
            
            
        }
    }
    
    

    func updateLayerProperties() {
        if backgroundLayer != nil {
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
        }
        
        if backgroundImageLayer != nil {
            if let image = backgroundImage {
                backgroundImageLayer.contents = image.cgImage
            }
        }
        
        if ringLayer != nil {
            ringLayer.strokeEnd = ringProgress / 100
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.lineWidth = ringThickness
            
            
        }
        
        if percentageLayer != nil {
            if showPercentage {
                percentageLayer.opacity = 1
                percentageLayer.string = "\(Int(ringProgress))%"
                percentageLayer.position = CGPoint(x: bounds.midX, y: percentagePosition)
                
                percentageLayer.foregroundColor = percentageColor.cgColor
            } else {
                percentageLayer.opacity = 0
            }
        }
    }
    
    
    
}
