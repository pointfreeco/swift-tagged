@freestanding(declaration, names: arbitrary)
public macro Tagged<RawValue>(_ typealiasName: String) = #externalMacro(module: "TaggedMacroPlugin", type: "TaggedMacro")
