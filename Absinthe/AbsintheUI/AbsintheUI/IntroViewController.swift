//
//  IntroViewController.swift
//  AbsintheUI
//
//  Created by User on 15/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import UIKit
import SnapKit

final public class IntroViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

private extension IntroViewController {
    func setUp() {
        view.backgroundColor = UIColor.background

        let lineView = UIView()
        lineView.backgroundColor = UIColor.white
        view.addSubview(lineView)
        lineView.snp.makeConstraints { maker in
            maker.height.equalTo(1)
            maker.width.equalToSuperview().multipliedBy(0.669)
            maker.centerY.trailing.equalToSuperview()
        }

        let imageView = UIImageView(image: Asset.appTItle.image)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.bottom.equalTo(lineView.snp.top)
            maker.leading.equalTo(lineView.snp.leading)
        }

        let subTitle = UILabel()
        view.addSubview(subTitle)
        subTitle.text = L10n.Intro.subTitle
        subTitle.textColor = UIColor.white
        subTitle.font = .systemFont(ofSize: 15, weight: .bold)
        subTitle.snp.makeConstraints { (maker) in
            maker.trailing.equalToSuperview().inset(20)
            maker.top.equalTo(lineView.snp.bottom).offset(6)
        }
    }
}
