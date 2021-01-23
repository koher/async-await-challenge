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
func download(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    do {
        let data: Data = try Data(contentsOf: url)
        completion(.success(data))
    } catch {
        completion(.failure(error))
    }
}

func fetchUserWithThumbnail(for id: User.ID, completion: @escaping (Result<(user: User, thumbnail: Data), Error>) -> Void) {
    let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/user?id=\(id.description)")!
    // 🚧 ここを実装する



}

fetchUserWithThumbnail(for: 123) { result in
    do {
        let (user, thumbnail) = try result.get()
        print(user.name, thumbnail.count)
    } catch {
        print(error)
    }
}
