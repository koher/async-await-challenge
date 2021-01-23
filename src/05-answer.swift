// ViewController の reloadUserButton が押されたときに
// fetchUser 関数を使ってサーバーから User を取得し、
// userNameLabel.text に取得したユーザーの name を設定するように
// onReloadUserButtonPressed メソッドを完成させて下さい。

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
    let userNameLabel: UILabel = .init()
    let userID: User.ID
    init(userID: User.ID) { self.userID = userID }
    
    @asyncHandler
    func onReloadUserButtonPressed(_ sender: UIButton) {
        if let user = try? await fetchUser(for: userID) {
            userNameLabel.text = user.name
        }
    }
}

let viewController: ViewController = .init(userID: 123)
viewController.onReloadUserButtonPressed(viewController.reloadUserButton)
