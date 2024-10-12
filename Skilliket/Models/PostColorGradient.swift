//
//  PostColorGradient.swift
//  Skilliket
//
//  Created by Will on 27/09/24.
//

import UIKit

class PostColorGradient: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let colors = [UIColor.white.cgColor, UIColor.systemIndigo.cgColor] // Cambia los colores según tus necesidades
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)!

        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 0, y: self.bounds.height)
        context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
}
