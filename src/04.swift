// サーバーから User とその Article 最新 10 件の JSON を取得し、
// それらを返す非同期関数 fetchUserWithArticles を実装して下さい。
// ただし、 User と Article の JSON は並行して取得するものとし、
// User と Artcile の取得には fetchUser および
// fetchArticles を用いるものとします。

import Foundation
import FoundationNetworking

struct User: Identifiable, Codable {
    typealias ID = Int
    let id: ID
    var name: String
    var thumbnailURL: URL
}
struct Article: Identifiable, Codable {
    typealias ID = Int
    let id: ID
    var title: String
}
func fetchUser(for id: User.ID) async throws -> User {
    let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/user?id=\(id.description)")!
    let data: Data = try Data(contentsOf: url)
    let user: User = try JSONDecoder().decode(User.self, from: data)
    return user
}
func fetchArticles(for userID: User.ID, limit: Int) async throws -> [Article] {
    let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/articles?userID=\(userID.description)")!
    let data: Data = try Data(contentsOf: url)
    let articles: [Article] = try JSONDecoder().decode([Article].self, from: data)
    return articles
}

func fetchUserWithArticles(for id: User.ID, limit: Int) async throws -> (user: User, articles: [Article]) {
    // 🚧 ここを実装する



}

runAsyncAndBlock {
    do {
        let (user, articles) = try await fetchUserWithArticles(for: 123, limit: 10)
        print(user, articles)
    } catch {
        print(error)
    }
}