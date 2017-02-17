import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel: ChatViewModel! {
        didSet {
            setupSubscriptions()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subTitleLabel?.textColor = OraBrand.mainColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubscriptions()
    }

    override func prepareForReuse() {
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        
        guard let viewModel = viewModel else { return }
//        titleLabel.text = viewModel.
        subTitleLabel.text = viewModel.subTitle
        messageLabel.text = viewModel.message
        
    }
}
