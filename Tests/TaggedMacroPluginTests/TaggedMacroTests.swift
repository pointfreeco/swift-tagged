import TaggedMacro
import Testing

@Suite
struct TaggedMacroTests {
  @Test
  func testTaggedInt() {
    struct User {
      #Tagged<Int>("ID")
      #Tagged<Int>("Age")

      let id: ID
      let age: Age

      init(id: ID, age: Age) {
        self.id = id
        self.age = age
      }
    }
    let user = User(id: 1, age: 42)
    #expect(User.ID.self != User.Age.self)
    #expect(user.id == 1)
    #expect(user.age == 42)
  }
}
