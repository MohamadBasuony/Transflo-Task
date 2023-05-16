// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let _3bar = ImageAsset(name: "3bar")
    internal static let accentColor = ColorAsset(name: "AccentColor")
    internal static let group5 = ImageAsset(name: "Group 5")
    internal static let layer25 = ImageAsset(name: "Layer 25")
    internal static let page1Copy = ImageAsset(name: "Page-1 copy")
    internal static let about = ImageAsset(name: "about")
    internal static let addToCart = ImageAsset(name: "add-to-cart")
    internal static let addUser = ImageAsset(name: "add_user")
    internal static let approval = ImageAsset(name: "approval")
    internal static let back = ImageAsset(name: "back")
    internal static let bell = ImageAsset(name: "bell")
    internal static let calendar = ImageAsset(name: "calendar")
    internal static let cart = ImageAsset(name: "cart")
    internal static let chatWhite = ImageAsset(name: "chat-white")
    internal static let chat = ImageAsset(name: "chat")
    internal static let checklist = ImageAsset(name: "checklist")
    internal static let close = ImageAsset(name: "close")
    internal static let connect = ImageAsset(name: "connect")
    internal static let del = ImageAsset(name: "del")
    internal static let delete = ImageAsset(name: "delete")
    internal static let disconnected = ImageAsset(name: "disconnected")
    internal static let email = ImageAsset(name: "email")
    internal static let favorite = ImageAsset(name: "favorite")
    internal static let filter = ImageAsset(name: "filter")
    internal static let filterFilled = ImageAsset(name: "filterFilled")
    internal static let freechat = ImageAsset(name: "freechat")
    internal static let group = ImageAsset(name: "group")
    internal static let help = ImageAsset(name: "help")
    internal static let home = ImageAsset(name: "home")
    internal static let info = ImageAsset(name: "info")
    internal static let layers = ImageAsset(name: "layers")
    internal static let loginBg = ImageAsset(name: "login_bg")
    internal static let logo = ImageAsset(name: "logo")
    internal static let logo2 = ImageAsset(name: "logo2")
    internal static let logout = ImageAsset(name: "logout")
    internal static let market = ImageAsset(name: "market")
    internal static let noImage = ImageAsset(name: "no_image")
    internal static let order = ImageAsset(name: "order")
    internal static let paperPlane = ImageAsset(name: "paper-plane")
    internal static let paw = ImageAsset(name: "paw")
    internal static let pencil = ImageAsset(name: "pencil")
    internal static let profile = ImageAsset(name: "profile")
    internal static let random = ImageAsset(name: "random")
    internal static let redCircle = ImageAsset(name: "red_circle")
    internal static let sandClock = ImageAsset(name: "sand_clock")
    internal static let search = ImageAsset(name: "search")
    internal static let settings = ImageAsset(name: "settings")
    internal static let sortAsc = ImageAsset(name: "sort_asc")
    internal static let sortDesc = ImageAsset(name: "sort_desc")
    internal static let task = ImageAsset(name: "task")
    internal static let unfavorite = ImageAsset(name: "unfavorite")
    internal static let user = ImageAsset(name: "user")
  }
  internal enum Colors {
    internal static let basicGreen = ColorAsset(name: "BasicGreen")
    internal static let connectGray = ColorAsset(name: "ConnectGray")
    internal static let connectGreen = ColorAsset(name: "ConnectGreen")
    internal static let darkBlue = ColorAsset(name: "DarkBlue")
    internal static let darkGreen = ColorAsset(name: "DarkGreen")
    internal static let darkGrey = ColorAsset(name: "DarkGrey")
    internal static let green = ColorAsset(name: "Green")
    internal static let grey = ColorAsset(name: "Grey")
    internal static let iconTint = ColorAsset(name: "IconTint")
    internal static let lBlue = ColorAsset(name: "LBlue")
    internal static let lightBlue = ColorAsset(name: "LightBlue")
    internal static let medGrey = ColorAsset(name: "MedGrey")
    internal static let orange = ColorAsset(name: "Orange")
    internal static let blueGrey = ColorAsset(name: "blueGrey")
    internal static let turquoise = ColorAsset(name: "turquoise")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
