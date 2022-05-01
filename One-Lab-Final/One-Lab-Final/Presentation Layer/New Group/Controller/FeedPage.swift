//
//  FeedPage.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 26.04.2022.
//

import UIKit
import Tabman
import Pageboy
import SnapKit

class FeedPage: TabmanViewController {
    
    private var viewControllers: Array<UIViewController> = []
    private let EditorialVc = EditorialViewController()
    private let CurrentEventsVC = CurrentEventsViewController()
    private let WallpapersVC = WallpapersViewController()
    private let RendersVC = RendersViewController()
    private let TexturesAndPatternsVC = TexturesAndPatternsViewController()
    private let ExperimentalVC = ExperimentalViewController()
    private let ArchitectureVC = ArchitectureViewController()
    private let NatureVC = NatureViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationItem.title = "Unsplah"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                    title: "Done",
                    style: .done,
                    target: self,
                    action: #selector(doneTapped)
        )
        viewControllers.append(EditorialVc)
        viewControllers.append(CurrentEventsVC)
        viewControllers.append(WallpapersVC)
        viewControllers.append(RendersVC)
        viewControllers.append(TexturesAndPatternsVC)
        viewControllers.append(ExperimentalVC)
        viewControllers.append(ArchitectureVC)
        viewControllers.append(NatureVC)
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .top)
       
    }
    
 

    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 13.0, bottom: 0.0, right: 20.0)
        ctBar.scrollMode = .interactive
        ctBar.layout.interButtonSpacing = 35
        ctBar.backgroundView.style = .clear
        ctBar.buttons.customize { (button) in
            button.tintColor = .white
            button.selectedTintColor = .white
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        ctBar.indicator.weight = .custom(value: 2)
        ctBar.indicator.tintColor = .white
    }

    @objc private func doneTapped(){
        
    }
    
}

extension FeedPage: PageboyViewControllerDataSource{
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    
}

extension FeedPage: TMBarDataSource{
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
           case 0:
               return TMBarItem(title: "Editorial")
           case 1:
               return TMBarItem(title: "Currern Events")
            case 2:
                return TMBarItem(title: "Wallpapers")
            case 3:
                return TMBarItem(title: "3D Renders")
            case 4:
                return TMBarItem(title: "Textures & Patterns")
            case 5:
                return TMBarItem(title: "Experimental")
            case 6:
                return TMBarItem(title: "Architecture")
            case 7:
                return TMBarItem(title: "Nature")
            default:
               let title = "Page \(index)"
               return TMBarItem(title: title)
           }
    }
}
