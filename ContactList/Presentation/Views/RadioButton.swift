import UIKit

class RadioButton: UIButton {
    weak var delegate: RadioButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        isSelected = false
        tintColor = .customLightGray
        showsTouchWhenHighlighted = false
        setImage(UIImage(named: "radioButton"), for: .normal)
        self.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }

    @objc private func buttonTapped() {
        isSelected.toggle()
        tintColor = .customBlue
        setImage(UIImage(
            named: "selectedRadioButton"),
                 for: .selected
        )
        delegate?.radioButtonSelected(self)
    }
}
