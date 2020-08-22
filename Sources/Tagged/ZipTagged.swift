public func zip<Tag, A, B>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>
  ) -> Tagged<Tag, (A, B)> {
  return a.map { a in
    (a, b.rawValue)
  }
}

public func zip<Tag, A, B, Z>(
  with transform: @escaping (A, B) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>
  ) -> Tagged<Tag, Z> {
  return zip(a, b).map(transform)
}

public func zip<Tag, A, B, C>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>
  ) -> Tagged<Tag, (A, B, C)> {
  return zip(zip(a, b), c).map { ($0.0, $0.1, $1) }
}

public func zip<Tag, A, B, C, Z>(
  with transform: @escaping (A, B, C) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>
  ) -> Tagged<Tag, Z> {
  return zip(a, b, c).map(transform)
}

public func zip<Tag, A, B, C, D>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>
  ) -> Tagged<Tag, (A, B, C, D)> {
  return zip(zip(a, b), c, d).map { ($0.0, $0.1, $1, $2) }
}

public func zip<Tag, A, B, C, D, Z>(
  with transform: @escaping (A, B, C, D) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>
  ) -> Tagged<Tag, Z> {
  return zip(a, b, c, d).map(transform)
}

public func zip<Tag, A, B, C, D, E>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>
  ) -> Tagged<Tag, (A, B, C, D, E)> {
  return zip(zip(a, b), c, d, e).map { ($0.0, $0.1, $1, $2, $3) }
}

public func zip<Tag, A, B, C, D, E, Z>(
  with transform: @escaping (A, B, C, D, E) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>
  ) -> Tagged<Tag, Z> {
  return zip(a, b, c, d, e).map(transform)
}

public func zip<Tag, A, B, C, D, E, F>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>
  ) -> Tagged<Tag, (A, B, C, D, E, F)> {
  return zip(zip(a, b), c, d, e, f).map { ($0.0, $0.1, $1, $2, $3, $4) }
}

public func zip<Tag, A, B, C, D, E, F, Z>(
  with transform: @escaping (A, B, C, D, E, F) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>
  ) -> Tagged<Tag, Z> {
  return zip(a, b, c, d, e, f).map(transform)
}

public func zip<Tag, A, B, C, D, E, F, G>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>,
  _ g: Tagged<Tag, G>
  ) -> Tagged<Tag, (A, B, C, D, E, F, G)> {
  return zip(zip(a, b), c, d, e, f, g).map { ($0.0, $0.1, $1, $2, $3, $4, $5) }
}

public func zip<Tag, A, B, C, D, E, F, G, Z>(
  with transform: @escaping (A, B, C, D, E, F, G) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>,
  _ g: Tagged<Tag, G>
  ) -> Tagged<Tag, Z> {
  return zip(a, b, c, d, e, f, g).map(transform)
}

public func zip<Tag, A, B, C, D, E, F, G, H>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>,
  _ g: Tagged<Tag, G>,
  _ h: Tagged<Tag, H>
  ) -> Tagged<Tag, (A, B, C, D, E, F, G, H)> {
  return zip(zip(a, b), c, d, e, f, g, h).map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6) }
}

public func zip<Tag, A, B, C, D, E, F, G, H, Z>(
  with transform: @escaping (A, B, C, D, E, F, G, H) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>,
  _ g: Tagged<Tag, G>,
  _ h: Tagged<Tag, H>
  ) -> Tagged<Tag, Z> {
  return zip(a, b, c, d, e, f, g, h).map(transform)
}

public func zip<Tag, A, B, C, D, E, F, G, H, I>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>,
  _ g: Tagged<Tag, G>,
  _ h: Tagged<Tag, H>,
  _ i: Tagged<Tag, I>
  ) -> Tagged<Tag, (A, B, C, D, E, F, G, H, I)> {
  return zip(zip(a, b), c, d, e, f, g, h, i).map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6, $7) }
}

public func zip<Tag, A, B, C, D, E, F, G, H, I, Z>(
  with transform: @escaping (A, B, C, D, E, F, G, H, I) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>,
  _ g: Tagged<Tag, G>,
  _ h: Tagged<Tag, H>,
  _ i: Tagged<Tag, I>
  ) -> Tagged<Tag, Z> {
  return zip(a, b, c, d, e, f, g, h, i).map(transform)
}

public func zip<Tag, A, B, C, D, E, F, G, H, I, J>(
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>,
  _ g: Tagged<Tag, G>,
  _ h: Tagged<Tag, H>,
  _ i: Tagged<Tag, I>,
  _ j: Tagged<Tag, J>
  ) -> Tagged<Tag, (A, B, C, D, E, F, G, H, I, J)> {
  return zip(zip(a, b), c, d, e, f, g, h, i, j).map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6, $7, $8) }
}

public func zip<Tag, A, B, C, D, E, F, G, H, I, J, Z>(
  with transform: @escaping (A, B, C, D, E, F, G, H, I, J) -> Z,
  _ a: Tagged<Tag, A>,
  _ b: Tagged<Tag, B>,
  _ c: Tagged<Tag, C>,
  _ d: Tagged<Tag, D>,
  _ e: Tagged<Tag, E>,
  _ f: Tagged<Tag, F>,
  _ g: Tagged<Tag, G>,
  _ h: Tagged<Tag, H>,
  _ i: Tagged<Tag, I>,
  _ j: Tagged<Tag, J>
  ) -> Tagged<Tag, Z> {
  return zip(a, b, c, d, e, f, g, h, i, j).map(transform)
}
