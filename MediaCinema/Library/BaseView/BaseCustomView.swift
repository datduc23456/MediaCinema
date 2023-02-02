//
//  BaseCustomView.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import UIKit

class BaseCustomView: UIView {
    
    var nibNameView: String?
    var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initWithNib()
    }
    
    func initWithNib() {
        guard let view = UINib(nibName: nibNameView ?? self.className(), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
        self.backgroundColor = .clear
        contentView = view
        commonSetup()
    }
    
    func commonSetup() {
        
    }
    
    func className() -> String {
        if let name = NSStringFromClass(type(of: self)).components(separatedBy: ".").last {
            return name
        } else {
            return ""
        }
    }
}

