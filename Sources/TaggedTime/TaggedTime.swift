import Dispatch
import Foundation
import Tagged

public enum MillisecondsTag {}
/// A type that represents milliseconds of time.
public typealias Milliseconds<A> = Tagged<MillisecondsTag, A>

public enum SecondsTag {}
/// A type that represents seconds of time.
public typealias Seconds<A> = Tagged<SecondsTag, A>

extension Tagged where Tag == MillisecondsTag, RawValue: BinaryFloatingPoint {
  /// Converts milliseconds to seconds.
  public var seconds: Seconds<RawValue> {
    return .init(rawValue: self.rawValue / 1000)
  }

  /// Converts milliseconds into `TimeInterval`, which is measured in seconds.
  public var timeInterval: TimeInterval {
    let seconds = self.seconds.rawValue
    return TimeInterval(
      sign: seconds.sign,
      exponentBitPattern: UInt(seconds.exponentBitPattern),
      significandBitPattern: UInt64(seconds.significandBitPattern)
    )
  }

  /// Converts milliseconds into `Date`, which is measured in seconds.
  public var date: Date {
    return Date(timeIntervalSince1970: self.timeInterval)
  }
}

extension Tagged where Tag == MillisecondsTag, RawValue: BinaryInteger {
  /// Converts milliseconds into `TimeInterval`, which is measured in seconds.
  public var timeInterval: TimeInterval {
    return self.map(TimeInterval.init).timeInterval
  }

  /// Converts milliseconds into `DispatchTimeInterval`.
  public var dispatchTimeInterval: TimeInterval {
    return .milliseconds(Int(self.rawValue))
  }

  /// Converts milliseconds into `Date`, which is measured in seconds.
  public var date: Date {
    return Date(timeIntervalSince1970: self.timeInterval)
  }
}

extension Tagged where Tag == SecondsTag, RawValue: Numeric {
  /// Converts seconds in milliseconds.
  public var milliseconds: Milliseconds<RawValue> {
    return .init(rawValue: self.rawValue * 1000)
  }
}

extension Tagged where Tag == SecondsTag, RawValue: BinaryInteger {
  /// Converts seconds into `TimeInterval`.
  public var timeInterval: TimeInterval {
    return TimeInterval(Int64(self.rawValue))
  }

  /// Converts seconds into `DispatchTimeInterval`.
  public var dispatchTimeInterval: TimeInterval {
    return .seconds(Int(self.rawValue))
  }

  /// Converts seconds in `Date`.
  public var date: Date {
    return Date(timeIntervalSince1970: self.timeInterval)
  }
}

extension Date {
  /// Computes the number of seconds between the receiver and another given dte.
  ///
  /// - Parameter date: The date with which to compare the receiver.
  /// - Returns: The number of seconds between the receiver and the other date.
  public func secondsSince(_ date: Date) -> Seconds<TimeInterval> {
    return Seconds(rawValue: self.timeIntervalSince(date))
  }

  /// Computes the number of milliseconds between the receiver and another given dte.
  ///
  /// - Parameter date: The date with which to compare the receiver.
  /// - Returns: The number of milliseconds between the receiver and the other date.
  public func millisecondsSince(_ date: Date) -> Milliseconds<TimeInterval> {
    return self.secondsSince(date).milliseconds
  }
}
