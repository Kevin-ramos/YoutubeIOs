//
//  MainViewController.swift
//  Youtube
//
//  Created by user228543 on 10/3/22.
//

import UIKit

class MainViewController: BaseViewController, TabsViewProtocol {
    func didSelectOption(index: Int) {
        print(options[index])
        let currenCell = tabsView.collectionView.cellForItem(at: IndexPath(item: index, section: 0))!
        tabsView.updateUnderline(xOrigin: currenCell.frame.origin.x, width: currenCell.frame.width)
        
        
        var direction : UIPageViewController.NavigationDirection = .forward
        if index < currentPageIndex{
            direction = .reverse
        }
        
        rootPageViewController.setViewControllerFromIndex(index: index, direction: direction)
        
        currentPageIndex = index
        
    }
    
    @IBOutlet weak var tabsView: TabsView!
    var rootPageViewController : RootPageViewController!
    private var options : [String] = ["HOME","VIDEOS","PLAYLIST","CHANNEL","ABOUT"]
    var currentPageIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        //animacion navigation
        tabsView.buildView(delegate: self, options: options)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RootPageViewController{
            destination.delegateRoot = self
            rootPageViewController = destination
        }
    }
    
    override func dotsButtonPressed() {
        let vc = BottomSheetViewController()
         vc.modalPresentationStyle = .overCurrentContext
         self.present(vc,animated: false)
    }
    
    
}
extension MainViewController : RootPageProtocol{
    func currentPage(_ index: Int) {
        print("currentPage", index)
        currentPageIndex = index
        tabsView.selectedItem = IndexPath(item: index, section: 0)
    }
}
