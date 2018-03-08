//
//  PKBubbleAnimation.swift
//
//  Created by Pramod Kumar on 07/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

open class PKBubbleAnimation {
    
    //MARK:- Private Properties
    //MARK:-
    
    //MARK:- Public Properties
    //MARK:-
    var spark: PKImageSpark
    
    
    //MARK:- Initializer
    //MARK:-
    init(forSparking: PKImageSpark) {
        self.spark = forSparking
        
        for _ in 0..<self.spark.cofiguration.totalNumberOfSparkImages {
            self.bubbleSparking(forView: self.createBubbles())
        }
    }
    
    
    //MARK:- Private Methods
    //MARK:-
    private func createBubbles() -> UIImageView {
        //check if parent view for sparking is given or not
        guard let parentView = self.spark.cofiguration.sparkOnView else {
            fatalError("sparkOnView is not defined in sparkConfiguration")
        }
        let imageView = UIImageView(image: self.spark.image)
        let generationView = self.spark.cofiguration.sparkGenerationView ?? parentView
        let size: CGFloat = self.spark.randomFloatBetween(self.spark.cofiguration.sparkMinimumSize, and: self.spark.cofiguration.sparkMaximumSize)
        let newX = self.spark.randomFloatBetween(generationView.frame.origin.x, and: generationView.frame.origin.x+generationView.frame.size.width)
        let newY = self.spark.randomFloatBetween(generationView.frame.origin.y, and: generationView.frame.origin.y+generationView.frame.size.width)
        imageView.frame = CGRect(x: newX, y: newY, width: size, height: size)
        imageView.alpha = self.spark.randomFloatBetween(0.1, and: 1)
        parentView.addSubview(imageView)
        return imageView
    }
    
    private func bubbleSparking(forView: UIView) {
        //check if parent view for sparking is given or not
        guard let parentView = self.spark.cofiguration.sparkOnView else {
            fatalError("sparkOnView is not defined in sparkConfiguration")
        }
        
        
        let zigzagPath = UIBezierPath()
        let oX: CGFloat = forView.frame.origin.x
        let oY: CGFloat = forView.frame.origin.y
        let eX: CGFloat = self.spark.cofiguration.sparkAnimation == .bubbleToUpSide ? oX : self.spark.randomFloatBetween(parentView.frame.origin.x, and: parentView.frame.size.width)
        let eY: CGFloat = self.spark.cofiguration.sparkAnimation == .bubbleToUpSide ? oY - self.spark.randomFloatBetween(50, and: 300) : self.spark.randomFloatBetween(parentView.frame.origin.y, and: parentView.frame.size.height)
        let t: CGFloat = self.spark.randomFloatBetween(20, and: 100)
        var cp1 = CGPoint(x: oX - t, y: (oY + eY) / 2)
        var cp2 = CGPoint(x: oX + t, y: cp1.y)
        // randomly switch up the control points so that the bubble
        // swings right or left at random
        let r: Int = Int(arc4random() % 2)
        if r == 1 {
            let temp: CGPoint = cp1
            cp1 = cp2
            cp2 = temp
        }
        // the moveToPoint method sets the starting point of the line
        zigzagPath.move(to: CGPoint(x: oX, y: oY))
        // add the end point and the control points
        self.spark.cofiguration.sparkAnimation == .bubbleToUpSide ? zigzagPath.addCurve(to: CGPoint(x: eX, y: eY), controlPoint1: cp1, controlPoint2: cp2) : zigzagPath.addLine(to: CGPoint(x: eX, y: eY))
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({() -> Void in
            // transform the image to be 1.3 sizes larger to
            // give the impression that it is popping
            UIView.transition(with: forView, duration: 0.1, options: .transitionCrossDissolve, animations: {() -> Void in
                forView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: {(_ finished: Bool) -> Void in
                forView.removeFromSuperview()
            })
        })
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.duration = 2
        pathAnimation.path = zigzagPath.cgPath
        // remains visible in it's final state when animation is finished
        // in conjunction with removedOnCompletion
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        forView.layer.add(pathAnimation, forKey: "movingAnimation")
        CATransaction.commit()
    }
}
