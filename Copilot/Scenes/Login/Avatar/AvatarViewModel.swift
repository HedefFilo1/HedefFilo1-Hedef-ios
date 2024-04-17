//
//  AvatarViewModel.swift
//  Copilot
//
//  Created by Jamal on 11/13/23.
//

import Foundation

struct Avatar {
    let image: String
    var selected = false
}

protocol AvatarViewModelCoordinatorDelegate: AnyObject {
    func loginDidFinish()
}

protocol AvatarViewModelDelegate: AnyObject {
    
}

protocol AvatarViewModelType: AnyObject {
    var coordinatorDelegate: AvatarViewModelCoordinatorDelegate? { get set }
    var delegate: AvatarViewModelDelegate? { get set }
    var avatars: [Avatar]? { get set }
    var email: String { get set }
    func selectAvatar(name: String)
    func loginDidFinish()
}

class AvatarViewModel: AvatarViewModelType {
    
    weak var coordinatorDelegate: AvatarViewModelCoordinatorDelegate?
    weak var delegate: AvatarViewModelDelegate?
    var email: String = ""
    
    var avatars: [Avatar]? = [
        Avatar(image: "avatar1"),
        Avatar(image: "avatar2"),
        Avatar(image: "avatar3"),
        Avatar(image: "avatar4")
    ]
    
    func selectAvatar(name: String) {
        Persistence.avatarSelected = email
        Persistence.avatarName = name
        APIService.addUserAction(pageName: "Choose Avatar", actionName: "CHOOSE_AVATAR")
        coordinatorDelegate?.loginDidFinish()
    }
    
    func loginDidFinish() {
        coordinatorDelegate?.loginDidFinish()
    }
}
