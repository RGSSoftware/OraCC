import Foundation
import JSQMessagesViewController

class MessageCellOutgoing: JSQMessagesCollectionViewCell{
    override func awakeFromNib() {
        messageBubbleTopLabel?.textAlignment = .right
        cellBottomLabel?.textAlignment = .right
    }
}

