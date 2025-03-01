import Foundation

func main() {
    // NSLock 버전 사용
    let nsLockManager = KeyChainManagerWithNSLock.shared
    do {
        try nsLockManager.save(object: Data("NSLockData".utf8), account: "test1")
        let data = try nsLockManager.loadData(account: "test1")
        print("NSLock Loaded:", String(data: data!, encoding: .utf8)!)
        try nsLockManager.delete(account: "test1")
    } catch {
        print("NSLock Error:", error)
    }
    
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

main()

RunLoop.main.run()
