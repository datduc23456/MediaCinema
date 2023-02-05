//
//  TabbarVC.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import UIKit
import SnapKit

class TabbarItem: UIView {
    var index: Int!
    var selectedAction: VoidCallBack!
    var imageView: UIImageView!
    var separatorView: UIView!
    var label: UILabel!
    
    init(frame: CGRect, index: Int, selectedAction: @escaping VoidCallBack) {
        super.init(frame: frame)
        self.index = index
        self.selectedAction = selectedAction
        separatorView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 2))
        separatorView.backgroundColor = APP_COLOR
        let imageView = UIImageView.init(image: UIImage(named: "ic_tabbar\(index+1)"))
        self.imageView = imageView
        
        label = UILabel()
        self.addSubview(separatorView)
        self.addSubview(imageView)
        self.addSubview(label)
        label.font = CommonUtil.getAppFontRegular(12)
        var text: String = ""
        switch index {
        case 0:
            text = "Movies"
        case 1:
            text = "TV Show"
        case 2:
            text = "Favorite"
        case 3:
            text = "Statistical"
        case 4:
            text = "Notes"
        default:
            break
        }
        label.text = text
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(20)
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
//        imageView.center = self.center
        self.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self else { return }
            self.selectedAction()
        })
    }
    
    func selected() {
        self.label.textColor = APP_COLOR
        self.separatorView.backgroundColor = APP_COLOR
        self.imageView.image = UIImage(named: "ic_tabbar\(index+1)_selected")
    }
    
    func unselected() {
        self.label.textColor = .black
        self.separatorView.backgroundColor = UIColor(hex: "#000000").withAlphaComponent(0.1)
        self.imageView.image = UIImage(named: "ic_tabbar\(index+1)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TabbarViewController: UITabBarController {
    
    let customTabbarHeight: CGFloat = 54
    var listVc: [UIViewController] = [AppScreens.movie.createViewController(), AppScreens.tvShow.createViewController(), AppScreens.home.createViewController(), AppScreens.favorite.createViewController(), AppScreens.note.createViewController()]
    var countVc: Int {
        return listVc.count
    }
    var items: [TabbarItem] = []
    var customTabbar: UIStackView!
    var viewGradientBottom: UIView!
    var gradient: CAGradientLayer!
    var isFirstLayout: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.viewControllers = listVc
//        self.setupGradientTabbar()
//        var height: CGFloat = 10
//        if let safeAreaInsets = AppDelegate.shared.window?.safeAreaInsets.bottom, safeAreaInsets != 0 {
//            height = 0
//        }
        let view = UIView()
        view.backgroundColor = .white
        self.view.addSubview(view)
        view.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(AppDelegate.shared.window!.safeAreaInsets.bottom)
        }
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        let frame = CGRect(x: 0, y: 0, width: (CommonUtil.SCREEN_WIDTH) / CGFloat(countVc), height: customTabbarHeight)
        self.view.addSubview(stackView)
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -AppDelegate.shared.window!.safeAreaInsets.bottom).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: customTabbarHeight).isActive = true
        for (index, _) in self.tabBar.items!.enumerated() {
            let tabbarItem = TabbarItem(frame: frame, index: index, selectedAction: {})
            stackView.addArrangedSubview(tabbarItem)
            tabbarItem.translatesAutoresizingMaskIntoConstraints = false
            tabbarItem.widthAnchor.constraint(equalToConstant: (CommonUtil.SCREEN_WIDTH) / CGFloat(countVc)).isActive = true
            tabbarItem.selectedAction = { [weak self] in
                guard let `self` = self else { return }
                self.unselectAll()
                tabbarItem.selected()
                self.selectedViewController = self.listVc[index]
            }
            self.items.append(tabbarItem)
        }
        
        self.items[0].selectedAction()
        
//        for item in self.viewControllers ?? [] {
//
//            var inset = item.view.safeAreaInsets
//            inset.bottom = customTabbarHeight
//            item.additionalSafeAreaInsets = inset
//        }
        self.customTabbar = stackView
        self.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstLayout {
//            viewGradientBottom.fadeView(style: .top, percentage: 0.55)
            isFirstLayout = !isFirstLayout
            NotificationCenter.default.addObserver(self, selector: #selector(showOpenAds), name: Notification.Name("AppOpenAdDidLoad"), object: nil)
        }
//        gradient.frame = viewGradientBottom.bounds
    }
    
    @objc func showOpenAds() {
//        AdMobManager.shared.show(key: "AppOpenAd")
    }
    
    func unselectAll() {
        for item in items {
            item.unselected()
        }
    }
    
    func setupGradientTabbar() {
        viewGradientBottom = UIView()
        view.addSubview(viewGradientBottom)
        viewGradientBottom.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(customTabbarHeight + AppDelegate.shared.window!.safeAreaInsets.bottom + 30)
        }
        gradient = CAGradientLayer()
//        gradient.frame = viewGradientBottom.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0, 1]
//        viewGradientBottom.fadeView(style: .bottom)
//        viewGradientBottom.layer.mask = gradient
        viewGradientBottom.backgroundColor = APP_COLOR
    }
    
}
