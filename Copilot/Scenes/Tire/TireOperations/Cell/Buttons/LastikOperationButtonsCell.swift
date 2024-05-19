//
//  LastikOperationButtonsCell.swift
//  Copilot
//
//  Created by Jamal on 1/17/24.
//

import UIKit

protocol LastikOperationButtonsCellDelegate: AnyObject {
    func goToRequestNewLastik()
    func goToLastikRandevu()
    func didTapChange()
}

class LastikOperationButtonsCell: UICollectionViewCell, Reusable {
    
    weak var delegate: LastikOperationButtonsCellDelegate?
    @IBOutlet weak var requestNewButton: CPLightButton?
    @IBOutlet weak var randevuButton: CPLightButton!
    @IBOutlet weak var changeButton: CPLightButton!
    
    var shouldRemoveNewButton: Bool = false {
        didSet {
            if shouldRemoveNewButton {
                requestNewButton?.removeFromSuperview()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        requestNewButton?.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.request.new.tire.button"), for: .normal)
        randevuButton.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.request.tire.damage.appointment.button"), for: .normal)
        changeButton.setTitle(App.getString(key: "copilotapp.servicetire.tire.operation.request.tire.change.appointment.button"), for: .normal)
    }
    
    @IBAction func didTapRequestNew() {
        delegate?.goToRequestNewLastik()
    }
    
    @IBAction func didTapRandevu() {
        delegate?.goToLastikRandevu()
    }
    
    @IBAction func didTapChange() {
        delegate?.didTapChange()
    }
}
