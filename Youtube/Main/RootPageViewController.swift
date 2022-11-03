//
//  RootPageViewController.swift
//  Youtube
//
//  Created by user228543 on 10/3/22.
//

import UIKit
protocol  RootPageProtocol : AnyObject{
    func currentPage(_ index : Int)
}
class RootPageViewController: UIPageViewController {
    
    var subViewControllers = [UIViewController]()
    var currentIndex : Int = 0
    //delegate
    weak var delegateRoot : RootPageProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setUpViewController()
    }
    
    private func setUpViewController(){
        subViewControllers = [
            HomeViewController(),
            VideosViewController(),
            PlaylistsViewController(),
            ChannelsViewController(),
            AboutViewController(),
        ]
        _ = subViewControllers.enumerated().map({$0.element.view.tag = $0.offset})
        setViewControllerFromIndex(index: 0, direction: .forward)
        
    }
    func setViewControllerFromIndex(index : Int, direction: NavigationDirection, animated: Bool = true){
        setViewControllers([subViewControllers[index]],direction : direction, animated: animated)
    }
//    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
//        <#code#>
//    }

}
extension RootPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index : Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if index <= 0{
            return nil
        }
        return subViewControllers[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index : Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if index >= (subViewControllers.count-1){
            return nil
        }
        return subViewControllers[index+1]
    }
    //Fin animacion
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("finished", finished)
        if let index = pageViewController.viewControllers?.first?.view.tag{
            currentIndex = index
            delegateRoot?.currentPage(index)
        }
    }
    
}
