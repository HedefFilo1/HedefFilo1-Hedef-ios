//
//  RequestsCell.swift
//  Copilot
//
//  Created by Jamal on 3/4/24.
//

import UIKit

class RequestsCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
    }
    
    func setup() {
        label.apply(.blackS14R400)
    }

}
