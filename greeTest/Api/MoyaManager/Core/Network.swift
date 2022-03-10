//
//  Network.swift
//  MoyaManager
//
//  Created by 陈思欣 on 2019/5/8.
//  Copyright © 2019 chensx. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import SwiftyJSON

public typealias Success = (_ response: Moya.Response) -> Void
public typealias Failure = (_ error: NetworkError) -> Void
public typealias JsonSuccess = (_ response: Any) -> Void


public struct Networking<T: MyServerType> {
    public let provider: MoyaProvider<T>
    
    public init(provider: MoyaProvider<T> = newDefaultProvider()) {
        self.provider = provider
    }
}

extension Networking {

    
    // MARK: - requestJson
    /// - Parameters:
    ///   - target: 请求目标
    ///   - callbackQueue: 回调队列
    ///   - progress: 进度响应
    ///   - success: 成功回调
    ///   - failure: 失败回调
    @discardableResult
    public func requestJson(_ target: T,
                            callbackQueue: DispatchQueue? = DispatchQueue.main,
                            progress: ProgressBlock? = .none,
                            success: @escaping JsonSuccess,
                            failure: @escaping Failure) -> Cancellable {
        return self.request(target, callbackQueue: callbackQueue, progress: progress, success: { (response) in
            do {
                let json = try handleResponse(response)
                let result = JSON.init(json)
                //**
                #if DEBUG
                    print(result)
                #endif
                success(json)
            } catch (let error) {
                failure(error as! NetworkError)
            }
        }) { (error) in
            #if DEBUG
                print(error)
            #endif
            failure(error)
        }
    }
    
    
    // MARK: - request
    /// - Parameters:
    ///   - target: 请求目标
    ///   - callbackQueue: 回调队列
    ///   - progress: 进度响应
    ///   - success: 成功回调
    ///   - failure: 失败回调
    @discardableResult
    public func request(_ target: T,
                        callbackQueue: DispatchQueue? = DispatchQueue.main,
                        progress: ProgressBlock? = .none,
                        success: @escaping Success,
                        failure: @escaping Failure) -> Cancellable {
        return self.provider.request(target, callbackQueue: callbackQueue, progress: progress) { (result) in
            switch result {
            case let .success(response):
                success(response);
            case let .failure(error):
                #if DEBUG
                print(error)
                #endif
                let err = NetworkError.init(error: error)
                failure(err);
                break
            }
        }
    }
}

extension Networking {
    
    
    // MARK: - requestModel
    /// - Parameters:
    ///   - target: 请求目标
    ///   - callbackQueue: 回调队列
    ///   - progress: 进度响应
    ///   - success: 成功回调
    ///   - mistake: 错误回调
    ///   - failure: 失败回调
    @discardableResult
    public func requestModel<D>(_ target: T,
                            callbackQueue: DispatchQueue? = DispatchQueue.main,
                            progress: ProgressBlock? = .none,
                            success: @escaping ((D, _ message: String)->()),
                            mistake: @escaping ((_ result: Int, _ message: String)->()),
                            failure: @escaping ((Error)->())) -> Cancellable {
        return self.request(target, callbackQueue: callbackQueue, progress: progress, success: { (response) in
            do {
                // 拿到json
                let json: [String: Any] = try response.filterSuccessfulStatusCodes().mapJSON() as! [String : Any]
                // json转大模型
                if let model: GMVersionBasicsModel<D> = GMVersionBasicsModel<D>.deserialize(from: json) {
                    if model.result == 0 {
                        // 成功回调泛型的模型,和后端信息
                        if let data = model.data {
                            success(data, model.message)
                        } else {
                            mistake(10000,"data为空")
                        }
                    } else {
                        // 网络请求成功，但后台返回错误，失败回调result message
                        mistake(model.result!,model.message)
                    }
                } else {
                    // json转大模型失败，回调错误
                    failure(NetworkError(error: .jsonMapping(response)))
                }
            } catch (let error) {
                // 网络请求成功，但解析response失败，回调错误
                failure(error as! MoyaError)
            }
        }) { (error) in
            // 网络请求直接失败，回调错误
            #if DEBUG
                print(error)
            #endif
            failure(error)
        }
    }
}

extension Networking {
    
    public static func newDefaultProvider() -> MoyaProvider<T> {
        return newProvider(plugins: plugins)
    }
    
    static func endpointsClosure<T>() -> (T) -> Endpoint where T: MyServerType {
        return { target in
            let defaultEndpoint = Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { target.sampleResponse },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
            return defaultEndpoint;
        }
    }
    
    //测试网络错误,如超时等.
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = false
                request.timeoutInterval = WebService.shared.timeoutInterval
                closure(.success(request))
            } catch let error {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
    
    static func APIKeysBasedStubBehaviour<T>(_ target: T) -> Moya.StubBehavior where T: MyServerType {
        return target.stubBehavior;
    }
    
    static var plugins: [PluginType] {
        let activityPlugin = NewNetworkActivityPlugin { (state, targetType) in
            switch state {
            case .began:
                if targetType.isShowLoading { //这是我扩展的协议
                    // 显示loading
                }
            case .ended:
                if targetType.isShowLoading { //这是我扩展的协议
                    // 关闭loading
                }
            }
        }
        
        return [
            activityPlugin, myLoggorPlugin
        ]
    }
    
    
}

func newProvider<T>(plugins: [PluginType],session: Session = newManager()) -> MoyaProvider<T> where T: MyServerType {
    
    return MoyaProvider(endpointClosure: Networking<T>.endpointsClosure(),
                        requestClosure: Networking<T>.endpointResolver(),
                        stubClosure: Networking<T>.APIKeysBasedStubBehaviour,
                        session: session,
                        plugins: plugins,
                        trackInflights: false
    )
}


func newManager(delegate: SessionDelegate = SessionDelegate()) -> Session {
//    let configuration = URLSessionConfiguration.default
//    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    let configuration = Alamofire.Session.default.session.configuration
    let session = Alamofire.Session(configuration: configuration, delegate: delegate, startRequestsImmediately: false)
    return session
}

//protocol NetworkingType {
//    associatedtype T: TargetType
//    var provider: MoyaProvider<T> { get }
//}
//
//public struct Networking: NetworkingType {
//    public typealias T = CommonAPI
//    public let provider: MoyaProvider<CommonAPI>  = newProvider(plugins)
//
//    public init() {
//    }
//}
