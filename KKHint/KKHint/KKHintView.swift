//
//  KKHintView.swift
//  KKHint
//
//  Created by 王铁山 on 2017/8/23.
//  Copyright © 2017年 king. All rights reserved.
//

import UIKit

public enum KKHintViewType: Int {
    
    case image
    
    case text
    
    case activityIndicate
}

open class KKHintView: UIView {
    
    ///  此方法会自动添加到 view
    ///
    /// - Parameter view: view
    /// - Returns: KKHintView
    open class func showInView(_ view: UIView, type: KKHintViewType) -> KKHintView {
        
        let newView = KKHintView.init(frame: CGRect.init(origin: CGPoint(), size: view.frame.size), type: type)
        
        view.addSubview(newView)
        
        return newView
    }
    
    /// 隐藏
    ///
    /// - Parameter forView: superView
    open class func hidden(forView: UIView) {
        
        forView.subviews.filter({($0 as? KKHintView) != nil}).forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    open var yOffset: CGFloat = 0 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    open var contentView: UIView = UIView()
    
    open var acvtivityView: UIActivityIndicatorView!
    
    open var imageView: UIImageView!
    
    open var titleLabel: UILabel = UILabel()
    
    open var detailLabel: UILabel = UILabel()
    
    open var type: KKHintViewType = .text
    
    public override init(frame: CGRect) {
        fatalError("do not use this method")
    }
    
    public init(frame: CGRect, type: KKHintViewType) {
        super.init(frame: frame)
        self.type = type
        self.commitInitView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commitInitView() {
        
        self.addSubview(contentView)
        
        contentView.backgroundColor = UIColor.init(white: 0, alpha: 0.85)
        
        contentView.layer.masksToBounds = true
        
        contentView.layer.cornerRadius = 3
        
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        
        detailLabel.textColor = UIColor.white
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.systemFont(ofSize: 15)
        detailLabel.textAlignment = .center
        
        switch self.type {
        case .image:
            self.imageView = UIImageView()
            self.contentView.addSubview(self.imageView)
        case .activityIndicate:
            self.acvtivityView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
            acvtivityView.hidesWhenStopped = true
            acvtivityView.startAnimating()
            self.contentView.addSubview(self.acvtivityView)
        default: break
            
        }
        
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(detailLabel)
    }
    
    open func hide(delay: Int64) {
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + Double(delay * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {[ weak self] in
            
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 0.25, animations: { 
                    self?.alpha = 0
                }, completion: { (finsh) in
                    self?.removeFromSuperview()
                })
            }
            
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.size.width
        
        let height = self.frame.size.height
        
        let maxWidth = width - 2 * 20
        
        
        let tmp1 = self.titleLabel.sizeThatFits(CGSize.init(width: maxWidth - 20, height: 1))
        
        let titleLabelSize = CGSize.init(width: tmp1.width, height: tmp1.height)
        
        
        let tmp2 = self.detailLabel.sizeThatFits(CGSize.init(width: maxWidth - 20 , height: 1))
        
        let detailLabelSize = CGSize.init(width: tmp2.width, height: tmp2.height)
        
        
        var maxY: CGFloat = 0
        
        let contentWidth = max(min(max(tmp1.width + 20, tmp2.width + 20, 0), maxWidth), 80)
        
        if self.type == .image {
            
            self.imageView.sizeToFit()
            
            let imageHeight = self.imageView.frame.size.height
            
            self.imageView.center = CGPoint.init(x: contentWidth / 2.0, y: 10 + imageHeight / 2.0)
            
            maxY = self.imageView.frame.maxY
        } else if self.type == .activityIndicate {
            
            self.acvtivityView.center = CGPoint.init(x: contentWidth / 2.0, y: acvtivityView.frame.size.height / 2.0 + 10)
            
            maxY = self.acvtivityView.frame.maxY
        }
        
        // titleLabel
        
        titleLabel.bounds = CGRect.init(origin: CGPoint(), size: titleLabelSize)
        
        let titleLabelHeight = (self.titleLabel.text ?? "").isEmpty ? 0 : titleLabelSize.height
        
        self.titleLabel.center = CGPoint.init(x: contentWidth / 2.0, y: titleLabelHeight == 0 ? maxY : titleLabelHeight / 2.0 + maxY + 10)
        
        maxY = self.titleLabel.frame.maxY
        
        
        detailLabel.bounds = CGRect.init(origin: CGPoint(), size: detailLabelSize)
        
        let detailLabelHeight = (self.detailLabel.text ?? "").isEmpty ? 0 : detailLabelSize.height
        
        self.detailLabel.center = CGPoint.init(x: contentWidth / 2.0, y: detailLabelHeight == 0 ? maxY : detailLabelHeight / 2.0 + maxY + 10)
        
        maxY = self.detailLabel.frame.maxY + 10
        
        let contentHeight = maxY
        
        self.contentView.bounds = CGRect.init(origin: CGPoint(), size: CGSize.init(width: contentWidth, height: contentHeight))
        
        self.contentView.center = CGPoint.init(x: width / 2.0, y: height / 2.0 + self.yOffset)
        
    }

}






