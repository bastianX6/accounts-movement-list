// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Gastos
  internal static let expenses = L10n.tr("Localizable", "Expenses")
  /// Gastos de %@ - %@
  internal static func expensesOf(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "Expenses of %@ - %@", String(describing: p1), String(describing: p2))
  }
  /// Filtrar
  internal static let filter = L10n.tr("Localizable", "Filter")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle = Bundle.module
}
// swiftlint:enable convenience_type