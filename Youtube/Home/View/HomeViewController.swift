//
//  HomeViewController.swift
//  Youtube
//
//  Created by user228543 on 10/3/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableViewHome: UITableView!
    lazy var presenter = HomePresenter(delegate: self)
    private var objectList : [[Any]] = []
    private var sectionTitleList : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        Task{
            await presenter.getHomeObjects()
        }
        // Do any additional setup after loading the view.
    }
    
    func configTableView(){
        let nibChannel = UINib(nibName: "\(ChannelCell.self)", bundle: nil)
        tableViewHome.register(nibChannel, forCellReuseIdentifier: "\(ChannelCell.self)")
        let nibVideo = UINib(nibName: "\(VideoCell.self)", bundle: nil)
        tableViewHome.register(nibVideo, forCellReuseIdentifier: "\(VideoCell.self)")
        let nibPlaylist = UINib(nibName: "\(PlaylistCell.self)", bundle: nil)
        tableViewHome.register(nibPlaylist, forCellReuseIdentifier: "\(PlaylistCell.self)")
        
        
        tableViewHome.delegate = self
        tableViewHome.dataSource = self
        tableViewHome.separatorColor = .clear
        
        tableViewHome.contentInset = UIEdgeInsets(top: -15, left: 0, bottom: -80, right: 0)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        
        if velocity < -5{
            navigationController?.setNavigationBarHidden(true, animated: true)
        }else if velocity > 5{
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectList[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectList.count
    }
    
     
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = objectList[indexPath.section]
        if let channel = item as? [ChannelModel.Items]{
            guard let channelCell = tableView.dequeueReusableCell(withIdentifier: "\(ChannelCell.self)", for: indexPath) as? ChannelCell else{
                return UITableViewCell()
            }
            channelCell.configCell(model: channel[indexPath.row])
            return channelCell
        }else   if let playlistsItems = item as? [PlaylistItemsModel.Item]{
            guard let playlistsItemsCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else{
                return UITableViewCell()
            }
            playlistsItemsCell.didTapDotsButton = {
                self.configButtonSheet()
            }
            playlistsItemsCell.configCell(model: playlistsItems[indexPath.row])
            return playlistsItemsCell
        }else if let videos = item as? [VideoModel.Item]{
            guard let videoCell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else{
                return UITableViewCell()
            }
            videoCell.didTapDotsButton = { [weak self] in
                self?.configButtonSheet()
            }
            videoCell.configCell(model: videos[indexPath.row])
            return videoCell
        }else if let playlist = item as? [PlaylistModel.Item]{
            guard let playlistCell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistCell.self)", for: indexPath) as? PlaylistCell else{
                return UITableViewCell()
            }
            playlistCell.didTapDotsButton = { [weak self] in
                self?.configButtonSheet()

            }
            playlistCell.configCell(model: playlist[indexPath.row] )
            return playlistCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleList[section].uppercased()
    }
    
    func configButtonSheet() {
       let vc = BottomSheetViewController()
       vc.modalPresentationStyle = .overCurrentContext
       self.present(vc, animated: false)
   }
}

extension HomeViewController : HomeViewProtocol{
    func getData(list: [[Any]], sectionTitleList : [String]) {
       objectList = list
        self.sectionTitleList = sectionTitleList
        //cargar la informacion
        tableViewHome.reloadData()
    }
        
    }
