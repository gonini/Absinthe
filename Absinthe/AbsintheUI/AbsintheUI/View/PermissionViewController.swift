//
//  PermissionViewController.swift
//  AbsintheUI
//
//  Created by User on 15/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import UIKit
import ReactorKit
import RxAppState
import RxCocoa
import RxSwift
import SnapKit
import ViewModel

final public class PermissionViewController: UIViewController, View {
    public typealias Reactor = PermissionViewReactor

    private let startButton = UIButton()

    public var disposeBag = DisposeBag()

    public init(reactor: Reactor) {
        defer { self.reactor = reactor }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func bind(reactor: Reactor) {
        reactor.event
            .subscribe(onNext: { [weak self] (event) in
                switch event {
                case .goToSetting(let deniedPermission):
                    self?.showGoToSettingAlert(for: deniedPermission)
                }
            })
            .disposed(by: disposeBag)

        rx.viewDidLoad
            .subscribe(onNext: { [weak self] _ in
                self?.setUp()
            })
            .disposed(by: disposeBag)

        startButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { _ in Reactor.Action.tapContinue }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }

    private func showGoToSettingAlert(for deniedPermission: PermissionType) {
        let alert = UIAlertController(
            title: L10n.Permission.GoToSettingAlert.title(deniedPermission.name),
            message: L10n.Permission.GoToSettingAlert.message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: L10n.Permission.GoToSettingAlert.ok, style: .default, handler: { (action: UIAlertAction!) in
              UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        alert.addAction(UIAlertAction(title: L10n.Permission.GoToSettingAlert.cancel, style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}

private extension PermissionViewController {
    func setUp() {
        view.backgroundColor = UIColor.background

        let imageView = UIImageView(image: Asset.appTItle.image)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaInsets.top).inset(64)
            maker.centerX.equalToSuperview()
        }

        let permissionPageGuideLabel = UILabel()
        view.addSubview(permissionPageGuideLabel)
        permissionPageGuideLabel.snp.makeConstraints { maker in
            maker.top.equalTo(imageView.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
        }
        permissionPageGuideLabel.text = L10n.Permission.pageGuide
        permissionPageGuideLabel.font = .systemFont(ofSize: 13, weight: .regular)
        permissionPageGuideLabel.textColor = UIColor.white

        let pictureImageView = UIImageView(image: Asset.picturePermissonIcon.image)
        view.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints { maker in
            maker.top.equalTo(permissionPageGuideLabel.snp.bottom).offset(40)
            maker.leading.equalToSuperview().inset(45)
        }

        // picture permission
        let pictureTitleLabel = UILabel()
        view.addSubview(pictureTitleLabel)
        pictureTitleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(pictureImageView.snp.trailing).offset(10)
            maker.centerY.equalTo(pictureImageView)
        }
        pictureTitleLabel.text = L10n.Permission.Item.Picture.title
        pictureTitleLabel.font = .systemFont(ofSize: 10, weight: .bold)
        pictureTitleLabel.textColor = UIColor.white

        let pictureInfoLabel = UILabel()
        view.addSubview(pictureInfoLabel)
        pictureInfoLabel.snp.makeConstraints { maker in
            maker.top.equalTo(pictureTitleLabel.snp.bottom).offset(6)
            maker.leading.equalTo(pictureTitleLabel.snp.leading)
        }
        pictureInfoLabel.text = L10n.Permission.Item.Picture.info
        pictureInfoLabel.font = .systemFont(ofSize: 8, weight: .regular)
        pictureInfoLabel.textColor = UIColor.white

        // notification permission
        let notificationImageView = UIImageView(image: Asset.notificaionPermissionIcon.image)
        view.addSubview(notificationImageView)
        notificationImageView.snp.makeConstraints { maker in
            maker.top.equalTo(pictureImageView.snp.bottom).offset(40)
            maker.leading.equalTo(pictureImageView.snp.leading)
        }

        let notificationTitleLabel = UILabel()
        view.addSubview(notificationTitleLabel)
        notificationTitleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(notificationImageView.snp.trailing).offset(10)
            maker.centerY.equalTo(notificationImageView)
        }
        notificationTitleLabel.text = L10n.Permission.Item.Notification.title
        notificationTitleLabel.font = .systemFont(ofSize: 10, weight: .bold)
        notificationTitleLabel.textColor = UIColor.white

        let notificationInfoLabel = UILabel()
        view.addSubview(notificationInfoLabel)
        notificationInfoLabel.snp.makeConstraints { maker in
            maker.top.equalTo(notificationTitleLabel.snp.bottom).offset(6)
            maker.leading.equalTo(notificationTitleLabel.snp.leading)
        }
        notificationInfoLabel.text = L10n.Permission.Item.Notification.info
        notificationInfoLabel.font = .systemFont(ofSize: 8, weight: .regular)
        notificationInfoLabel.textColor = UIColor.white

        // start button
        view.addSubview(startButton)
        startButton.snp.makeConstraints { maker in
            maker.height.equalTo(48)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(view.safeAreaInsets.bottom)
        }
        startButton.setBackgroundImage(UIColor.turtleGreen.image, for: .normal)
        startButton.setBackgroundImage(UIColor.turtleGreen.image.withAlpha(alpha: 0.7), for: .highlighted)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        startButton.setTitle(L10n.Permission.startButton, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .regular)
    }
}
