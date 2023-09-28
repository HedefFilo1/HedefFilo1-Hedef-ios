//
//  ScrollTouchHandler.swift
//  Copilot
//
//  Created by Jamal on 9/28/23.
//

import Foundation
import UIKit

protocol ScrollTouchHandlerDelegate: AnyObject {
    func viewForScroll() -> UIScrollView
}

class ScrollTouchHandler: UIView {
    weak var delegate: ScrollTouchHandlerDelegate?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return delegate?.viewForScroll()
    }
}
