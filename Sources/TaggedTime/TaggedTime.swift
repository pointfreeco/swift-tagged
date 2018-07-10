import Tagged

public enum MillisecondsTag {}
public typealias Milliseconds<A> = Tagged<MillisecondsTag, A>

public enum SecondsTag {}
public typealias Seconds<A> = Tagged<SecondsTag, A>

extension Tagged where Tag == MillisecondsTag, RawValue: BinaryFloatingPoint {
  public var seconds: Seconds<RawValue> {
    return .init(rawValue: self.rawValue / 1000)
  }
}

extension Tagged where Tag == SecondsTag, RawValue: Numeric {
  public var milliseconds: Milliseconds<RawValue> {
    return .init(rawValue: self.rawValue * 1000)
  }
}
