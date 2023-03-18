import UIKit

class RadioButton: UIButton {
//    override var isSelected: Bool {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
    var delegate: SortListTableViewControllerDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear
        tintColor = .customLightGray
        setImage(UIImage(named: "radioButton"), for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        //isSelected.toggle()
        backgroundColor = .clear
        tintColor = .customBlue
        setImage(UIImage(named: "selectedRadioButton"), for: .normal)
        delegate?.switchButton()
    }
}
