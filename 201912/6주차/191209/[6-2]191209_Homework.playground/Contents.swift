import UIKit

struct User {
    var friends: [Friends] = []
    var blocks: [Friends] = []
}

struct Friends: Equatable {
    let name: String
}

/*
 ↑ User와 Friends 타입은 수정 금지
 ↓ FriendList 타입은 수정 허용
 */

struct FriendList {
    func addFriendUsingInOut(_ user: inout User, name: String) {
        user.friends.append(Friends(name: name))
    }
    
    func blockFriendUsingInOut(_ user: inout User, name: String) {
        let friend = Friends(name: name)
        user.blocks.append(friend)
        if user.friends.contains(friend), let index = user.friends.firstIndex(of: friend) {
            user.friends.remove(at: index)
        }
    }
    
    
    func addFriend(_ user: User, name: String) -> User {
        // 호출 시 해당 이름의 친구를 friends 배열에 추가
        var cpUser = user
        cpUser.friends.append(Friends(name: name))
        return cpUser
    }
    
    func blockFriend(_ user: User, name: String) -> User {
        // 호출 시 해당 이름의 친구를 blocks 배열에 추가
        // 만약 friends 배열에 포함된 친구라면 friends 배열에서 제거
        var cpUser = user
        let friend = Friends(name: name)
        cpUser.blocks.append(friend)
        if cpUser.friends.contains(friend), let index = cpUser.friends.firstIndex(of: friend) {
            cpUser.friends.remove(at: index)
        }
        return cpUser
    }
}


//

var user = User()

var friendList = FriendList()

user = friendList.addFriend(user, name: "원빈")
user = friendList.addFriend(user, name: "장동건")
user = friendList.addFriend(user, name: "정우성")
user.friends   // 원빈, 장동건, 정우성

user = friendList.blockFriend(user, name: "정우성")
user.friends   // 원빈, 장동건
user.blocks    // 정우성


//friendList.addFriendUsingInOut(&user, name: "원빈")
//friendList.addFriendUsingInOut(&user, name: "장동건")
//friendList.addFriendUsingInOut(&user, name: "정우성")
//user.friends
//
//friendList.blockFriendUsingInOut(&user, name: "정우성")
//user.friends
//user.blocks
