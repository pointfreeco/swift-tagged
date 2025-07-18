import MacroTesting
import TaggedMacroPlugin
import Testing

@Suite(
  .macros(
    ["Tagged": TaggedMacro.self],
    record: .failed
  )
)
struct TaggedMacroPluginTests {
  @Test
  func testTaggedInt() {
    assertMacro {
      """
      struct User {
        #Tagged<UUID>("ID")
      }
      """
    } diagnostics: {
      """

      """
    } expansion: {
      """
      struct User {
        typealias ID = Tagged<((), __macro_local_2IDfMu_: ()), UUID>
      }
      """
    }
  }
}
