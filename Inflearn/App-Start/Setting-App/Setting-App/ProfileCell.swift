//
//  ProfileCell.swift
//  Setting-App
//
//  Created by supaja on 2022/12/25.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var topTitle: UILabel!
    
    @IBOutlet weak var bottomDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 이미지 rounded 효과 주기
        let profileHeight: CGFloat = 60
        profileImageView.layer.cornerRadius = profileHeight / 2
        
        //topTitle style
        topTitle.textColor = .blue
        topTitle.font = UIFont.systemFont(ofSize: 20)
        
        //bottomDescription style
        bottomDescription.textColor = .darkGray
        bottomDescription.font = UIFont.systemFont(ofSize: 16)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
}
