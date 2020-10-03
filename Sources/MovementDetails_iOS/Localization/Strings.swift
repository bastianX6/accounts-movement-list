// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Compras en cuotas
  internal static let multiPaymentExpenses = L10n.tr("Localizable", "Multi-payment expenses")
  /// Otros gastos
  internal static let otherExpenses = L10n.tr("Localizable", "Other expenses")
  /// Gastos fijos
  internal static let permanentExpenses = L10n.tr("Localizable", "Permanent expenses")
  /// Resumen
  internal static let summary = L10n.tr("Localizable", "Summary")
  /// Total
  internal static let total = L10n.tr("Localizable", "Total")
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
