//
//  ChatViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/14/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage


//protocol UpdateMsgDelegate {
//  func whoNeedsUpdate(value: String)
//}



class ChatViewController: MessagesViewController,InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    var currentUser  = Auth.auth().currentUser!
    private var docReference: DocumentReference?
    var messages: [Message] = []
    //I've fetched the profile of user 2 in previous class from which //I'm navigating to chat view. So make sure you have the following //three variables information when you are on this class.
    var user2Name: String?
    var user2ImgUrl: String?
    var user2UID: String?
    
 //   var delegate: UpdateMsgDelegate?
    // -------------------------------------- messses data soruce
    func currentSender() -> SenderType {
        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        if messages.count == 0 {
            print("There are no messages")
            return 0
        } else {
            return messages.count
        }
    }
    
    // ----------------------------------
    
    // ------------------------------- message loayot delegate --------------
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    //Explore this delegate to see more functions that you can implement but for the purpose of this tutorial I've just implemented one function.
    
    
    //Background colors of the bubbles
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? advengers.shared.colorBlue: advengers.shared.colorOrange
    }
    //THis function shows the avatar
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        //If it's current user show current user photo.
        if message.sender.senderId == currentUser.uid {
            let foto = URL(string: advengers.shared.currenUSer["photoURL"] as! String)
            SDWebImageManager.shared.loadImage(with: foto, options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                avatarView.image = image
            }
        } else {
            SDWebImageManager.shared.loadImage(with: URL(string: user2ImgUrl!), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                avatarView.image = image
            }
        }
    }
    //Styling the bubble to have a tail
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    
    // --------------------
    
    
    
    func loadChat() {
        //Fetch all the chats which has current user in it
        
       
      
        
        
        let db = Firestore.firestore().collection("Chats").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
        db.getDocuments { (chatQuerySnap, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                //Count the no. of documents returned
                guard let queryCount = chatQuerySnap?.documents.count else {
                    return
                }
                if queryCount == 0 {
                    //If documents count is zero that means there is no chat available and we need to create a new instance
                    self.createNewChat()
                }
                else if queryCount >= 1 {
                    
                    // BORRO LO QUE LEI
                    
                    
                    let diction = [self.user2UID!: 0]
                          
                          Database.database().reference().child("users").child( Auth.auth().currentUser!.uid).child("inbox").updateChildValues(diction)
                          { (err, ref) in
                              if let err = err {
                                  self.navigationItem.rightBarButtonItem?.isEnabled = true
                                  print("Failed to save post to DB", err)
                                  return
                              }
                              
                              print("Successfully saved post to DB")
                          
                            
                            var diction2 = advengers.shared.currenUSer["inbox"] as! [String:Int]
                            diction2.updateValue(0, forKey: self.user2UID!)
                                                //   let diction = [chat.user2UID: 0]
                                                 //  Database.database().reference().child("users").child( Auth.auth().currentUser!.uid).child("inbox").updateChildValues(diction2)
                                                 //  accountHelper.fetchUserInfo()
                                                 //  tableView.reloadRows(at: [indexPath], with: .automatic)
                                               
                                               
                                                   print("LLEGO AQUI en reloadDataChats" )
                                                   print(diction2)
                                          
                                          
                         //   let queUsuario = ["usuario2UID" : self.user2UID!]
                      //    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateMSG"), object: nil, userInfo: queUsuario)
                            
                            //  self.delegate?.whoNeedsUpdate(value: self.user2UID!)
                             // self.dismiss(animated: true, completion: nil)
                          }
                    
                    // -------------------
                    
                    
                    
                    //Chat(s) found for currentUser
                    for doc in chatQuerySnap!.documents {
                        let chat = Chat(dictionary: doc.data())
                        //Get the chat which has user2 id
                        if (chat?.users.contains(self.user2UID!))! {
                            self.docReference = doc.reference
                            //fetch it's thread collection
                            doc.reference.collection("thread")
                                .order(by: "created", descending: false)
                                .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
                                    if let error = error {
                                        print("Error: \(error)")
                                        return
                                    } else {
                                        self.messages.removeAll()
                                        for message in threadQuery!.documents {
                                            let msg = Message(dictionary: message.data())
                                            self.messages.append(msg!)
                                            // print("Data: \(msg?.content ?? "No message found")")
                                        }
                                        self.messagesCollectionView.reloadData()
                                        self.messagesCollectionView.scrollToBottom(animated: true)
                                    }
                                })
                            return
                        } //end of if
                    } //end of for
                    self.createNewChat()
                } else {
                    print("Let's hope this error never prints!")
                }}}}
    
    func createNewChat() {
        let users = [self.currentUser.uid, self.user2UID]
        let data: [String: Any] = [
            "users":users
        ]
        let db = Firestore.firestore().collection("Chats")
        db.addDocument(data: data) { (error) in
            if let error = error {
                print("Unable to create chat! \(error)")
                return
            } else {
                self.loadChat()
            }
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        //add the message to the messages array and reload it
        messages.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    private func save(_ message: Message) {
        //Preparing the data as per our firestore collection
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName
        ]
        //Writing it to the thread using the saved document reference we saved in load chat function
        docReference?.collection("thread").addDocument(data: data, completion: { (error) in
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            self.messagesCollectionView.scrollToBottom()
            
            
          //  let newMesg = [self.currentUser:1]
            
            let diction = [Auth.auth().currentUser?.uid: 1]
            
            Database.database().reference().child("users").child(self.user2UID!).child("inbox").updateChildValues(diction) { (err, ref) in
                if let err = err {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Failed to save post to DB", err)
                    return
                }
                
                print("Successfully saved post to DB")
               // self.dismiss(animated: true, completion: nil)
            }

        })
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        //When use press send button this method is called.
        let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser.uid, senderName: currentUser.displayName ?? advengers.shared.currenUSer["name"]! as! String)
        //calling function to insert and save message
        insertNewMessage(message)
        save(message)
        //clearing input field
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = user2Name ?? "Chat"
        navigationItem.largeTitleDisplayMode = .never
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .blue
        messageInputBar.sendButton.setTitleColor(.blue, for: .normal)
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        loadChat()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
