import Foundation

func main() {
    // Actor 버전 사용 (비동기 컨텍스트 필요)
    Task {
        let actorManager = KeyChainManagerWithActor.shared
        do {
            try await actorManager.save(object: Data("ActorData".utf8), account: "test2")
            let data = try await actorManager.loadData(account: "test1")
            print("Actor Loaded:", String(data: data!, encoding: .utf8)!)
            try await actorManager.delete(account: "test2")
        } catch {
            print("Actor Error:", error)
        }
    }
}
