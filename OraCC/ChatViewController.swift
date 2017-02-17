import UIKit
import Moya
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    var chatId: Int!
    
    var provider: RxMoyaProvider<OraAPI>!
    lazy var viewModel: ChatMessagesViewModel = {
        return ChatMessagesViewModel(chatId: self.chatId!, provider: self.provider)
    }()
    
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bubbleBackgroundColor = UIColor.init(white: 0.94, alpha: 1)
        
        incomingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero, layoutDirection: UIApplication.shared.userInterfaceLayoutDirection).incomingMessagesBubbleImage(with: bubbleBackgroundColor)
        outgoingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero, layoutDirection: UIApplication.shared.userInterfaceLayoutDirection).outgoingMessagesBubbleImage(with: bubbleBackgroundColor)
        
        collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        
        automaticallyScrollsToMostRecentMessage = true
        
        //Hacks
        inputToolbar.isHidden = true
        additionalContentInset.bottom = -44
        additionalContentInset.top = 64.0
        
        viewModel.loadCurrentPage()
        
        self.collectionView?.reloadData()
        self.collectionView?.layoutIfNeeded()
        
        collectionView?.register(MessageCellOutgoing.nib(), forCellWithReuseIdentifier: MessageCellOutgoing.cellReuseIdentifier())
        collectionView?.register(MessageCellIngoing.nib(), forCellWithReuseIdentifier: MessageCellIngoing.cellReuseIdentifier())
    }
    
    override func senderId() -> String {
        return String(User.currentUser()!.id)
        
    }
    
    override func senderDisplayName() -> String {
        return String(User.currentUser()!.name)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.numberOfMessages)
        return viewModel.numberOfMessages
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        let user = viewModel.userForIndex(indexPath)
        return JSQMessage(senderId: String(user.id), displayName: user.name, text: viewModel.messageBodyForIndex(indexPath))
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        
        return outgoingBubble
    }
    
     override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForCellBottomLabelAt indexPath: IndexPath) -> NSAttributedString?{
        
        let user = viewModel.userForIndex(indexPath)
        
        return NSAttributedString(string: user.name)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForCellBottomLabelAt indexPath: IndexPath) -> CGFloat{
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForCellTopLabelAt indexPath: IndexPath) -> CGFloat {
        return 0.0
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
        
        return 0.0
    }

}
