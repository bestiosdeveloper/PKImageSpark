//
//  PKFloatingButton.swift
//  PKFloatingButtonDemo
//
//  Created by Pramod Kumar on 06/03/18.
//  Copyright © 2018 Pramod Kumar. All rights reserved.
//

import UIKit

/**************************************************
 ************* PFFloatingButton Class *************
 **************************************************/

class PKFloatingButton {
    
    //MARK:- Public Properties
    //MARK:-
    static let shared: PKFloatingButton = PKFloatingButton()
    
    //MARK:- Private Properties
    //MARK:-
    fileprivate static let floatButtonBackgroundColor: UIColor = UIColor.darkGray//UIColor(red: 88/255.0, green: 194/255.0, blue: 217/255.0, alpha: 1.0)
    
    fileprivate var faddingTimer: Timer?
    
    fileprivate let floatButton: UIButton = UIButton()
    
    fileprivate var floatButtonSize: CGSize = CGSize(width: 60.0, height: 60.0)
    fileprivate var makeButtonFadeInSecondsAfterTap: TimeInterval = 1.0
    fileprivate var buttonFloatingOn: UIView?
    fileprivate var viewToExpand: PKExpandableView = PKExpandableView()
    fileprivate var padding: CGFloat = 3.0
    fileprivate var cornerRadius: CGFloat = 10.0
    
    fileprivate var floatingButtonTapHandler: (()->())?
    
    fileprivate var lastPosition: CGPoint = CGPoint.zero
    
    //MARK:- Private Methods
    //MARK:-
    private init() {
        //        self.lastPosition = CGPoint(x: self.floatButtonSize.width / 2.0, y: (self.buttonFloatingOn?.frame.size.height ?? 0.0) / 2.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented in file \(#file) on line \(#line)")
    }
    
    fileprivate func initFloatButton(viewToExpand: UIView? = nil, withImage: UIImage? = nil) {
        
        //give the initial frame for loating button
        self.floatButton.frame = CGRect(x: self.lastPosition.x, y: self.lastPosition.y, width: self.floatButtonSize.width, height: self.floatButtonSize.height)
        
        //bueatify the bloating button
        self.floatButton.layer.cornerRadius = self.cornerRadius
        self.floatButton.layer.masksToBounds = true
        self.floatButton.backgroundColor = PKFloatingButton.floatButtonBackgroundColor
        
        //set given image to floating button
        self.floatButton.setImage(withImage, for: UIControlState.normal)
        
        //add touch action event on floating button
        self.floatButton.addTarget(self, action: #selector(PKFloatingButton.floatButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        //add pan gesture to drag the floating button
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(PKFloatingButton.panHandler(_:)))
        self.floatButton.addGestureRecognizer(panGesture)
        
        //        //set default position of floating button
        if self.lastPosition.x == 0.0 {
            self.lastPosition = CGPoint(x: self.floatButtonSize.width / 2.0, y: (self.buttonFloatingOn?.frame.size.height ?? self.floatButtonSize.width) / 2.0)
        }
        self.floatButton.center = self.lastPosition
        
        //create a view to expande
        self.viewToExpand = PKExpandableView(frame: (self.buttonFloatingOn?.frame ?? CGRect.zero), expandMinFrame: self.floatButton.frame, viewToExpand: viewToExpand)
        
        self.buttonFloatingOn?.addSubview(self.viewToExpand)
        
        //make button fade for first time
        self.shouldButtonFade(isFade: true, animated: false)
    }
    
    fileprivate func shouldButtonFade(isFade: Bool, animated: Bool) {
        
        //make floating button fade in/out with animation
        UIView.animate(withDuration: animated ? 0.5 : 0.0, animations: {
            
            self.floatButton.alpha = isFade ? 0.5 : 1.0
            
        }) { (completed) in
            if !isFade {
                //if button is not fade the run timer to make it fade after some time
                self.startTimer()
            }
        }
    }
    
    fileprivate func startTimer() {
        //start the fadding timer
        self.stopTimer()
        self.faddingTimer = Timer.scheduledTimer(timeInterval: self.makeButtonFadeInSecondsAfterTap, target: self, selector: #selector(PKFloatingButton.timerHandler(_:)), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopTimer() {
        //invalidate the timer
        self.faddingTimer?.invalidate()
        self.faddingTimer = nil
    }
    
    
    @objc private func timerHandler(_ timer: Timer) {
        //make float button fade after time executed, stop timer not to be executed next time
        self.stopTimer()
        self.shouldButtonFade(isFade: true, animated: true)
    }
    
    @objc private func floatButtonTapped(_ sender: UIButton) {
        
        if let handler = self.floatingButtonTapHandler {
            //execute the handler is passed
            handler()
        }
        
        //expand the view to be shown
        self.viewToExpand.expand(floatButton: self.floatButton)
        //stop timer if executing
        self.stopTimer()
    }
    
    @objc private func panHandler(_ gesture: UIPanGestureRecognizer) {
        //start the timer for fadding the floating button
        PKFloatingButton.shared.shouldButtonFade(isFade: false, animated: false)
        PKFloatingButton.shared.startTimer()
        
        if let gestureView = gesture.view, let floatSuperView = self.buttonFloatingOn {
            
            let topLimit: CGFloat = (self.floatButtonSize.height / 2.0) + self.padding
            let bottomLimit: CGFloat = (floatSuperView.frame.size.height - topLimit)
            let leftLimit: CGFloat = ((self.floatButtonSize.width / 2.0) + self.padding)
            let rightLimit: CGFloat = (floatSuperView.frame.size.width - leftLimit)
            
            let translation  = gesture.translation(in: gestureView)
            let lastLocation = self.floatButton.center
            
            var newX = lastLocation.x + translation.x
            var newY = lastLocation.y + translation.y
            
            newX = newX >= 0.0 ? newX : 0.0
            newX = newX <= floatSuperView.frame.size.width ? newX : floatSuperView.frame.size.width
            
            newY = newY >= 0.0 ? newY : 0.0
            newY = newY <= floatSuperView.frame.size.height ? newY : floatSuperView.frame.size.height
            
            if gesture.state == UIGestureRecognizerState.ended {
                func adjustXForTopAndBottmAlignement() {
                    newX = newX < leftLimit ? leftLimit : newX
                    newX = newX > rightLimit ? rightLimit : newX
                }
                
                //for top alignment
                if (0...(floatSuperView.frame.size.width) ~= newX), (newY <  (floatSuperView.frame.size.height / 5.0)) {
                    //y make it to top aligned
                    newY = topLimit
                    
                    //x shouldn't cross the boundaries limits
                    adjustXForTopAndBottmAlignement()
                }
                //for bottom alignment
                else if (0...(floatSuperView.frame.size.width) ~= newX), (newY >  ((floatSuperView.frame.size.height / 5.0) * 4.0)) {
                    //y make it to bottom aligned
                    newY = bottomLimit
                    
                    //x shouldn't cross the boundaries limits
                    adjustXForTopAndBottmAlignement()
                }
                //for all other cases
                else {
                    if (self.floatButtonSize.height * 2.0) > newY {
                        newY = topLimit
                    }
                    else if newY > (floatSuperView.frame.size.height - (self.floatButtonSize.height * 2.0)) {
                        newY = bottomLimit
                    }
                    
                    newX = newX < (floatSuperView.frame.size.width / 2.0) ? leftLimit : rightLimit
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.floatButton.center = CGPoint(x: newX, y: newY)
                })
            }
            else {
                self.floatButton.center = CGPoint(x: newX, y: newY)
            }
            self.lastPosition = self.floatButton.center
            gesture.setTranslation(CGPoint.zero, in: gestureView)
        }
    }
    
    
    //MARK:- Public Methods
    //MARK:-
    func enableFloating(onView: UIView, viewToExpand: UIView? = nil, withImage: UIImage? = nil, onTapHandler: (()->())? = nil) {
        self.floatingButtonTapHandler = onTapHandler
        //add floating button on the desired screen
        self.buttonFloatingOn = onView
        onView.addSubview(self.floatButton)

        self.initFloatButton(viewToExpand: viewToExpand, withImage: UIImage(named: "help_white"))
    }
    
    func disableFloating() {
        self.floatButton.removeFromSuperview()
    }
}



/**************************************************
 ************* PKExpandableView Class *************
 **************************************************/
fileprivate class PKExpandableView: UIView {
    
    //MARK:- Enum to choose the expanding type
    //MARK:-
    enum ExpandAccordingTo {
        case Square, Screen
    }
    
    
    //MARK:- Private Properties
    //MARK:-
    fileprivate var expandingAs = ExpandAccordingTo.Square
    fileprivate var minExpandFrame = CGRect.zero, maxExpandFrame = CGRect.zero
    fileprivate var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    
    //MARK:- Private Properties
    //MARK:-
    var expandingView: UIView?// = UIView()
    
    
    //MARK:- Life Cycle Methods
    //MARK:-
    convenience init() {
        self.init(frame: CGRect.zero, expandMinFrame: CGRect.zero)
    }
    
    init(frame: CGRect, expandMinFrame: CGRect, viewToExpand: UIView? = nil) {
        super.init(frame: frame)
        
        self.minExpandFrame = expandMinFrame
        
        //get the ration for expanding according to the expanding choice
        var ratio: CGFloat = 1.0
        if self.expandingAs == ExpandAccordingTo.Square {
            ratio = 1.0
        }
        else {
            ratio = self.frame.size.width / self.frame.size.height
        }
        
        let newWidth = self.frame.size.width - (self.contentInsets.left + self.contentInsets.right)
        let newHeight = newWidth / ratio
        
        //calculate and store the max size to expande
        self.maxExpandFrame = CGRect(x: self.contentInsets.left, y: self.contentInsets.top, width: newWidth, height: newHeight)
        
        //add expanding view if passed
        if let expView = viewToExpand {
            self.expandingView = expView
            expView.center = self.center
        }
        else {
            self.expandingView = UIView(frame: expandMinFrame)
        }
        
        self.expandingView!.alpha = 0.8
        self.expandingView!.backgroundColor = PKFloatingButton.floatButtonBackgroundColor
        self.expandingView!.layer.cornerRadius = 10.0//PKFloatingButton.shared.cornerRadius
        self.expandingView!.layer.masksToBounds = true
        self.expandingView!.autoresizesSubviews = true
        
        //add expanding view on main view
        self.addSubview(self.expandingView!)
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented in file \(#file) on line \(#line)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        //collape the expanded view on touch event
        self.collapse()
    }
    
    //MARK:- Public Methods
    //MARK:-
    func expand(floatButton: UIButton) {
        
        //unhide self to enable touch event
        self.isHidden = false
        
        //hide the floating button
        floatButton.isHidden = true
        
        //make expanding view as the button size
        self.minExpandFrame = floatButton.frame
        self.expandingView?.frame = floatButton.frame
        
        //expand with the animation
        UIView.animate(withDuration: 0.3, animations: {
            self.expandingView?.frame = self.maxExpandFrame
            self.expandingView?.center = self.center
        })
    }
    
    func collapse() {
        
        //start the timer for fadding the floating button
        PKFloatingButton.shared.shouldButtonFade(isFade: false, animated: false)
        PKFloatingButton.shared.startTimer()
        
        //collape the expanded view with animation
        UIView.animate(withDuration: 0.3, animations: {
            self.expandingView?.frame = self.minExpandFrame
        }, completion: { (sucess) in
            //show the floating button
            PKFloatingButton.shared.floatButton.isHidden = false
            //hide expanded view
            self.isHidden = true
        })
    }
}

