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
        guard let reuseBag = reuseBag else { return }
        guard let viewModel = viewModel else { return }
        
        textField.rx.text.bindTo(viewModel.value).addDisposableTo(reuseBag)
        
        label.text = viewModel.label
        textField.placeholder = viewModel.placeholder
    }
}
