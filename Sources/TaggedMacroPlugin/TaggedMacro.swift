import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

public struct TaggedMacro: DeclarationMacro {
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    guard let typealiasName = node.arguments.first?.expression.as(StringLiteralExprSyntax.self)?.segments.compactMap({ $0.as(StringSegmentSyntax.self)?.content.text }).first else {
      context.diagnose(
        Diagnostic(
          node: node,
          message: MacroExpansionErrorMessage("Tagged macro requires a type name argument")
        )
      )
      return []
    }
    guard let rawValueType = node.genericArgumentClause?.arguments.first?.argument.as(IdentifierTypeSyntax.self)?.name.text else {
      context.diagnose(
        Diagnostic(
          node: node,
          message: MacroExpansionErrorMessage("Tagged macro requires a raw value type argument")
//          fixIt: FixIt(
//            message: MacroExpansionFixItMessage(
//                """
//                Insert ': <#Type#>'
//                """
//            ),
//            changes: [
//              .replace(
//                oldNode: Syntax(binding),
//                newNode: Syntax(
//                  binding
//                    .with(\.pattern.trailingTrivia, "")
//                    .with(
//                      \.typeAnnotation,
//                       TypeAnnotationSyntax(
//                        colon: .colonToken(trailingTrivia: .space),
//                        type: IdentifierTypeSyntax(name: "<#Type#>"),
//                        trailingTrivia: .space
//                       )
//                    )
//                )
//              )
//            ]
//          )
        )
      )
      return []
    }
    let uniqueTagTypeName = context.makeUniqueName(typealiasName)

    let taggedType = "Tagged<((), \(uniqueTagTypeName): ()), \(rawValueType)>"
//    let rawValueExpr = node.argumentList.first?.expression ?? ExprSyntax("")

    return [
      """
      typealias \(raw: typealiasName) = \(raw: taggedType) 
      """
    ]
  }

  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
//    guard let rawValueType = node.argumentList.first?.expression.as(IdentifierExprSyntax.self)?.identifier.text else {
//      throw MacroError("Tagged macro requires a raw value type argument")
//    }
    guard let rawValueType = node.genericArgumentClause?.arguments.first?.argument.as(IdentifierTypeSyntax.self)?.name.text else {
      context.diagnose(
        Diagnostic(
          node: node,
          message: MacroExpansionErrorMessage("Tagged macro requires a raw value type argument")
//          fixIt: FixIt(
//            message: MacroExpansionFixItMessage(
//                """
//                Insert ': <#Type#>'
//                """
//            ),
//            changes: [
//              .replace(
//                oldNode: Syntax(binding),
//                newNode: Syntax(
//                  binding
//                    .with(\.pattern.trailingTrivia, "")
//                    .with(
//                      \.typeAnnotation,
//                       TypeAnnotationSyntax(
//                        colon: .colonToken(trailingTrivia: .space),
//                        type: IdentifierTypeSyntax(name: "<#Type#>"),
//                        trailingTrivia: .space
//                       )
//                    )
//                )
//              )
//            ]
//          )
        )
      )
      return ""
    }
    let uniqueTagTypeName = context.makeUniqueName(rawValueType)

    let taggedType = "Tagged<\(uniqueTagTypeName), \(rawValueType)>"
//    let rawValueExpr = node.argumentList.first?.expression ?? ExprSyntax("")

    return ExprSyntax(
      """
      \(raw: taggedType)
      """
    )
  }
}
