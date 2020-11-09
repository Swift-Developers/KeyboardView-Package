import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  enum Colors {
    static let button = ColorAsset(name: "button")
    static let buttonText = ColorAsset(name: "buttonText")
    static let systemButton = ColorAsset(name: "systemButton")
    static let systemButtonText = ColorAsset(name: "systemButtonText")
  }
    
  enum Images {
    enum Buttons {
      static let backspace = ImageAsset(name: "backspace")
      static let newline = ImageAsset(name: "newline")
      static let space = ImageAsset(name: "space")
      static let switchKeyboard = ImageAsset(name: "switchKeyboard")
    }
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

struct ColorAsset {
  fileprivate(set) var name: String
  var color: UIColor { UIColor(asset: self) }
}

extension UIColor {

  convenience init!(asset: ColorAsset) {
    self.init(named: asset.name, in: .module, compatibleWith: nil)
  }
}


struct ImageAsset {
  fileprivate(set) var name: String

  var image: UIImage {
    let image = UIImage(named: name, in: .module, compatibleWith: nil)
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

extension UIImage {
  convenience init!(asset: ImageAsset) {
    self.init(named: asset.name, in: .module, compatibleWith: nil)
  }
}
