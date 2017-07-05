//
//  KKHint.swift
//  KKSwiftFactory
//
//  Created by KING on 2016/12/6.
//  Copyright © 2016年 KING. All rights reserved.
//

import Foundation

import UIKit

// 如果项目为 OC 项目，则屏蔽此行代码即可
import MBProgressHUD

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
        guard let eView = view else {
            return
        }
        
        MBProgressHUD.hide(for: eView, animated: true)
        
        let hud = MBProgressHUD.init(view: eView)!
        
        hud.mode = .indeterminate
        
        hud.margin = 10
        
        hud.cornerRadius = 3;
        
        if !((title ?? "").isEmpty) {
        
            hud.detailsLabelText = title
            
            hud.detailsLabelFont  = UIFont.systemFont(ofSize: 14)
            
            hud.detailsLabelColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        hud.isUserInteractionEnabled = !tapIn
        
        eView.addSubview(hud)
        
        hud.show(true)
    }
    
    open class func hiddenActivityForView(_ view: UIView, animated: Bool) {
        
        MBProgressHUD.hide(for: view, animated: true)
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
        
        if (title ?? "").isEmpty && (content ?? "").isEmpty{
            return
        }
        
        self.hiddenHintForView(view, animated: false)
        
        let hud = MBProgressHUD.init(view: view)!
        
        hud.removeFromSuperViewOnHide = true
        
        hud.mode = .text
        
        hud.margin = 10
        
        if let _ = content {
            
            hud.labelFont = tf
            
            hud.labelText = title
            
            hud.detailsLabelFont = cf
            
            hud.detailsLabelText = content
        } else {
            
            hud.detailsLabelFont = tf
            
            hud.detailsLabelText = title
        }
        
        hud.cornerRadius = 3
        
        hud.isUserInteractionEnabled = !tapIn
        
        view.addSubview(hud)
        
        if superTop != SMMBSuperTopInvalid {
            
            hud.layoutSubviews()
            
            if let label = hud.value(forKeyPath: "label") as? UILabel, let detailsLabel = hud.value(forKeyPath: "detailsLabel") as? UILabel {
                hud.yOffset = Float(self.setOffSetForTop(superTop, viewHeight: view.frame.size.height, H: label.frame.size.height + detailsLabel.frame.size.height + 20))
            }
        }else if superBot != SMMBSuperBottomInvalid {
            
            hud.layoutSubviews()
            if let label = hud.value(forKeyPath: "label") as? UILabel, let detailsLabel = hud.value(forKeyPath: "detailsLabel") as? UILabel {
                hud.yOffset = Float(self.setOffSetForBto(superBot, viewHeight: view.frame.size.height, H: label.frame.size.height + detailsLabel.frame.size.height + 20))
            }
        }
        
        hud.show(true)
        
        if duration != SMMBDurationForever {
            hud.hide(true, afterDelay: duration)
        }
    }
    
    open class func hiddenHintForView(_ view: UIView, animated: Bool) {

        MBProgressHUD.hide(for: view, animated: true)
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
        
        let showView = view ?? (self.lastWindow() ?? nil)
        
        guard let eView = showView, let eText = text,   !eText.isEmpty else{
            return
        }
        
        let hud = MBProgressHUD.showAdded(to: eView, animated: true)!
        
        hud.mode = .customView
        
        hud.detailsLabelText = eText
        
        hud.detailsLabelFont  = UIFont.systemFont(ofSize: 15)
        
        if let eIcon = icon {
            // 设置图片
            hud.customView = UIImageView.init(image: UIImage.init(named: "MBProgressHUD.bundle/\(eIcon)"))
        }
        
        hud.cornerRadius = 3
        
        hud.mode = .customView
        
        hud.removeFromSuperViewOnHide = true
        
        hud.hide(true, afterDelay: 2.0)
    }
    
    
    open class func showError(_ error: String?, toView: UIView?) {
        self.show(error, icon: "error.png", view: toView)
    }
    
    
    open class func showSuccess(_ success: String?, toView: UIView?) {
        self.show(success, icon: "success.png", view: toView)
    }
    
    
    // MARK: - 显示一些信息
    
    open class func showMessage(_ message: String?, toView: UIView?) {
        let view = toView ?? self.lastWindow()
        
        guard let eView = view, let msg = message,   !msg.isEmpty  else {
            return;
        }
        
        let hud = MBProgressHUD.showAdded(to: eView, animated: true)!
        hud.detailsLabelText = message
        hud.removeFromSuperViewOnHide = true
        hud.margin = 10
        hud.cornerRadius = 3;
        hud.detailsLabelFont  = UIFont.systemFont(ofSize: 15)
        hud.detailsLabelColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    open class func showDimMessage(_ message: String?, toView: UIView?) {
        
        let view = toView ?? self.lastWindow()
        
        guard let eView = view, let msg = message,   !msg.isEmpty else {
            return ;
        }
        let hud = MBProgressHUD.showAdded(to: eView, animated: true)!
        hud.detailsLabelText = message
        hud.dimBackground = true
        hud.margin = 10
        hud.cornerRadius = 3;
        hud.detailsLabelFont  = UIFont.systemFont(ofSize: 15)
        hud.detailsLabelColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
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
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    open class func hideHUD() {
        if let view = self.lastWindow() {
            self.hideHUDForView(view)
        }
    }
    
    open class func hideAllHUDToView(_ view: UIView?) {
        
        if let eView = view ?? self.lastWindow() {
            
            MBProgressHUD.hideAllHUDs(for: eView, animated: true)
        }
    }
    
    private class func lastWindow() -> UIWindow? {
        
        return UIApplication.shared.delegate?.window ?? nil
    }
    
}
