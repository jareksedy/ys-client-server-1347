//
//  FriendsTableViewCell.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 27.08.2021.
//

import UIKit
import Alamofire

protocol CellUpdater: AnyObject {
    func updateTableView()
}

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendImage: RoundedImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendMenuButton: UIButton!
    @IBOutlet weak var friendOnlineStatus: UILabel!
    
    var parentVC: UIViewController!
    weak var delegate: CellUpdater?

    func update() {
        delegate?.updateTableView()
    }
    
    func makeFriendMenu(_ viewModel: FriendViewModel) -> UIMenu {
        
        var actions = [UIAction]()
        
        actions.append(UIAction(title: "Удалить из друзей",
                                image: UIImage(systemName: "trash"),
                                attributes: .destructive,
                                handler: {_ in self.removeFromFriends(viewModel) }))
        
        return UIMenu(children: actions)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendMenuButton.showsMenuAsPrimaryAction = true
    }
    
    override func prepareForReuse() {
        friendImage.image = nil
    }
    
    func configure(with viewModel: FriendViewModel) {
        friendMenuButton.menu = makeFriendMenu(viewModel)
        friendName.text = viewModel.fullName
        friendOnlineStatus.text = viewModel.lastSeen
        friendOnlineStatus.textColor = viewModel.statusColor
        friendImage.asyncLoadImageUsingCache(withUrl: viewModel.imageUrl)
    }
    
    private func removeFromFriends(_ viewModel: FriendViewModel) {
        
        let friendAPI = FriendAPI()
        let api = FriendAPIProxy(friendAPI: friendAPI)
        
        let alert = UIAlertController(title: "Удалить из друзей?", message: "\(viewModel.fullName) будет удален из списка ваших друзей. Вы уверены?", preferredStyle: .alert)
        
        let successAlert = UIAlertController(title: "Удалить из друзей",
                                             message: "\(viewModel.fullName) успешно удален из списка ваших друзей!",
                                             preferredStyle: .alert)
        
        successAlert.addAction(UIAlertAction(title: "Отлично!", style: .default, handler: nil))
        
        let errorAlert = UIAlertController(title: "Ошибка удаления",
                                           message: "Не удалось удалить \(viewModel.fullName) из списка ваших друзей!",
                                           preferredStyle: .alert)
        
        errorAlert.addAction(UIAlertAction(title: "Хорошо!", style: .default, handler: nil))
        
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {_ in
            
            api.removeFromFriends(viewModel.id) { [weak self] friendDelete in
                guard self != nil else { return }
                if friendDelete?.response.success == 1 {
                    self?.parentVC.present(successAlert, animated: true)
                    self?.update()
                } else {
                    self?.parentVC.present(errorAlert, animated: true)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        parentVC.present(alert, animated: true)
        
    }
}
