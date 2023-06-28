//
//  FacilityTableViewCell.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//
import UIKit

class FacilityTableViewCell: UITableViewCell {
	
	var option: Option?
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var selectButton: UIButton!
	
	var isCellSelected: Bool = false {
		didSet {
			updateButtonState()
		}
	}
	
	var selectButtonTapped: (() -> Void)?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		selectButton.addTarget(self, action: #selector(selectButtonAction), for: .touchUpInside)
	}
	
	func configure(with option: Option) {
		self.option = option
		nameLabel.text = option.name
		iconImageView.image = UIImage(named: option.icon)
		updateButtonState()
	}
	
	func updateButtonState() {
		let title = isCellSelected ? "Selected" : "Select"
		selectButton.setTitle(title, for: .normal)
	}
	
	@objc func selectButtonAction() {
		selectButtonTapped?()
	}
}
