//
//  ChatViewController.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/11/22.
//

import Foundation
import MessageKit
import InputBarAccessoryView
import UIKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
    
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
    static var messages = [MessageType]()
    
}

class ChatViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "Bob")
    
    let otherUser = Sender(senderId: "friend", displayName: "Ogi")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Message.messages.append(Message(sender: otherUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hey,  how is it going?")))
        
        Message.messages.append(Message(sender: currentUser,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-70400),
                                kind: .text("not bad, how about you? ")))
        
        Message.messages.append(Message(sender: otherUser,
                                messageId: "3",
                                sentDate: Date().addingTimeInterval(-56400),
                                kind: .text("pretty good, getting ready to go out to grab beer with Joseph. You wanna join?")))
        
        Message.messages.append(Message(sender: currentUser,
                                messageId: "4",
                                sentDate: Date().addingTimeInterval(-36400),
                                kind: .text("it would be awesome but I have an assignment due tomorrow")))
                                
        Message.messages.append(Message(sender: otherUser,
                                messageId: "5",
                                sentDate: Date().addingTimeInterval(-26400),
                                kind: .text("...")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            self.messageInputBar.inputTextView.becomeFirstResponder()
        }
        
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
                return isFromCurrentSender(message: message) ? UIColor.systemBlue : UIColor.darkGray
    }
        
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
            return UIColor.white
    }
        
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(
            string: MessageKitDateFormatter.shared.string(from: message.sentDate),
            attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.gray])    }
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return Message.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return Message.messages.count
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        Message.messages.append(Message(sender: currentUser, messageId: "6", sentDate: Date.now, kind: .text(text)))
        

    }
}

