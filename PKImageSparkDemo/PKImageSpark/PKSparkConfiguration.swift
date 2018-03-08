//
//  PKSparkConfiguration.swift
//
//  Created by Pramod Kumar on 07/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

enum PKSparkAnimations {
    case bubbleToUpSide
    case bubbleInFullScreen
}

class PKSparkConfiguration {
    
    //MARK:- Public Properties
    //MARK:-
    var totalNumberOfSparkImages: Int
    var sparkOnView: UIView?
    var sparkGenerationView: UIView?
    var sparkMinimumSize: CGFloat
    var sparkMaximumSize: CGFloat
    var sparkAnimation: PKSparkAnimations
    
    
    //MARK:- Initializer
    //MARK:-
    init() {
        //default configuration
        self.totalNumberOfSparkImages = 10
        self.sparkMinimumSize = 5.0
        self.sparkMaximumSize = 30.0
        self.sparkAnimation = .bubbleInFullScreen
    }
}
