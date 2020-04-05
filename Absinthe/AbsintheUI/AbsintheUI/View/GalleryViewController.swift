//
//  GalleryViewController.swift
//  AbsintheUI
//
//  Created by User on 05/04/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift
import RxAppState
import ViewModel

final public class GalleryViewController: UIViewController, View {
    public typealias Reactor = GalleryViewReactor

    public var disposeBag = DisposeBag()

    public init(reactor: Reactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func bind(reactor: Reactor) {
        rx.viewDidLoad
            .subscribe(onNext: { [weak self] _ in
                self?.setUp()
            })
            .disposed(by: disposeBag)
    }
}

private extension GalleryViewController {
    func setUp() {
        view.backgroundColor = .green
    }
}
