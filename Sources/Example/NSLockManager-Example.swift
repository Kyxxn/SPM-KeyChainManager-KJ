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
}
