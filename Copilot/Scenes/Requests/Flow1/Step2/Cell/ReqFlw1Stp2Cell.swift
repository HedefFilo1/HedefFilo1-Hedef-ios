//
//  ReqFlw1Stp2Cell.swift
//  Copilot
//
//  Created by Jamal on 3/5/24.
//

import UIKit

class ReqFlw1Stp2Cell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var checkBox: CPCheckBox!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
    }
    
    func setup() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.disabled.cgColor
        label.apply(.custom(.black, .regular, 16))
    }

}
