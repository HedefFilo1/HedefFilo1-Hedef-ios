//
//  UIImage+EXT.swift
//
//  Created by Jamal on 8/23/23.
//

import Foundation
import SDWebImage

extension UIImageView {
    func loadImageFrom(url: String?) {
        guard let url = url else { return }
        sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "AppIcon"))
    }
}
