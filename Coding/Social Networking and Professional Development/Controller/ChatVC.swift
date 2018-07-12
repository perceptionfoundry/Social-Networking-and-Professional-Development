//
//  ChatVC.swift
//  Social Networking and Professional Development
//
//  Created by Syed ShahRukh Haider on 12/07/2018.
//  Copyright © 2018 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class ChatVC: JSQMessagesViewController {

    var message = [JSQMessage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = Auth.auth().currentUser
        self.senderId = "1"
        self.senderDisplayName = "shahrukh"
        
        inputToolbar.contentView.leftBarButtonItem.isHidden = true
        inputToolbar.contentView.leftBarButtonItemWidth = 0.0
        

    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        
        print("did press send")
        print("\(text)")
        
        print(self.senderDisplayName)
        print(self.senderId)
        
        message.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
        collectionView.reloadData()
        print(message)
        self.finishSendingMessage()
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        print("did press accessory")
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return message.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return message[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubble = JSQMessagesBubbleImageFactory()
        
        let message = self.message[indexPath.item]
        
        
        if message.senderId == senderId{
            return bubble?.outgoingMessagesBubbleImage(with: .blue)

            
        }
        else{
        return bubble?.outgoingMessagesBubbleImage(with: .green)
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }

}
