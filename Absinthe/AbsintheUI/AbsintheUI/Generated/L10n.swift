// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Intro {
    /// for your personal data
    internal static let subTitle = L10n.tr("Localizable", "INTRO.SUB_TITLE")
  }

  internal enum Permission {
    /// 편리한 사용을 위해 아래 권한들이 필요합니다
    internal static let pageGuide = L10n.tr("Localizable", "PERMISSION.PAGE_GUIDE")
    /// 시작하기
    internal static let startButton = L10n.tr("Localizable", "PERMISSION.START_BUTTON")
    internal enum GoToSettingAlert {
      /// 취소
      internal static let cancel = L10n.tr("Localizable", "PERMISSION.GO_TO_SETTING_ALERT.CANCEL")
      /// 설정으로 이동하여 권한을 부여해주세요.
      internal static let message = L10n.tr("Localizable", "PERMISSION.GO_TO_SETTING_ALERT.MESSAGE")
      /// 이동하기
      internal static let ok = L10n.tr("Localizable", "PERMISSION.GO_TO_SETTING_ALERT.OK")
      /// %@ 권한이 필요합니다.
      internal static func title(_ p1: String) -> String {
        return L10n.tr("Localizable", "PERMISSION.GO_TO_SETTING_ALERT.TITLE", p1)
      }
    }
    internal enum Item {
      internal enum Notification {
        /// 지정한 작업이 완료되면 알림을 받을 수 있습니다
        internal static let info = L10n.tr("Localizable", "PERMISSION.ITEM.NOTIFICATION.INFO")
        /// 알림
        internal static let name = L10n.tr("Localizable", "PERMISSION.ITEM.NOTIFICATION.NAME")
        /// 알림
        internal static let title = L10n.tr("Localizable", "PERMISSION.ITEM.NOTIFICATION.TITLE")
      }
      internal enum Picture {
        /// 원하는 사진의 정보를 제거하거나 수정할 수 있습니다
        internal static let info = L10n.tr("Localizable", "PERMISSION.ITEM.PICTURE.INFO")
        /// 사진 읽기 및 쓰기
        internal static let name = L10n.tr("Localizable", "PERMISSION.ITEM.PICTURE.NAME")
        /// 사진 읽기 및 쓰기
        internal static let title = L10n.tr("Localizable", "PERMISSION.ITEM.PICTURE.TITLE")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
