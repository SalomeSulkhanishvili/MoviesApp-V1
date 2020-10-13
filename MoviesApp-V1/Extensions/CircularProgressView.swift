//
//  UIViewExtensions.swift
//  MoviesApp-V1
//
//  Created by ekaterine iremashvili on 10/13/20.
//

import UIKit

class CircularProgressView: UIView {
    
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    fileprivate var textLayer = CATextLayer()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        createCircularPath()
        createTextLayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
        createTextLayer()
    }
    
    
    var progressColor = UIColor.green {
        didSet{
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.black {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    var strokeEnd : CGFloat = 0 {
        didSet {
            progressLayer.strokeEnd = strokeEnd
            textLayer.string = "\(Int(strokeEnd * 100))%"
        }
    }
    
    fileprivate func createCircularPath(){
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width / 2
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 1.5) / 2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.black.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 3.0
        trackLayer.strokeEnd = 1.0
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = strokeEnd
        progressLayer.lineCap = .round
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }
    
    fileprivate func createTextLayer(){
        let width = frame.width
        let height = frame.height
        
        let fontSize = min(width, height) / 3
        let offset = min(width, height) * 0.1
        
        textLayer.string = "\(strokeEnd)"
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.font = UIFont.boldSystemFont(ofSize: fontSize)
        textLayer.fontSize = fontSize
        textLayer.frame = CGRect(x: 0, y: (height / 2 - fontSize / 2 - offset / 2), width: width, height: fontSize + offset)
        textLayer.alignmentMode = .center
        
        layer.addSublayer(textLayer)
        
    }
    
}
