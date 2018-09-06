# DouYuLive
[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/Dzhijian/DouYuLive)
### **仿斗鱼直播-Swift4.0**
本项目是模仿斗鱼iOS最新版本，使用 `Swift4.0`开发，所有资源均来自斗鱼，API接口通过抓取斗鱼App获得，仅供学习参考使用。
整个项目比较大，我是利用闲余时间写的，未完成功能较多，后面会持续更新完成。。。
请大佬们多多指教，给个 Star，你的支持就是我不断前进的动力，谢谢。
### Author

**作者**：**coderDeng**, 
**QQ**: 646724452
**Email**: 646724452@qq.com 

### 示例图
![斗鱼](http://p7l9kf5i4.bkt.clouddn.com/2018-08-31-斗鱼.gif)
#### 项目环境
Xcode : 9.3
Swift : 4.0
  iOS : 11.4
### 使用框架

#### 网络层

使用 **Alamofire** + **Moya** + **ObjectMapper** 请求网络和解析数据，封装了一层Provider请求 **`ZJNetworkProvider`**

``` swift
 /// 请求JSON数据
    func requestDataWithTargetJSON<T:TargetType>(target : T, successClosure: @escaping SuccessJSONClosure, failClosure: @escaping FailClosure) {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
        let _ = requestProvider.request(target) { (result) -> () in
            switch result{
            case let .success(response):
                do {
                    let mapjson = try response.mapJSON()
                    let json = JSON(mapjson)
                    guard let _ = json.dictionaryObject else{
                        failClosure(self.failInfo)
                        return
                    }
                    successClosure(json["data"])
                } catch {
                    failClosure(self.failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
    }
    
```

也有使用自己封装的 `Alamofire`，使用 `Decodable` 解析数据

``` swift
    class func requestData(type : ZJMethod, URlString: String, parameters : [String : String]? = nil,  finishCallBack : @escaping (_ responseCall : Data)->()){
        
        let type = type == ZJMethod.GET ? HTTPMethod.get : HTTPMethod.post
        // 配置 HTTPHeaders
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "charset":"utf-8",
            ]
   
        Alamofire.request(URlString, method: type, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            // 处理 cookie
            let headerFields = response.response?.allHeaderFields as! [String: String]
            let url = response.request?.url
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url!)
            var cookieArray = [ [HTTPCookiePropertyKey : Any ] ]()
            for cookie in cookies {
                cookieArray.append(cookie.properties!)
            }
            if !(UserDefaults.standard.object(forKey: ZJ_DOUYU_TOKEN) != nil){
                // 保存 cookie
                UserDefaults.standard.set(cookieArray, forKey: ZJ_DOUYU_TOKEN)
            }else{
                print("token\(String(describing: UserDefaults.standard.object(forKey: ZJ_DOUYU_TOKEN)))")
            }
            print("Method:\(type)请求\nURL: \(URlString)\n请求参数: \(String(describing: parameters))")
            if parameters != nil{
                print(response.request?.url ?? "url")
                
                print(parameters ?? String())
            }
            
            guard let result = response.result.value else {
                print(response.result.error ?? "错误❌")
                return
            }
            
            guard let dict = result as? [String : Any] else {
                return
            }
            
            // 返回字典类型 Data
            if let dataDict = dict["data"] as? [String : Any] {
                
                let jsonData = try? JSONSerialization.data(withJSONObject: dataDict, options: .prettyPrinted)
                print(dict)
                if jsonData != nil {
                    finishCallBack(jsonData!)
                    return
                }
            }
            
            // 返回数组类型Data
            if ((dict["data"] as? [Any]) != nil) {
                let arrData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                print(dict)
                if arrData != nil {
                    finishCallBack(arrData!)
                }
            }
        
        }
    }       
```

#### 约束布局
采用 **SnapKit** 对控件的约束,扩展了一层快速创建的控件的**UIView**，与**SnapKit**框架结合

``` swift
 /// 快速创建 Label,设置文本, 文本颜色,Font,文本位置,父视图,约束
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - font: 字体大小
    ///   - textAlignment: 文本位置
    ///   - supView: 父视图
    ///   - closure: 越是
    /// - Returns:  UILabel
    class func zj_createLabel(text : String? , textColor : UIColor?, font : UIFont?, textAlignment : NSTextAlignment = .left,supView : UIView? ,closure:(_ make : ConstraintMaker) ->()) -> UILabel {
        
        let label = UILabel()
        label.text = text
        if (textColor != nil) { label.textColor = textColor }
        if (font != nil) { label.font = font }
        label.textAlignment = textAlignment
        if supView != nil {
            supView?.addSubview(label)
            label.snp.makeConstraints { (make) in
                closure(make)
            }
        }
        return label
    }
```
#### 图片加载
使用 **Kingfisher** 加载图片，扩展了一层加载方法，可以更安全快速的设置图片与占位图

``` swift
/// 1.加载网络图片
    ///
    /// - Parameters:
    ///   - urlStr: 图片 URL地址
    ///   - placeholder: 占位图
    func zj_setImage(urlStr: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlStr) else {
            print("url:|\(urlStr)|无法解析为URL类型")
            if let placeholder = placeholder{
                self.image = placeholder
            }
            return
        }
        kf.setImage(with: url, placeholder: placeholder, options: [.backgroundDecode], progressBlock: nil, completionHandler: nil)
    }
    
```
后期将会加入 **RxSwift** 处理业务

### 自定义视图
本项目多出采用自定义的视图，纯 `Swift` 完成。

* 自定义无限轮播图
* 自定义分段滚动视图
* 自定义加载动画


