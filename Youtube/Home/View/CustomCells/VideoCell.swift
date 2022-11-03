//
//  VideoCell.swift
//  Youtube
//
//  Created by user228543 on 10/6/22.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var dotsImage: UIImageView!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    var didTapDotsButton : (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
        
    }
    func configView(){
        dotsImage.image = UIImage(named: "dots")?.withRenderingMode(.alwaysTemplate)
        dotsImage.tintColor = UIColor(named: "grayColor")
        selectionStyle = .none
    }
    
    @IBAction func dotsButtonTap(_ sender: Any) {
        if let tap = didTapDotsButton{
            tap()
        }
    }
    
    func configCell(model : Any){
        
        if let video = model as? VideoModel.Item{
            if let imageUrl = video.snippet?.thumbnails.medium?.url, let url = URL(string: imageUrl){
                videoImage.kf.setImage(with: url)
            }
            videoName.text = video.snippet?.title ?? ""
            channelName.text = video.snippet?.channelTitle ?? ""
            viewsCountLabel.text = "\(video.statistics?.viewCount ?? "0") views * 3 months ago"

        }else if let playlistItems = model as? PlaylistItemsModel.Item{
            if let imageUrl = playlistItems.snippet.thumbnails.medium?.url, let url = URL(string: imageUrl){
                videoImage.kf.setImage(with: url)
            }
            videoName.text = playlistItems.snippet.title ?? ""
            channelName.text = playlistItems.snippet.channelTitle ?? ""
            viewsCountLabel.text = "332 views  views * 3 months ago"
            
        }
    }
}
