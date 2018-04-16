import Foundation
import Tagged

enum EmailTag {}
typealias Email = Tagged<EmailTag, String>

struct User: Decodable {
  typealias Id = Tagged<User, Int>

  let id: Id
  let name: String
  let email: Email
  let subscriptionId: Subscription.Id?
}

struct Subscription: Decodable {
  typealias Id = Tagged<Subscription, Int>

  let id: Id
  let ownerId: User.Id
}

let user = User(
  id: 1,
  name: "Blob",
  email: "blob@pointfree.co",
  subscriptionId: 1
)

let subscription = Subscription(id: 1, ownerId: 1)

let decoder = JSONDecoder()

let users = try! decoder.decode(
  [User].self,
  from: Data(
    """
    [
      {"id": 1, "name": "Blob", "email": "blob@pointfree.co", "subscriptionId": 1},
      {"id": 2, "name": "Brandon", "email": "brandon@pointfree.co", "subscriptionId": 1},
      {"id": 3, "name": "Stephen", "email": "stephen@pointfree.co", "subscriptionId": null},
    ]
    """.utf8
  )
)

let subscriptions = try! decoder.decode(
  [Subscription].self,
  from: Data(
    """
    [
      {"id": 1, "ownerId": 1},
    ]
    """.utf8
  )
)
