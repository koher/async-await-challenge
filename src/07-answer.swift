// コールバックで結果を受け取る非同期関数 download を使って、
// async で結果を返す非同期関数 download を実装して下さい。

import Foundation
import FoundationNetworking

func download(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    do {
        let data: Data = try Data(contentsOf: url)
        completion(.success(data))
    } catch {
        completion(.failure(error))
    }
}

func download(from url: URL) async throws -> Data {
    try await withUnsafeThrowingContinuation { continuation in
        download(from: url) { data in
            continuation.resume(with: data)
        }
    }
}

runAsyncAndBlock {
    do {
        let url: URL = URL(string: "https://koherent.org/async-await-challenge/api/user?id=123")!
        let data: Data = try await download(from: url)
        print(String(data: data, encoding: .utf8)!)
    } catch {
        print(error)
    }
}
