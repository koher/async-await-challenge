// ViewController の cancelReloadingUser ボタンを押すと
// reloadUser ボタンで実行されている User のリロードを
// キャンセルするように ViewController の実装を完成させて下さい。

import Foundation
import FoundationNetworking

class UIViewController {}
final class UIButton {}
final class UILabel {
    var text: String?
}

struct User: Identifiable, Codable {
    typealias ID = Int
    let id: ID
    var name: String
    var thumbnailURL: URL
}
func fetchUser(for id: User.ID) async throws -> User {
    let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/user?id=\(id.description)")!
    let data: Data = try Data(contentsOf: url)
    let user: User = try JSONDecoder().decode(User.self, from: data)
    return user
}

final class ViewController: UIViewController {
    let reloadUserButton: UIButton = .init()
    let cancelReloadingUserButton: UIButton = .init()
    let userNameLabel: UILabel = .init()
    let userID: User.ID
    init(userID: User.ID) { self.userID = userID }

    private var userReloadingHandle: Task.Handle<Void>?

    func onReloadUserButtonPressed(_ sender: UIButton) {
        guard userReloadingHandle == nil else { return }
        userReloadingHandle = Task.runDetached { [self] in
            if let user = try? await fetchUser(for: userID) {
                userNameLabel.text = user.name
            }
        }
    }

    func onCancelReloadingUserButtonPressed(_ sender: UIButton) {
        userReloadingHandle?.cancel()
        userReloadingHandle = nil
    }
}

let viewController: ViewController = .init(userID: 123)
viewController.onReloadUserButtonPressed(viewController.reloadUserButton)
viewController.onCancelReloadingUserButtonPressed(viewController.cancelReloadingUserButton)
