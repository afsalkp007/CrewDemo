//
//  NameView.swift
//  CrewDemo
//
//  Created by Wasim on 18/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit

class NameView: WMView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var viewColor: UIView!

    @IBInspectable public var titleColor: UIColor = UIColor.black {
        didSet {
            lblTitle.textColor = titleColor
        }
    }
    
    @IBInspectable public var subTitleColor: UIColor = UIColor.themeLightPink() {
        didSet {
            lblSubTitle.textColor = subTitleColor
        }
    }
    
    @IBInspectable public var bgColor: UIColor = UIColor.themeBlue() {
        didSet {
            viewColor.backgroundColor = bgColor
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("NameView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setupView(with title: String?, subTitle: String?)  {
        
        lblTitle.text = title
        lblSubTitle.text = subTitle
    }
    
}
