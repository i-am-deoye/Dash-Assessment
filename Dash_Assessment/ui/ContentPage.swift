//
//  ContentPage.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


class ContentPage<Content: ContentView> : UIViewController {
    fileprivate var onscreenConstraints = [NSLayoutConstraint]()
    fileprivate var childPages = [UIViewController]()
    fileprivate var currentChildIndex : Int?
    
    var containerContentView: UIView? = nil
    
    var shouldShowNavigationBar : Bool = false {
        didSet { navigationController?.setNavigationBarHidden(!shouldShowNavigationBar, animated: true) }
    }
    
    var contentView: Content!
    

    var topOffsetConstant: NSLayoutConstraint?
    var bottomOffsetConstant: NSLayoutConstraint?
    var leadingOffsetConstant: NSLayoutConstraint?
    var trailingOffsetConstant: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setup()
        //ContentPage.setupNavigationBarStyle(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        shouldShowNavigationBar = false
    }
    
    
    func setup() {
        
        contentView = Content.init()
         contentView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(contentView)
        self.topOffsetConstant = contentView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        self.topOffsetConstant?.isActive = true
        
        self.bottomOffsetConstant = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        self.bottomOffsetConstant?.isActive = true
        
        self.leadingOffsetConstant = contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        self.leadingOffsetConstant?.isActive = true
        
        self.trailingOffsetConstant = contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        self.trailingOffsetConstant?.isActive = true
     }
    
    
    func registerChildPages(_ childs: (() -> [UIViewController])) {
        self.childPages = childs()
        perform(#selector(performDefaultPage), with: nil, afterDelay: 1)
    }
    
    @objc private func performDefaultPage() {
        self.add(page: 0)
    }
    
}


extension ContentPage {

    static func setupNavigationBarStyle (_ controller: UIViewController) {
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        controller.navigationController?.navigationBar.isTranslucent = true
        controller.navigationController?.navigationBar.tintColor = UIColor.white
        //controller.navigationController?.navigationBar.barTintColor = UIColor.color(type: .barButtonColor)
        controller.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        UISegmentedControl.appearance()
            .setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
}


extension ContentPage {
    func add(page index: Int) {
        guard index <= childPages.count - 1 else { return }
        guard let containerContentView = self.containerContentView else { return }
        self.removeChild()
        
        let page = childPages[index]
        addChild(page)
        containerContentView.addSubview(page.view)
        page.view.translatesAutoresizingMaskIntoConstraints = false
        
        page.view.backgroundColor = .white
        
        onscreenConstraints = [
            page.view.topAnchor.constraint(equalTo: containerContentView.safeAreaLayoutGuide.topAnchor),
            page.view.bottomAnchor.constraint(equalTo: containerContentView.bottomAnchor),
            page.view.leadingAnchor.constraint(equalTo: containerContentView.leadingAnchor),
            page.view.trailingAnchor.constraint(equalTo: containerContentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(onscreenConstraints)
        page.didMove(toParent: self)
        self.currentChildIndex = index
        NotificationHelper.shouldUpdatesUI()
    }
    
    func removeChild() {
        guard let index = currentChildIndex else { return }
        guard index <= childPages.count - 1 else { return }
        let page = childPages[index]
        page.willMove(toParent: nil)
        NSLayoutConstraint.deactivate(onscreenConstraints)
        page.view.removeFromSuperview()
        page.removeFromParent()
    }
}

