import Tagged

public enum CentsTag {}
/// A type that represents cents, i.e. one hundredth of a dollar.
public typealias Cents<A> = Tagged<CentsTag, A>

public enum DollarsTag {}
/// A type that represents a dollar, i.e. a base unit of any currency.
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
