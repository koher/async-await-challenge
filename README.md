# 先取り！ Swift 6 の async/await 練習問題

`async/await` の Proposal が Accept され、 Swift に `async/await` が導入されることが決定しました。本リポジトリには、そんな Swift の `async/await` を使ったコードを実務でどのように使うのか、一足早く練習できる問題を作成しました。

本練習問題は Web API から `User` の JSON を取得し、それをデコードして返す非同期処理を題材にしています。

```swift
struct User: Identifiable, Codable {
    typealias ID = Int
    let id: ID
    var name: String
    var thumbnailURL: URL
}
```

問題は 01 - 07 まであり、それぞれ非同期処理のエラーハンドリングや並行処理など、実務で直面しそうなケースを取り上げています（ただし、 **どの問題の解答も数行程度のコードで書けます** ）。 01 - 03 については A と B があり、同じ処理を A ではコールバックで、 B では `async/await` を使ってコードを書く問題になっています。そのため、これまでコールバックで書いていたコードがどのように `async/await` と対応するのか、どのように変化するのかを対比して理解することができます。

| 問題 | 解答例 | テーマ | 
|:--|:--|:--|
| [01A](src/01a.swift), [01B](src/01b.swift) | [01A](src/01a-answer.swift), [01B](src/01b-answer.swift) | `async/await` （エラーハンドリングなし） |
| [02A](src/02a.swift), [02B](src/02b.swift) | [02A](src/02a-answer.swift), [02B](src/02b-answer.swift) | `async/await` （エラーハンドリングあり） |
| [03A](src/03a.swift), [03B](src/03b.swift) | [03A](src/03a-answer.swift), [03B](src/03b-answer.swift) | `async/await` （連続した複数の処理） |
| [04](src/04.swift) | [04](src/04-answer.swift) | `async let` （並行処理） |
| [05](src/05.swift) | [05](src/05-answer.swift) | `@asyncHandler` （ `async` の起点） |
| [06](src/06.swift) | [06](src/06-answer.swift) | `Task.Handle` とキャンセル |
| [07](src/07.swift) | [07](src/07-answer.swift) | Continuation （コールバックからの変換） |

