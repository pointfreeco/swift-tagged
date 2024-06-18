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
    Seconds(rawValue: rawValue / 1000)
  }

  /// Converts milliseconds into `TimeInterval`, which is measured in seconds.
  public var timeInterval: TimeInterval {
    let seconds = seconds.rawValue
    return TimeInterval(
      sign: seconds.sign,
      exponentBitPattern: UInt(seconds.exponentBitPattern),
      significandBitPattern: UInt64(seconds.significandBitPattern)
    )
  }

  /// Converts milliseconds into `Date`, which is measured in seconds.
  public var date: Date {
    Date(timeIntervalSince1970: timeInterval)
  }

  /// Converts milliseconds into `Duration`.
  @available(macOS 13, iOS 16, watchOS 9, tvOS 16, *)
  public var duration: Duration {
    .milliseconds(Double(rawValue))
  }
}

extension Tagged where Tag == MillisecondsTag, RawValue: BinaryInteger {
  /// Converts milliseconds into `TimeInterval`, which is measured in seconds.
  public var timeInterval: TimeInterval {
    map(TimeInterval.init).timeInterval
  }

  /// Converts milliseconds into `DispatchTimeInterval`.
  public var dispatchTimeInterval: DispatchTimeInterval {
    .milliseconds(Int(rawValue))
  }

  /// Converts milliseconds into `Date`, which is measured in seconds.
  public var date: Date {
    Date(timeIntervalSince1970: timeInterval)
  }

  /// Converts milliseconds into `Duration`.
  @available(macOS 13, iOS 16, watchOS 9, tvOS 16, *)
  public var duration: Duration {
    .milliseconds(rawValue)
  }
}

extension Tagged where Tag == SecondsTag, RawValue: Numeric {
  /// Converts seconds in milliseconds.
  public var milliseconds: Milliseconds<RawValue> {
    return Milliseconds(rawValue: rawValue * 1000)
  }
}

extension Tagged where Tag == SecondsTag, RawValue: BinaryInteger {
  /// Converts seconds into `TimeInterval`.
  public var timeInterval: TimeInterval {
    TimeInterval(Int64(rawValue))
  }

  /// Converts seconds into `DispatchTimeInterval`.
  public var dispatchTimeInterval: DispatchTimeInterval {
    .seconds(Int(rawValue))
  }

  /// Converts seconds into `Date`.
  public var date: Date {
    Date(timeIntervalSince1970: timeInterval)
  }

  /// Converts seconds into `Duration`.
  @available(macOS 13, iOS 16, watchOS 9, tvOS 16, *)
  public var duration: Duration {
    .seconds(rawValue)
  }
}

extension Tagged where Tag == SecondsTag, RawValue: BinaryFloatingPoint {
  /// Converts milliseconds into `Duration`.
  @available(macOS 13, iOS 16, watchOS 9, tvOS 16, *)
  public var duration: Duration {
    .seconds(Double(rawValue))
  }
}

extension Date {
  /// Computes the number of seconds between the receiver and another given date.
  ///
  /// - Parameter date: The date with which to compare the receiver.
  /// - Returns: The number of seconds between the receiver and the other date.
  public func secondsSince(_ date: Date) -> Seconds<TimeInterval> {
    Seconds(rawValue: timeIntervalSince(date))
  }

  /// Computes the number of milliseconds between the receiver and another given date.
  ///
  /// - Parameter date: The date with which to compare the receiver.
  /// - Returns: The number of milliseconds between the receiver and the other date.
  public func millisecondsSince(_ date: Date) -> Milliseconds<TimeInterval> {
    secondsSince(date).milliseconds
  }
}
