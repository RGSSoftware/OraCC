import UIKit
import SnapKit

import RxSwift
import RxCocoa

class FieldCell: UITableViewCell {
    
    var label: UILabel!
    var textField: UITextField!
    
    var reuseBag: DisposeBag?
    
    var viewModel: FieldViewModel! {
        didSet {
          setupSubscriptions()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupSubscriptions()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupSubscriptions()
    }
    
    func setup() {
        label = UILabel()
        
        textField = UITextField()
        textField.borderStyle = .none
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        contentView.addSubview(label)
        contentView.addSubview(textField)
        
        label.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints{ make in
            make.left.equalTo(label.snp.right).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
     func setupSubscriptions() {
        
        reuseBag = DisposeBag()
        guard let viewModel = viewModel else { return }
        
        textField.text = nil
        textField.text = viewModel.value.value
        
        label.text = viewModel.label
        textField.placeholder = viewModel.placeholder
        textField.isSecureTextEntry = viewModel.isSecure
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        viewModel.value.value = textField.text
    }
}

extension FieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
