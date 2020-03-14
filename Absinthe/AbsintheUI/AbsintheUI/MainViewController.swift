//
//  MainViewController.swift
//  AbsintheUI
//
//  Created by User on 08/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import UIKit
import SnapKit

public final class MainViewController: UIViewController {
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

    private func setUp() {
        view.backgroundColor = .blue
    }
}
