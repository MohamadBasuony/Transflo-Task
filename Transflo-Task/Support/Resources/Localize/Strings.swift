// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  internal enum InfoPlist {
    /// OmniOrder MarketPlace
    internal static let cfBundleName = { L10n.tr("InfoPlist", "CFBundleName") }
    /// will share only Photo you want it to be your new profile picture.
    internal static let nsCameraUsageDescription = { L10n.tr("InfoPlist", "NSCameraUsageDescription") }
    /// In order to provide you with all info. related to nearby centers.
    internal static let nsLocationAlwaysUsageDescription = { L10n.tr("InfoPlist", "NSLocationAlwaysUsageDescription") }
    /// In order to provide you with all info. related to nearby centers.
    internal static let nsLocationWhenInUseUsageDescription = { L10n.tr("InfoPlist", "NSLocationWhenInUseUsageDescription") }
    /// In order to pick picture
    internal static let nsPhotoLibraryAddUsageDescription = { L10n.tr("InfoPlist", "NSPhotoLibraryAddUsageDescription") }
    /// In order to pick picture
    internal static let nsPhotoLibraryUsageDescription = { L10n.tr("InfoPlist", "NSPhotoLibraryUsageDescription") }
  }
  internal enum Localizable {
    /// About
    internal static let about = { L10n.tr("Localizable", "About") }
    /// Chat
    internal static let chat = { L10n.tr("Localizable", "Chat") }
    /// Connect To Sellers
    internal static let connectToSellers = { L10n.tr("Localizable", "Connect To Sellers") }
    /// Connection Request is still pending approval by seller
    internal static let connectionRequestIsStillPendingApprovalBySeller = { L10n.tr("Localizable", "Connection Request is still pending approval by seller") }
    /// Home
    internal static let home = { L10n.tr("Localizable", "Home") }
    /// Logout
    internal static let logout = { L10n.tr("Localizable", "Logout") }
    /// Market
    internal static let market = { L10n.tr("Localizable", "Market") }
    /// Orders
    internal static let orders = { L10n.tr("Localizable", "Orders") }
    /// Pending
    internal static let pending = { L10n.tr("Localizable", "Pending") }
    /// Profile
    internal static let profile = { L10n.tr("Localizable", "Profile") }
    /// Search
    internal static let search = { L10n.tr("Localizable", "Search") }
    /// Settings
    internal static let settings = { L10n.tr("Localizable", "Settings") }
    /// Your product added to cart successfully!
    internal static let yourProductAddedToCartSuccessfully = { L10n.tr("Localizable", "Your product added to cart successfully!") }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, arguments: args)
  }
}

private final class BundleToken {}

