//
//  LoadController.swift
//  test
//
//  Created by Sandro Beruashvili on 7/12/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit

class LoadController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 createCircularPath()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.performSegue(withIdentifier: "sec", sender: nil)
        })
    }
   func createCircularPath() {

   let circleLayer = CAShapeLayer()
   let progressLayer = CAShapeLayer()

   let center = self.view.center
   let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -.pi / 2, endAngle: 2 * .pi, clockwise: true)

   circleLayer.path = circularPath.cgPath
   circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.strokeColor = UIColor.white.cgColor
   circleLayer.lineCap = .round
   circleLayer.lineWidth = 20.0  //for thicker circle compared to progressLayer

   progressLayer.path = circularPath.cgPath
   progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeColor = UIColor(red: 255/255, green: 113/255, blue: 125/255, alpha: 1).cgColor
   progressLayer.lineCap = .round
   progressLayer.lineWidth = 10.0
   progressLayer.strokeEnd = 0

    view.layer.addSublayer(circleLayer)
    view.layer.addSublayer(progressLayer)

   let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
   progressAnimation.toValue = 1
    progressAnimation.duration = 5
   progressAnimation.fillMode = .forwards
   progressAnimation.isRemovedOnCompletion = false
   progressLayer.add(progressAnimation, forKey: "progressAnim")


   }
}
