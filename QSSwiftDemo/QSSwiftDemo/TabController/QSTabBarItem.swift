//
//  QSTabBarItem.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/3.
//

import Foundation
import UIKit

public protocol QSTabBarItemProtocol {
    var itemIndex: Int { get }
    var itemWidth: CGFloat { get }
    func config(with index: Int)
    func config(with customWidth: CGFloat)
    func config(with actionBlock: @escaping (Int, Int) -> Void)
    func update(with isHighlight: Bool)
    func setupMaxTextLengthLimit(_ limit: UInt)
}

private class QSTabBarItemElement {
    var font: UIFont?
    var titleColor: UIColor?
    var titleNightColor: UIColor?
    var titleSelectColor: UIColor?
    var titleSelectNightColor: UIColor?
}

public class QSTabBarItem: UIView {
    private var actionBlock: ((Int, Int) -> Void)?
    private var isHighlight: Bool = false
    private var customWidth: CGFloat = 0
    private var hasWidth = false
    private var autoWidth: CGFloat = 0
    private var index: Int = 0
    private var limit: UInt = 0
    private var titleAttriStr: NSMutableAttributedString?
    private var subtitleAttriStr: NSMutableAttributedString?
    private lazy var titleElement = QSTabBarItemElement()
    private lazy var subtitleElement = QSTabBarItemElement()
    private lazy var contentLabel = UILabel()
    private var disableTheme = false
    private var isDarkTheme: Bool {
        return false
    }
    
    // MARK: init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: override
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentLabel.frame = self.bounds
    }
    
    // MARK: private
    
    private func setupSubviews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
        self.addGestureRecognizer(tapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickAction(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTapGesture)
        
        contentLabel.textAlignment = .center
        self.addSubview(contentLabel)
    }
    
    private func contentTitleAttributedString() -> NSMutableAttributedString {
        let attributedTitle = NSMutableAttributedString()
        if titleAttriStr != nil {
            let attributes = [
                NSAttributedString.Key.font: titleElement.font ?? UIFont.systemFont(ofSize: 13),
                NSAttributedString.Key.strokeColor: currentTextColor(isTitle: true)
            ]
            titleAttriStr!.addAttributes(attributes, range: NSRange(location: 0, length: titleAttriStr!.length))
            attributedTitle.append(titleAttriStr!)
        }
        if subtitleAttriStr != nil {
            let attributes = [
                NSAttributedString.Key.font: subtitleElement.font ?? UIFont.systemFont(ofSize: 10),
                NSAttributedString.Key.strokeColor: currentTextColor(isTitle: false)
            ]
            subtitleAttriStr!.addAttributes(attributes, range: NSRange(location: 0, length: subtitleAttriStr!.length))
            attributedTitle.append(subtitleAttriStr!)
        }
        return attributedTitle
    }
    
    private func contentTitleWidth() -> CGFloat {
        if customWidth > 0 {
            return customWidth
        }
        if hasWidth {
            return autoWidth
        }
        hasWidth = true
        let attributedText = contentTitleAttributedString()
        autoWidth = attributedText.boundingRect(with: CGSize(width: 0, height: 20.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).width
        return autoWidth
    }
    
    private func currentTextColor(isTitle: Bool) -> UIColor {
        let textElement = isTitle ? titleElement : subtitleElement;
        let isValidDarkTheme = isDarkTheme && !disableTheme;
        if (isHighlight) {
            if (isValidDarkTheme) {
                // 高亮夜间模式
                return textElement.titleSelectNightColor ?? UIColor.systemPink
            } else {
                // 高亮白色主题
                return textElement.titleSelectColor ?? UIColor.systemPink
            }
        } else {
            if (isValidDarkTheme) {
                // 未选中夜间模式
                return textElement.titleNightColor ?? UIColor.black
            } else {
                // 未选中白色主题
                return textElement.titleColor ?? UIColor.black
            }
        }
    }
    
    // MARK: evnents
    @objc
    private func clickAction(_ tap: UITapGestureRecognizer) {
        self.actionBlock?(itemIndex, (tap.numberOfTapsRequired == 2) ? 2 : 1)
    }
}

extension QSTabBarItem {
    public func config(title: String?, subtitle: String?) {
        hasWidth = false
        var hasTitle = false
        if title != nil {
            hasTitle = true
            titleAttriStr = NSMutableAttributedString(string: title!)
        } else {
            titleAttriStr = nil;
        }
        if subtitle != nil {
            let blankStr = hasTitle ? " " : ""
            subtitleAttriStr = NSMutableAttributedString(string: "\(blankStr)\(subtitle!)")
        } else {
            subtitleAttriStr = nil
        }
        contentLabel.attributedText = contentTitleAttributedString()
        self.setNeedsLayout()
    }
    
    public func config(titleFont: UIFont?, subtitleFont: UIFont?) {
        hasWidth = false
        titleElement.font = titleFont ?? UIFont.systemFont(ofSize: 13)
        subtitleElement.font = subtitleFont ?? UIFont.systemFont(ofSize: 10)
        self.setNeedsLayout()
    }
    
    public func config(titleColor: UIColor?, isNight: Bool) {
        if isNight {
            titleElement.titleNightColor = titleColor
        } else {
            titleElement.titleColor = titleColor
        }
    }
    
    public func config(subtitleColor: UIColor?, isNight:Bool) {
        if isNight {
            subtitleElement.titleNightColor = subtitleColor
        } else {
            subtitleElement.titleColor = subtitleColor
        }
    }
    
    public func configHightlight(titleColor: UIColor?, isNight: Bool) {
        if isNight {
            titleElement.titleSelectNightColor = titleColor
        } else {
            titleElement.titleSelectColor = titleColor
        }
    }
    
    public func configHightlight(subtitleColor: UIColor?, isNight: Bool) {
        if isNight {
            subtitleElement.titleSelectNightColor = subtitleColor
        } else {
            subtitleElement.titleSelectColor = subtitleColor
        }
    }
}

extension QSTabBarItem : QSTabBarItemProtocol {
    public var itemIndex: Int {
        index
    }
    public var itemWidth: CGFloat {
        contentTitleWidth()
    }
    
    public func config(with index: Int) {
        self.index = index
    }
    
    public func config(with customWidth: CGFloat) {
        self.customWidth = customWidth
    }
    
    public func config(with actionBlock: @escaping (Int, Int) -> Void) {
        self.actionBlock = actionBlock;
    }
    
    public func update(with isHighlight: Bool) {
        self.isHighlight = isHighlight
        self.setNeedsLayout()
    }
    
    public func setupMaxTextLengthLimit(_ limit: UInt) {
        self.limit = limit
    }
}
