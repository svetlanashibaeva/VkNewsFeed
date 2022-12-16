//
//  GradientView.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 16.12.2022.
//

import UIKit

class GradientView: UIView {
    
//    private var startColor: UIColor = .blue
//    private var endColor: UIColor = .yellow
    
    private var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
}
