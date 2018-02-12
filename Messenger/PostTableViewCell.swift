//
//  PostTableViewCell.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import UIKit
import SDWebImage

class PostTableViewCell: UITableViewCell
{    
    @IBOutlet weak var postImageView: UIImageView!
    var viewModel : News?{
        
        didSet {
            postImageView.sd_setImage(with: URL(string : viewModel!.url!))
        }
    }
}
