import Foundation
import Tagged

public enum MillisecondsTag {}
public typealias Milliseconds<A> = Tagged<MillisecondsTag, A>

public enum SecondsTag {}
public typealias Seconds<A> = Tagged<SecondsTag, A>

extension Tagged where Tag == MillisecondsTag {

}

extension Tagged where Tag == MillisecondsTag, RawValue: BinaryFloatingPoint {
  public var seconds: Seconds<RawValue> {
    return .init(rawValue: self.rawValue / 1000)
  }

  public var date: Date {
    let seconds = self.seconds
    let double = Double(
      sign: seconds.rawValue.sign,
      exponentBitPattern: UInt(seconds.rawValue.exponentBitPattern),
      significandBitPattern: UInt64(seconds.rawValue.significandBitPattern)
    )

    return Date(timeIntervalSince1970: double)
  }
}

extension Tagged where Tag == SecondsTag, RawValue: Numeric {
  public var milliseconds: Milliseconds<RawValue> {
    return .init(rawValue: self.rawValue * 1000)
  }
}

extension Tagged where Tag == SecondsTag, RawValue: BinaryInteger {
  public var date: Date {
    return Date(timeIntervalSince1970: Double(Int64(self.rawValue)))
  }
}
