## Keychain Manager  

Keychain Manager는 **iOS Keychain**을 안전하게 관리하는 유틸리티로, **Actor 기반 동시성 처리**와 **NSLock 기반 동기적 처리**를 지원합니다.  
Swift Concurrency 환경에서도 안전하게 동작하도록 설계되었으며, **Swift Package Manager(SPM)**을 통해 쉽게 통합할 수 있습니다.  

## Requirements 
- iOS 13.0+
- Swift 5.5+

## Installation 
> Swift Package Manager

```swift 
dependencies: [
    .package(url: "https://github.com/Kyxxn/KeyChain-Manager.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage
### Initialization
두 가지 구현체 중 필요에 따라 선택해 사용할 수 있습니다.

``` swift
// Actor 기반 구현체
let actorManager = KeyChainManagerWithActor.shared

// NSLock 기반 구현체
let lockManager = KeyChainManagerWithNSLock.shared
```

### 데이터 저장
``` swift
// 기본 데이터 저장
try await actorManager.save(with: data, account: "userData")

// 문자열 저장
try lockManager.save(string: "SecretToken", account: "authToken")

// Bool 값 저장
try await actorManager.save(bool: true, account: "autoLoginEnabled")

// Codable 객체 저장
struct UserSettings: Codable {
    let darkMode: Bool
    let fontSize: Int
}
try lockManager.save(object: UserSettings(darkMode: true, fontSize: 16), account: "userSettings")
```

### 데이터 조회
``` swift
// 데이터 조회
let data = try await actorManager.loadData(account: "userData")

// 문자열 조회
let token = try lockManager.loadString(account: "authToken")

// Bool 값 조회
let isEnabled = try await actorManager.loadBool(account: "autoLoginEnabled")

// Codable 객체 조회
let settings = try lockManager.loadObject(account: "userSettings", type: UserSettings.self)
```

### 데이터 삭제
``` swift
try await actorManager.delete(account: "tempData")
try lockManager.delete(account: "cachedResults")
```


## Description
Thread-safe하게 구현된 키체인 관리 유틸리티로, 다음 특징을 가지고 있습니다

- 두 가지 구현 방식 제공

    - KeyChainManagerWithActor: Swift Actor 기반 동시성 제어

    - KeyChainManagerWithNSLock: NSLock 기반 동시성 제어

- 지원 데이터 타입

    - 기본 Data 타입

    - String/Bool 값

    - Codable 프로토콜을 준수하는 모든 객체

- 주요 기능

    - 키 기반 데이터 저장/조회/삭제

    - 중복 키 자동 업데이트 처리

    - 키체인 접근성 옵션 지원 (accessibility 파라미터)

    - 타입 안전한 데이터 처리

- 에러 처리
    ``` swift
    enum KeyChainError: Error, CustomStringConvertible {
        case duplicateItem
        case itemNotFound
        case unexpectedStatus(OSStatus)
        case typeConversionError
        case invalidData
    }
    ```
