//
//  SearchCell.swift
//  Copilot
//
//  Created by Jamal on 10/10/23.
//

import UIKit

class SearchCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var textField: CPSearchTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let text = App.getString(key: "copilotapp.homepage.button_search") ?? Strings.searchFilter
        textField.setPlaceholder(title: text)
    }
}
