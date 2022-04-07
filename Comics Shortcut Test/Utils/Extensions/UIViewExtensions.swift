//
//  UIViewExtensions.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/6/22.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ self.addSubview($0) })
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach({ self.addSubview($0) })
    }
}

extension UIView {
    @discardableResult
    func heightAnchor(constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func heightAnchor(equalTo anchor: NSLayoutDimension, constant: CGFloat = .zero) -> Self {
        heightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func heightAnchor(equalTo anchor: NSLayoutDimension, multiplier: CGFloat) -> Self {
        heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult
    func heightAnchor(lessThanOrEqualTo: NSLayoutDimension, multiplier: CGFloat,  constant: CGFloat) -> Self {
        heightAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, multiplier: multiplier, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func heightAnchor(lessThanOrEqualToConstant: CGFloat) -> Self {
        heightAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualToConstant).isActive = true
        return self
    }
    
    @discardableResult
    func heightAnchor(greaterThanOrEqualToConstant: CGFloat) -> Self {
        heightAnchor.constraint(greaterThanOrEqualToConstant: greaterThanOrEqualToConstant).isActive = true
        return self
    }
    
    @discardableResult
    func widthAnchor(constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func widthAnchor(equalTo anchor: NSLayoutDimension, constant: CGFloat = .zero) -> Self {
        widthAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func widthAnchor(lessThanOrEqualToConstant: CGFloat) -> Self {
        widthAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualToConstant).isActive = true
        return self
    }
    
    @discardableResult
    func widthAnchor(greaterThanOrEqualToConstant: CGFloat) -> Self {
        widthAnchor.constraint(greaterThanOrEqualToConstant: greaterThanOrEqualToConstant).isActive = true
        return self
    }
    
    @discardableResult
    func topAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func bottomAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func leadingAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func trailingAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func centerXAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero) -> Self {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    @discardableResult
    func centerYAnchor(equalTo anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero) -> Self {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
}

extension UIView {
    func constrainCentered(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let verticalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        let horizontalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0)
        let heightContraint = NSLayoutConstraint(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.height)
        let widthContraint = NSLayoutConstraint(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.width)
        addConstraints([
            horizontalContraint,
            verticalContraint,
            heightContraint,
            widthContraint])
    }
    func constrainToEdges(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
}
