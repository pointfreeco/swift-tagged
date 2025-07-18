import TaggedMacro
import Testing

@Suite
struct TaggedMacroTests {
  @Test
  func testTaggedInt() {
    struct User {
      #Tagged<String>("ID")
//      #TaggedTypealias("ID", as: UUID.self)
//      #Tagged("ID", as: UUID.self)
    }
  }
}
