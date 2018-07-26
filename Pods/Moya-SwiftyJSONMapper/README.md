# Moya-SwiftyJSONMapper

[![Version](https://img.shields.io/cocoapods/v/Moya-SwiftyJSONMapper.svg?style=flat)](http://cocoapods.org/pods/Moya-SwiftyJSONMapper)
[![Build Status](https://travis-ci.org/AvdLee/Moya-SwiftyJSONMapper.svg?style=flat&branch=master)](https://travis-ci.org/AvdLee/Moya-SwiftyJSONMapper)
[![Language](https://img.shields.io/badge/language-swift3.0-f48041.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/cocoapods/l/Moya-SwiftyJSONMapper.svg?style=flat)](http://cocoapods.org/pods/Moya-SwiftyJSONMapper)
[![Platform](https://img.shields.io/cocoapods/p/Moya-SwiftyJSONMapper.svg?style=flat)](http://cocoapods.org/pods/Moya-SwiftyJSONMapper)
[![Twitter](https://img.shields.io/badge/twitter-@twannl-blue.svg?style=flat)](http://twitter.com/twannl)

## Usage

### Example project
To run the example project, clone the repo, and run `pod install` from the Example directory first. It includes sample code and unit tests.


### Model definitions
Create a `Class` or `Struct` which implements the `Mappable` protocol.

```swift
import Foundation
import Moya_SwiftyJSONMapper
import SwiftyJSON

final class GetResponse : ALSwiftyJSONAble {
    
    let url:URL?
    let origin:String
    let args:[String: String]?
    
    required init?(jsonData:JSON){
        self.url = jsonData["url"].URL
        self.origin = jsonData["origin"].stringValue
        self.args = jsonData["args"].object as? [String : String]
    }
    
}
```

### 1. Without RxSwift or ReactiveCocoa
```swift
stubbedProvider.request(ExampleAPI.GetObject) { (result) -> () in
    switch result {
    case let .success(response):
        do {
            let getResponseObject = try response.map(to: GetResponse.self)
            print(getResponseObject)
        } catch {
            print(error)
        }
    case let .failure(error):
        print(error)
    }
}
```

### 2. With ReactiveCocoa
```swift
stubbedProvider.reactive.request(token: ExampleAPI.GetObject).map(to: GetResponse.self).on(failed: { (error) -> () in
    print(error)
}) { (response) -> () in
    print(response)
}.start()
```

### 3. With RxSwift
```swift
let disposeBag = DisposeBag()
stubbedProvider.rx.request(ExampleAPI.GetObject).map(to: GetResponse.self).subscribe(onNext: { (response) -> Void in
    print(response)
}, onError: { (error) -> Void in
    print(error)
}).addDisposableTo(disposeBag)
```

## Installation

### CocoaPods
Moya-SwiftyJSONMapper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Moya-SwiftyJSONMapper"
```

The subspec if you want to use the bindings over RxSwift.

```ruby
pod "Moya-SwiftyJSONMapper/RxSwift"
```

And the subspec if you want to use the bindings over ReactiveCocoa.

```ruby
pod "Moya-SwiftyJSONMapper/ReactiveCocoa"
```


## Other repo's
If you're using [JASON](https://github.com/delba/JASON) for parsing JSON data, checkout [Moya-JASONMapper](https://github.com/AvdLee/Moya-JASONMapper).

If you're really into reactive programming, checkout [ALDataRequestView](https://github.com/AvdLee/ALDataRequestView) and handle those edge cases with ease! 

## Author

Antoine van der Lee 

Mail: [info@avanderlee.com](mailto:info@avanderlee.com)  
Home: [www.avanderlee.com](https://www.avanderlee.com)  
Twitter: [@twannl](https://www.twitter.com/twannl)
## License

Moya-SwiftyJSONMapper is available under the MIT license. See the LICENSE file for more info.
