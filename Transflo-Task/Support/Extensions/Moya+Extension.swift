//
//  Moya+Extension.swift
//  SellerApp
//
//  Created by Mohamad Basuony on 06/10/2022.
//

import Foundation
import Moya
import Alamofire

extension Moya.Response {
    var isSuccess: Bool {
        return (200 ... 299) ~= self.statusCode
    }
    
    var isAppTokenExpired: Bool {
        return self.statusCode == 401
    }
}

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}

struct QueryArrayEncoding: ParameterEncoding {
    
    public static var `default`: QueryArrayEncoding { return QueryArrayEncoding() }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return request }
        
        guard let url = request.url else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
            urlComponents.percentEncodedQuery = percentEncodedQuery
            request.url = urlComponents.url
        }
        return request
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            if let value = parameters[key] {
                components += queryComponents(fromKey: key, value: value)
            }
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: key, value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((key, value.boolValue ? "1" : "0"))
            } else {
                components.append((key, "\(value)"))
            }
        } else {
            components.append((key, "\(value)"))
        }
        return components
    }
}

extension MoyaProvider {
    
    convenience init(handleRefreshToken: Bool , plugins: [PluginType] = []) {
            if handleRefreshToken {
                self.init(requestClosure: MoyaProvider.endpointResolver() , plugins: plugins)
            } else {
                self.init()
            }
        }

    static func endpointResolver() -> MoyaProvider<Target>.RequestClosure {
        return { (endpoint, closure) in
            //Getting the original request
            var request = try! endpoint.urlRequest()
            
            //Do a request to refresh the authtoken based on refreshToken
//            MSALAdapter.shared.refreshToken { failed in
//                if !failed {
                    closure(.success(request))
//                }else{
//                    closure(.failure(MoyaError.requestMapping("Could Not Refresh Token")))
//                }
//            }
        }
    }
}
