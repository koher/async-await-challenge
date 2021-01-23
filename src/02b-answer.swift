// サーバーから JSON を取得し、
// User インスタンスをデコードする
// 非同期関数 fetchUser を完成させて下さい。

import Foundation
import FoundationNetworking

struct User: Identifiable, Codable {
    typealias ID = Int
    let id: ID
    var name: String
    var thumbnailURL: URL
}
func download(from url: URL) async throws -> Data {
    let data: Data = try Data(contentsOf: url)
    return data
}

func fetchUser(for id: User.ID) async throws -> User {
    let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/user?id=\(id.description)")!
    let data: Data = try await download(from: url)
    let user: User = try JSONDecoder().decode(User.self, from: data)
    return user
}

runAsyncAndBlock {
    do {
        let user: User = try await fetchUser(for: 123)
        print(user.name)
    } catch {
        print(error)
    }
}
