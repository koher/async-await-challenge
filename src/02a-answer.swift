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
func download(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    do {
        let data: Data = try Data(contentsOf: url)
        completion(.success(data))
    } catch {
        completion(.failure(error))
    }
}

func fetchUser(for id: User.ID, completion: @escaping (Result<User, Error>) -> Void) {
    let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/user?id=\(id.description)")!
    download(from: url) { data in
        do {
            let user: User = try JSONDecoder().decode(User.self, from: data.get())
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }
}

fetchUser(for: 123) { user in
    do {
        print(try user.get().name)
    } catch {
        print(error)
    }
}
