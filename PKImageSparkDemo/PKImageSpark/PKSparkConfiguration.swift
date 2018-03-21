//
//  PKSparkConfiguration.swift
//
//  Created by Pramod Kumar on 07/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

public enum PKSparkAnimations {
    case bubbleToUpSide
    case bubbleInFullScreen
}

open class PKSparkConfiguration {
    
    //MARK:- Public Properties
    //MARK:-
    public var totalNumberOfSparkImages: Int
    public var sparkOnView: UIView?
    public var sparkGenerationView: UIView?
    public var sparkMinimumSize: CGFloat
    public var sparkMaximumSize: CGFloat
    public var sparkAnimation: PKSparkAnimations
    
    
    //MARK:- Initializer
    //MARK:-
    public init() {
        //default configuration
        self.totalNumberOfSparkImages = 10
        self.sparkMinimumSize = 5.0
        self.sparkMaximumSize = 30.0
        self.sparkAnimation = .bubbleInFullScreen
    }
}

