struct MyCellModel {
    let number: String
    var isSelected: Bool
}

extension MyCellModel: Equatable {
    static func ==(lhs: MyCellModel, rhs: MyCellModel) -> Bool {
        return lhs.number == rhs.number && lhs.isSelected == rhs.isSelected
    }
}

import UIKit

class SelectLevelCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: SelectLevelCollectionViewCell.self)
    
    private let meriendaFont = UIFont(name: "MeriendaOne-Regular", size: 35)
    var isSelectedLevel: Bool = false
    @IBOutlet weak var numberOfLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        addStrokeToString()
        if isSelectedLevel {
            numberOfLevelLabel.alpha = 1
        } else {
            numberOfLevelLabel.alpha = 0.5
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isSelectedLevel = false
        
    }
    
    private func addStrokeToString() {
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor().hexStringToUIColor(hex: "861CB2"),
            .foregroundColor: UIColor.white,
            .strokeWidth: -3
        ]
        let text = NSAttributedString(string: numberOfLevelLabel.text!, attributes: strokeTextAttributes)
        numberOfLevelLabel.font = meriendaFont
        numberOfLevelLabel.attributedText = text
    }
    
    func set(model: MyCellModel) {
        //numberOfLevelLabel.text = text
        numberOfLevelLabel.text = model.number
        isSelectedLevel = model.isSelected
        
        if isSelectedLevel {
            numberOfLevelLabel.alpha = 1
        } else {
            numberOfLevelLabel.alpha = 0.5
        }
    }

}
