//
//  UserInfoViewController.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var userImage: RoundedImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    
    private let api = UserAPI()
    
    private let viewModelFactory = UserViewModelFactory()
    private var viewModel: UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.get { [weak self] user in
            guard let self = self, let user = user else { return }
            self.viewModel = self.viewModelFactory.constructViewModels(from: user)
            display(viewModel: self.viewModel!)
        }
    }
    
    // MARK: - Private methods.
    
    private func display(viewModel: UserViewModel) {
        userName.text = viewModel.fullName
        userLocation.text = viewModel.location
        userImage.asyncLoadImageUsingCache(withUrl: viewModel.userImageUrl)
    }
}
