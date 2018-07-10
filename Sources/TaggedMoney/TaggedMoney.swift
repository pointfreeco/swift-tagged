import Tagged

public enum CentsTag {}
public typealias Cents<A> = Tagged<CentsTag, A>

public enum DollarsTag {}
public typealias Dollars<A> = Tagged<DollarsTag, A>

extension Tagged where Tag == CentsTag, RawValue: BinaryFloatingPoint {
  public var dollars: Dollars<RawValue> {
    return .init(rawValue: self.rawValue / 100)
  }
}

extension Tagged where Tag == DollarsTag, RawValue: Numeric {
  public var cents: Cents<RawValue> {
    return .init(rawValue: self.rawValue * 100)
  }
}
