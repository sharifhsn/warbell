import CoreGraphics
import Foundation

guard CommandLine.arguments.count == 2,
      let requestedPID = Int32(CommandLine.arguments[1]),
      let windows = CGWindowListCopyWindowInfo([.optionOnScreenOnly, .excludeDesktopElements],
                                               kCGNullWindowID) as? [[String: Any]]
else {
    exit(2)
}

let match = windows.compactMap { window -> (CGWindowID, CGFloat)? in
    guard let owner = window[kCGWindowOwnerPID as String] as? NSNumber,
          owner.int32Value == requestedPID,
          let layer = window[kCGWindowLayer as String] as? NSNumber,
          layer.intValue == 0,
          let number = window[kCGWindowNumber as String] as? NSNumber,
          let bounds = window[kCGWindowBounds as String] as? [String: NSNumber],
          let width = bounds["Width"]?.doubleValue,
          let height = bounds["Height"]?.doubleValue,
          width > 0,
          height > 0
    else {
        return nil
    }
    return (CGWindowID(number.uint32Value), CGFloat(width * height))
}.max { lhs, rhs in lhs.1 < rhs.1 }

guard let match else {
    exit(1)
}
print(match.0)
