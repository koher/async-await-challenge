// サーバーから JSON を取得し、
// User インスタンスをデコードする
// 非同期関数 fetchUser を完成させて下さい。
//
// サーバーから JSON を取得するには
// download 関数を用います。
// download の実装は擬似的なものですが
// 変更せずにそのまま利用して下さい。
//
// なお、通信やデコードに起因するエラーは
// 起こらないものとします。

import Foundation
import FoundationNetworking

struct User: Identifiable, Codable {
    typealias ID = Int
    let id: ID
    var name: String
    var thumbnailURL: URL
}
func download(from url: URL) async -> Data {
    let data: Data = try! Data(contentsOf: url)
    return data
}

func fetchUser(for id: User.ID) async -> User {
    let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/user?id=\(id.description)")!
    let data = await download(from: url)
    let user: User = try! JSONDecoder().decode(User.self, from: data)
    return user
}

runAsyncAndBlock {
    let user = await fetchUser(for: 123)
    print(user.name)
}
