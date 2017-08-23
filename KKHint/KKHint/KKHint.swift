//
//  KKHint.swift
//  KKSwiftFactory
//
//  Created by KING on 2016/12/6.
//  Copyright © 2016年 KING. All rights reserved.
//

import Foundation

import UIKit

open class KKHint {
    
    public typealias SMMBDuration = TimeInterval
    
    public typealias SMMBSuperBottom = CGFloat
    
    public typealias SMMBSuperTop = CGFloat
    
    /// 默认展示的时间
    open static let SMMBDurationDefault: SMMBDuration    = 2.0
    
    /// 一直展示的时间
    open static let SMMBDurationForever: SMMBDuration    = -1
    
    /// 距离父视图底部距离失效，不起作用
    open static let SMMBSuperBottomInvalid: SMMBSuperBottom = -1
    
    /// 距离父视图底部顶离失效，不起作用
    open static let SMMBSuperTopInvalid: SMMBSuperTop    = -1
        
    open class func makeActivityWithTitle(_ title: String?,
                                     view: UIView?,
                                     tapIn: Bool)
    {
        KKSafeMain {
            guard let eView = view else {
                return
            }
            
            KKHintView.hidden(forView: eView)
            
            let hud = KKHintView.showInView(eView, type: .activityIndicate)
            
            if !((title ?? "").isEmpty) {
            
                hud.detailLabel.text = title
            }
            
            hud.isUserInteractionEnabled = !tapIn
        }
    }
    
    open class func hiddenActivityForView(_ view: UIView, animated: Bool) {
        
        KKHintView.hidden(forView: view)
    }
    
    
    open class func makeHitWithTitle(_ title: String?,
                                view: UIView,
                                duration: Double,
                                tapIn: Bool,
                                superTop:SMMBSuperTop,
                                superBot: SMMBSuperBottom) {
        self.makeHitWithTitle(title, content: nil, view: view, duration: duration, tf: UIFont.systemFont(ofSize: 15), cf: UIFont.systemFont(ofSize: 14), tapIn: tapIn, superTop: superTop, superBot: superBot)
    }
    
    
    open class func makeHitWithTitle(_ title: String?,
                                content: String?,
                                view: UIView,
                                duration: Double,
                                tapIn: Bool,
                                superTop:SMMBSuperTop,
                                superBot: SMMBSuperBottom) {
        self.makeHitWithTitle(title, content: content, view: view, duration: duration, tf: UIFont.systemFont(ofSize: 15), cf: UIFont.systemFont(ofSize: 14), tapIn: tapIn, superTop: superTop, superBot: superBot)
    }
    
    open class func makeHitWithTitle(_ title: String?,
                                content: String?,
                                view: UIView,
                                duration: Double,
                                tf: UIFont,
                                cf: UIFont,
                                tapIn: Bool,
                                superTop:SMMBSuperTop,
                                superBot: SMMBSuperBottom)
    {
        KKSafeMain {
            
            if (title ?? "").isEmpty && (content ?? "").isEmpty{
                return
            }
            
            KKHintView.hidden(forView: view)
            
            let hud = KKHintView.showInView(view, type: .text)
            
            if !((title ?? "").isEmpty) {
                
                hud.detailLabel.text = title
            }
            
            hud.isUserInteractionEnabled = !tapIn
            
            if let _ = content {
                
                hud.titleLabel.text = title
            } else {
                
                hud.detailLabel.text = title
            }
            
            if superTop != SMMBSuperTopInvalid {
                
                hud.layoutSubviews()
                
                hud.yOffset = -(view.frame.size.height / 2.0 - superTop - hud.contentView.frame.size.height / 2.0)
            
            }else if superBot != SMMBSuperBottomInvalid {
                
                hud.layoutSubviews()
                
                hud.yOffset = view.frame.size.height / 2.0 - superBot - hud.contentView.frame.size.height / 2.0
            }
            
            if duration != SMMBDurationForever {
                hud.hide(delay: Int64(duration))
            }
        }
    }
    
    open class func hiddenHintForView(_ view: UIView, animated: Bool) {

        KKHintView.hidden(forView: view)
    }
    
    open class func setOffSetForTop(_ top: SMMBSuperTop, viewHeight: CGFloat, H: CGFloat) -> CGFloat {
        let realCenterY = H / 2.0 + top
        return realCenterY - viewHeight / 2.0
    }
    
    open class func setOffSetForBto(_ bot: SMMBSuperBottom, viewHeight: CGFloat,H :CGFloat) -> CGFloat {
        let realCenterY = viewHeight - H / 2.0 - bot
        return realCenterY - viewHeight / 2.0
    }
    
}




extension KKHint {
    
    open class func show(_ text: String?, icon: String?, view: UIView?) {
        
        KKSafeMain {
            let showView = view ?? (self.lastWindow() ?? nil)
            
            guard let eView = showView, let eText = text, !eText.isEmpty else{
                return
            }
            
            let hud = KKHintView.showInView(eView, type: .image)
            
            hud.detailLabel.text = eText
            
            if let eIcon = icon {
                
                let bund = Bundle.init(for: KKHint.self)
                
                if let path = bund.path(forResource: "resource.bundle/\(eIcon)", ofType: nil) {
                    
                    // 设置图片
                    hud.imageView.image = UIImage.init(contentsOfFile: path)
                }
                
            }
            
            hud.hide(delay: 2)
        }
    }
    
    
    open class func showError(_ error: String?, toView: UIView?) {
        self.show(error, icon: "error@2x.png", view: toView)
    }
    
    
    open class func showSuccess(_ success: String?, toView: UIView?) {
        self.show(success, icon: "success@2x.png", view: toView)
    }
    
    
    // MARK: - 显示一些信息
    
    open class func showMessage(_ message: String?, toView: UIView?) {
        KKSafeMain {
            let view = toView ?? self.lastWindow()
        
            guard let eView = view, let msg = message,   !msg.isEmpty  else {
                return;
            }
            
            let hud = KKHintView.showInView(eView, type: .text)
            
            hud.detailLabel.text = msg
            
            hud.hide(delay: 2)
        }
    }
    
    open class func showDimMessage(_ message: String?, toView: UIView?) {
        KKSafeMain {
            
            let view = toView ?? self.lastWindow()
            
            guard let eView = view, let msg = message,   !msg.isEmpty  else {
                return;
            }
            
            let hud = KKHintView.showInView(eView, type: .text)
            
            hud.detailLabel.text = msg
            
            hud.hide(delay: 2)
        }
    }
    
    open class func showMessagWithContent(_ content: String?, toView: UIView?) {
        
        let view = toView ?? self.lastWindow()
        
        guard let eView = view else {
            return;
        }
        KKHint.makeHitWithTitle(content, view: eView, duration: KKHint.SMMBDurationDefault, tapIn: false, superTop: -1, superBot: -1)
    }
    
    open class func showSuccess(_ success: String?) {
        self.showSuccess(success, toView: nil)
    }
    
    open class func showError(_ error: String?) {
        self.showError(error, toView: nil)
    }
    
    open class func showMessage(_ message: String?) {
        return self.showMessage(message, toView: nil)
    }
    
    open class func hideHUDForView(_ view: UIView) {
        KKSafeMain {
            KKHintView.hidden(forView: view)
        }
    }
    
    open class func hideHUD() {
        if let view = self.lastWindow() {
            self.hideHUDForView(view)
        }
    }
    
    open class func hideAllHUDToView(_ view: UIView?) {
        
        KKSafeMain {
            if let eView = view ?? self.lastWindow() {
                
                KKHintView.hidden(forView: eView)
            }
        }
    }
    
    private class func lastWindow() -> UIWindow? {
        
        return UIApplication.shared.delegate?.window ?? nil
    }
    
}

func KKSafeMain(_ block: @escaping ()->Void) {
    
    if Thread.current.isMainThread {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}






