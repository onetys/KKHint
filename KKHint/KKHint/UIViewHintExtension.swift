//
//  UIViewHintExtension.swift
//  KKSwiftFactory
//
//  Created by KING on 2016/12/6.
//  Copyright © 2016年 KING. All rights reserved.
//

import Foundation

import UIKit

// MARK: - below navibar

extension UIView {
    
    open func makeHintBlowNaviBar(title showTitle: String)
    {
        self.makeHintBlowNavBar(title: showTitle, duration: 1.7,top: (self.frame.size.height == UIScreen.main.bounds.size.height) ? 64 : 0)
    }
    
    open func makeHintBlowNavBar(title showTitle: String,
                                  duration: TimeInterval,
                                  top:      CGFloat)
    {
        let screenWidth = UIScreen.main.bounds.size.width
        let viewHeight: CGFloat = UIView.iphoneIs4(33, is5: 40, is6: 44, isPlus: 44)
        let padToSide: CGFloat = 10
        
        // 最下面的view
        let baseView = UIView.init()
        baseView.layer.masksToBounds = true
        baseView.frame = CGRect(x: 0,
                                    y: top,
                                    width: self.frame.size.width,
                                    height: viewHeight)
        
        let view = UIView.init(frame: CGRect(x: padToSide,
                            y: -viewHeight,
                            width: screenWidth - 2 * padToSide,
                            height: viewHeight))
        view.tag = 999
        view.backgroundColor = UIColor.black
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        let rgb: CGFloat = 0.05
        view.backgroundColor = UIColor.init(red: rgb, green: rgb, blue: rgb, alpha: 0.7)
        
        // 文字
        let label = UILabel.init()
        label.bounds = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        label.center = CGPoint(x: view.frame.size.width / 2.0, y: view.frame.size.height / 2.0)
        label.textAlignment = .center
        label.text = showTitle
        
        label.font = UIFont.systemFont(ofSize: 12.5)
        label.textColor = UIColor.white
        view.addSubview(label)
        
        baseView.addSubview(view)
        
        self.addSubview(baseView)
        
        UIView.animate(withDuration: 0.4, animations: { 
            view.frame = CGRect(x: padToSide, y: 0, width: screenWidth - 2 * padToSide, height: viewHeight)
            }, completion: { (finsh) in
                self .perform(#selector(self.hidden(_:)), with: baseView, afterDelay: duration)
        }) 
    }
    
    @objc fileprivate func hidden(_ baseView: UIView) {
        let screenWidth = UIScreen.main.bounds.size.width
        let view = baseView.viewWithTag(999)
        guard let eView = view else {
            return
        }
        UIView.animate(withDuration: 0.25, animations: {
            
            eView.frame = CGRect(x: eView.frame.origin.x,
                y: -eView.bounds.size.height,
                width: screenWidth - 2 * eView.frame.origin.x,
                height: eView.bounds.size.height)
            
            }, completion: { (finsh) in
                
                baseView.removeFromSuperview()
                
        }) 
    }
    
    fileprivate class func iphoneIs4(_ iphone4: CGFloat, is5: CGFloat, is6: CGFloat, isPlus: CGFloat) -> CGFloat {
       
        let bounds = UIScreen.main.bounds
        if bounds.size.width == 320 {
            if bounds.size.height == 568 {
                return is5
            }else{
                return iphone4
            }
        }else if bounds.size.width == 375 {
            return is6
        }else {
            return isPlus
        }
    }
}

// MARK: - activty

extension UIView {
    
    open func makeActivity() {
        self.makeActivity(title: nil)
    }
    
    open func makeActivity(title showTitle: String?)
    {
        KKHint.makeActivityWithTitle(showTitle, view: self, tapIn: false)
    }
    
    open func hiddenActivity()
    {
        self.hiddenActivity(true)
    }
    
    open func hiddenActivity(_ animated: Bool)
    {
        KKHint.hiddenActivityForView(self, animated: animated)
    }
}


// MARK: - continue show

extension UIView {
    
    // eg: title、identity、bot
    open func makeCTHint(title showTitle: String?,
                                 content: String?)
    {
        KKHint.makeHitWithTitle(showTitle,content: content, view: self, duration: KKHint.SMMBDurationForever, tapIn: false, superTop: KKHint.SMMBSuperTopInvalid, superBot: KKHint.SMMBSuperBottomInvalid)
    }
    // eg: title、identity、bot
    open func makeCTHint(title showTitle: String?,
                                 content: String?,
                                 superBot: CGFloat)
    {
        KKHint.makeHitWithTitle(showTitle, content: content, view: self, duration: KKHint.SMMBDurationForever, tapIn: false, superTop: KKHint.SMMBSuperTopInvalid, superBot: superBot)
    }
    
    // eg: title、identity、bot
    open func makeCTHint(title showTitle: String?,
                                 content: String?,
                                 superTop: CGFloat)
    {
        KKHint.makeHitWithTitle(showTitle, content: content, view: self, duration: KKHint.SMMBDurationForever, tapIn: false, superTop: superTop, superBot: KKHint.SMMBSuperBottomInvalid)
    }
}


// MARK: - hint

extension UIView {
    
    open func hiddenHud()
    {
        self.hiddenHud(true)
    }
    
    open func hiddenHud(_ animated: Bool)
    {
        KKHint.hiddenHintForView(self, animated: true)
    }
    
    open func makeHint(_ title: String?) {
        self.makeHint(title: title, tapIn: false)
    }
    
    open func makeHint(_ title: String?, font: UIFont) {
        self.makeHint(title, content: nil, tf: font, cf: UIFont.systemFont(ofSize: 14))
    }
    
    open func makeHint(_ title: String?, content: String?) {
        self.makeHint(title: title, content: content, tapIn: false)
    }
    
    open func makeHint(_ title: String?, content: String?, tf: UIFont, cf: UIFont) {
        self.makeHitWithTitle(title, content: content, view: self, duration: KKHint.SMMBDurationDefault, tf: tf, cf: cf, tapIn: false, superTop: KKHint.SMMBSuperTopInvalid, superBot: KKHint.SMMBSuperBottomInvalid)
    }
    
    open func makeHint(title showTitle: String?,
                               superBot:  KKHint.SMMBSuperBottom)
    {
        KKHint.makeHitWithTitle(showTitle, view: self, duration: KKHint.SMMBDurationDefault, tapIn: false, superTop: KKHint.SMMBSuperTopInvalid, superBot: superBot)
    }
    
    open func makeHint(title showTitle: String?,
                               superTop: KKHint.SMMBSuperTop)
    {
        KKHint.makeHitWithTitle(showTitle, view: self, duration: KKHint.SMMBDurationDefault, tapIn: false, superTop: superTop, superBot: KKHint.SMMBSuperBottomInvalid)
    }
    
    open func makeHint(title showTitle: String?,
                               content: String?,
                               tapIn: Bool)
    {
        KKHint.makeHitWithTitle(showTitle, content: content, view: self, duration: KKHint.SMMBDurationDefault, tapIn: tapIn, superTop: KKHint.SMMBSuperTopInvalid, superBot: KKHint.SMMBSuperBottomInvalid)
    }
    
    open func makeHint(title showTitle: String?,
                               tapIn: Bool)
    {
        KKHint.makeHitWithTitle(showTitle, view: self, duration: KKHint.SMMBDurationDefault, tapIn: tapIn, superTop: KKHint.SMMBSuperTopInvalid, superBot: KKHint.SMMBSuperBottomInvalid)
    }
    
    open func makeHint(title showTitle: String?,
                               tapIn: Bool,
                               duration: KKHint.SMMBDuration)
    {
        KKHint.makeHitWithTitle(showTitle, view: self, duration: duration, tapIn: tapIn, superTop: KKHint.SMMBSuperTopInvalid, superBot: KKHint.SMMBSuperBottomInvalid)
    }
    
    /// identity： 为了兼容到一个页面同时提示多个文本，则设置多个identity
    /// superTop:  到父视图顶部的距离
    /// superBot:  到俯视图底部的距离
    /// tapIn:     是否点击能够穿透到提示框的下面的视图
    open func makeHitWithTitle(_ title: String?,
                                duration: Double,
                                tapIn: Bool,
                                superTop: KKHint.SMMBSuperTop,
                                superBot: KKHint.SMMBSuperBottom)
    {
        KKHint.makeHitWithTitle(title, view: self, duration: duration, tapIn: tapIn, superTop: superTop, superBot: superBot)
    }
    
    /// identity： 为了兼容到一个页面同时提示多个文本，则设置多个identity
    /// superTop:  到父视图顶部的距离
    /// superBot:  到俯视图底部的距离
    /// tapIn:     是否点击能够穿透到提示框的下面的视图
    open func makeHitWithTitle(_ title: String?,
                               content: String?,
                               view: UIView,
                               duration: Double,
                               tf: UIFont,
                               cf: UIFont,
                               tapIn: Bool,
                               superTop: KKHint.SMMBSuperTop,
                               superBot: KKHint.SMMBSuperBottom)
    {
        KKHint.makeHitWithTitle(title, content: content, view: self, duration: duration, tf: tf, cf: cf, tapIn: tapIn, superTop: superTop, superBot: superBot)
    }
}

// MARK: -

extension UIView {
    
    @available(iOS, deprecated: 1.0, message: "deprecated identity,view")
    open func makeHitWithTitle(_ title: String?,
                                 identity: String?,
                                 view: UIView?,
                                 duration: Double,
                                 tapIn: Bool,
                                 superTop: KKHint.SMMBSuperTop,
                                 superBot: KKHint.SMMBSuperBottom)
    {
        KKHint.makeHitWithTitle(title, view: self, duration: duration, tapIn: tapIn, superTop: superTop, superBot: superBot)
    }
}
