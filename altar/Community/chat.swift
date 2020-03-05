//
//  chat.swift
//  altar
//
//  Created by Juan Moreno on 1/14/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation


struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
   }
}
extension Chat {
        init?(dictionary: [String:Any]) {
            guard let chatUsers = dictionary["users"] as? [String] else {return nil}
            self.init(users: chatUsers)
    }
}


// CHAT ES UNA COLLECION QUE TIENE UN ARRAY DE USUARIOS
//Firebase Structure:
//Our firebase structure will be:
//|- Chats (Collection)
//| — AutoID (Document)
//| —- users (Field {Array})
//| —- thread(Collection)
//| — — AutoID (Document)
//| — —- content (Field {String})
//| — —- created (Field {DateTime})
//| — —- id (Field {String})
//| — —- senderID (Field {String})
//| — —- senderName (Field {String})

//As per the firebase structure mentioned in above section a chat object consist of a collection and an array.

//We are not looking at the collection thread as it’ll be fetched separately. So in this class we have a variable called users which is a String array and a variable named dictionary which is returning a dictionary of the chat object i.e. users array.

// In a thread there will be auto id documents and each document will have one message with information like content of the message, when it was created, a random ID just to differentiate duplication of messages, id of person who have sent it in senderID and senderName contains the name of the person which have sent it.


// A Message will contain one document of thread collection and a thread document has fields i.e. content, created etc.
//We’ll do the same as we did with Chat.swift we create a struct:
//struct Message {
//var id: String
//var content: String
//var created: Timestamp
//var senderID: String
//var senderName: String
//


//MessageKit requires implementation of MessageType as it is required to tell message kit what type of chat we are implementing. In our case we are just implementing text based chat. So in order to handle that we’ll add another extension of Message class as:
//extension Message: MessageType {
//var sender: SenderType {
//return Sender(id: senderID, displayName: senderName)
//    }
//var messageId: String {
//return id
//    }
//var sentDate: Date {
//return created.dateValue()
//    }
//var kind: MessageKind {
//return .text(content)
//    }
//}


// Make sure you have the information of the person you are chatting with. I’m referring to you as currentUser and the person you are chatting with as User2.



//I've fetched the profile of user 2 in previous class from which //I'm navigating to chat view. So make sure you have the following //three variables information when you are on this class.
// FUERON FECHADOS CUANDO SACAMOS LOS USUARIOS AMIGOS Y A QUIEN HCIMOS CLICK
//var user2Name: String?
//var user2ImgUrl: String?
//var user2UID: String?


