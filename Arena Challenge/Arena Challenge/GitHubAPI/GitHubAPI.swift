//
//  GitHubAPI.swift
//  Arena Challenge
//
//  Created by Fernando Gallo on 08/04/17.
//  Copyright © 2017 arena. All rights reserved.
//

import Foundation
import Moya

let baseURL = URL(string: "https://api.github.com")

enum GitHubAPI {
    case Repositories(language: String, sort: String, page: Int)
    case PullRequests(user: String, repository: String)
}

extension GitHubAPI: TargetType {
    
    var baseURL: URL { return self.baseURL }
    
    var path: String {
        
        switch self {
            
        case .PullRequests(let user, let repository):
            return "/repos/\(user)/\(repository)/pulls"
            
        case .Repositories:
            return "/search/repositories"
            
        }
    }
    
    var parameters: [String: Any]? {
        
        switch self {
            
        case .Repositories(let language, let sort, let page):
            return [
                "q=language": language,
                "sort": sort,
                "page": page
            ]
            
        default:
            return nil
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return "Sample Data".data(using: .utf8)!
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .request
        }
    }
    
}


// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let GitHubProvider = RxMoyaProvider<GitHubAPI>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])


// MARK: - Provider support

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
