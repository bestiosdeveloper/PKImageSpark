//
//  PKImageSpark.swift
//
//  Created by Pramod Kumar on 07/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

open class PKImageSpark {
    
    //MARK:- Private Properties
    //MARK:-
    
    //MARK:- Public Properties
    //MARK:-
    var image: UIImage
    var cofiguration: PKSparkConfiguration = PKSparkConfiguration()
    
    
    //MARK:- Initializer
    //MARK:-
    public init(withImage image: UIImage, configuration: PKSparkConfiguration) {
        self.image = image
        self.cofiguration = configuration
    }
    
    
    //MARK:- Private Methods
    //MARK:-
    
    
    //MARK:- Public Methods
    //MARK:-
    func randomFloatBetween(_ smallNumber: CGFloat, and bigNumber: CGFloat) -> CGFloat {
        let diff: CGFloat = bigNumber - smallNumber
        return (((CGFloat(arc4random()).truncatingRemainder(dividingBy: CGFloat(UInt32(RAND_MAX) + 1))) / CGFloat(RAND_MAX)) * diff) + smallNumber
    }
    
    public func startSparking() {
        switch self.cofiguration.sparkAnimation {
        case .bubbleToUpSide:
            _ = PKBubbleAnimation(forSparking: self)
        default:
            _ = PKBubbleAnimation(forSparking: self)
        }
    }
}

