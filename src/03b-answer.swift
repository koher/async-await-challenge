// サーバーから JSON を取得し、
// User インスタンスをデコードし、
// それに加えて User が保持する thumbnailURL から
// サムネイル画像をダウンロードする非同期関数
// fetchUserWithThumbnail を完成させて下さい。

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

func fetchUserWithThumbnail(for id: User.ID) async throws -> (user: User, thumbnail: Data) {
    let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/user?id=\(id.description)")!
    let data = try await download(from: url)
    let user: User = try JSONDecoder().decode(User.self, from: data)
    let thumbnail: Data = try await download(from: user.thumbnailURL)
    return (user: user, thumbnail: thumbnail)
}

runAsyncAndBlock {
    do {
        let (user, thumbnail) = try await fetchUserWithThumbnail(for: 123)
        print(user.name, thumbnail.count)
    } catch {
        print(error)
    }
}
