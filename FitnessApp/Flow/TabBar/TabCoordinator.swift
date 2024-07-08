//
//  TabCoordinator.swift
//  FitnessApp
//
//  Created by Jane Strashok on 07.07.2024.
//

import UIKit

class TabCoordinator: NSObject, TabCoordinatorDelegate {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    private var sex: Sex
    
    init(_ navigationController: UINavigationController, sex: Sex) {
        self.navigationController = navigationController
        self.tabBarController = .init()
        self.tabBarController.tabBar.tintColor = .primaryYellow
        self.tabBarController.tabBar.unselectedItemTintColor = UIColor(hex: "#D9D9D9", alpha: 1)
        self.sex = sex
    }
    
    func start() {
        let tabs = TabBarItem.allCases
        let coordinators = tabs.map { getTabCoordinator($0) }
        let controllers = coordinators.map { $0.navigationController }
        prepareTabBarController(withTabControllers: controllers)
    }
    
    func selectTab(_ tab: TabBarItem) {
        tabBarController.selectedIndex = tab.rawValue
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let tab = TabBarItem.init(rawValue: index) else { return }
        tabBarController.selectedIndex = tab.rawValue
    }
    
    func currentTab() -> TabBarItem? {
        TabBarItem.init(rawValue: tabBarController.selectedIndex)
    }
}

private extension TabCoordinator {
    func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarItem.home.rawValue
        tabBarController.tabBar.isTranslucent = false
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    func getTabCoordinator(_ tab: TabBarItem) -> Coordinator {
        let coordinator = tab.getCoodrinator(with: sex)
        coordinator.navigationController.setNavigationBarHidden(true, animated: false)
        coordinator.navigationController.tabBarItem = UITabBarItem.init(title: tab.title, image: tab.image, tag: tab.rawValue)
        coordinator.navigationController.tabBarItem.selectedImage = tab.selectedImage
        coordinator.start()
        return coordinator
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
