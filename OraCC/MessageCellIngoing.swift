import Foundation
import JSQMessagesViewController

class MessageCellIngoing: JSQMessagesCollectionViewCell{
    override func awakeFromNib() {
        messageBubbleTopLabel?.textAlignment = .left
        cellBottomLabel?.textAlignment = .left
    }
}

