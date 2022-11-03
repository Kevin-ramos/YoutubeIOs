//
//  ChannelCell.swift
//  Youtube
//
//  Created by user228543 on 10/6/22.
//

import UIKit
import Kingfisher
class ChannelCell: UITableViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var subscrubeLabel: UILabel!
    @IBOutlet weak var bellImage: UIImageView!
    @IBOutlet weak var subscriberNumbersLabel: UILabel!
    @IBOutlet weak var channelInfoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView() {
        // Initialization code
        bellImage.image = UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate)
        bellImage.tintColor = UIColor(named: "grayColor")
        profileImage.layer.cornerRadius = 51/2
        selectionStyle = .none

    }

    func configCell(model : ChannelModel.Items){    
        channelInfoLabel.text = model.snippet.description
        channelTitle.text = model.snippet.title
        subscriberNumbersLabel.text = "\(model.statistics?.subscriberCount ?? "0") subscribers * \(model.statistics?.viewCount ?? "0") videos"
        
        if let bannerUrl = model.brandingSettings?.image.bannerExternalUrl, let url = URL(string: bannerUrl){
            bannerImage.kf.setImage(with: url)
        }
        
        let imageUrl = model.snippet.thumbnails.medium.url
        
        guard let url = URL(string: imageUrl) else{
            return
        }
        profileImage.kf.setImage(with: url)
    }
    
}
