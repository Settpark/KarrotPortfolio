//
//  UIImage+.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/5/25.
//

import UIKit

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { context in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
