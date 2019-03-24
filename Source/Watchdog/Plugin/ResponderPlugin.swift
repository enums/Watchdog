//
//  ResponderPlugin.swift
//  Watchdog
//
//  Created by 郑宇琦 on 2019/3/24.
//

import Foundation
import Pjango
import PerfectHTTP
import PerfectCURL
import cURL

fileprivate let HOST_NOT_FOND_RESPONSE = """
<html>
<head>
<meta charset="utf-8">
</head>
<body>
域名不正确
</body>
</html>
"""

fileprivate let SERVER_NOT_FOND_RESPONSE = """
<html>
<head>
<meta charset="utf-8">
</head>
<body>
施工中...
</body>
</html>
"""

class ResponderPlugin: PCHTTPFilterPlugin {
    
    open override func requestFilter(req: HTTPRequest, res: HTTPResponse) -> Bool {
        guard let host = req.header(.host), let serverPort = WEBSITE_HOSTS[host] else {
            pjangoHttpResponse(HOST_NOT_FOND_RESPONSE)(req, res)
            return false
        }
        let ip = req.remoteAddress.host
        let port = req.remoteAddress.port
        let url = "http://\(host):\(serverPort)/\(req.uri)"
        
        let curl: CURLRequest = {
            switch req.method {
            case .get:
                return CURLRequest.init(url)
            case .post:
                return CURLRequest.init(url, .postData(req.postBodyBytes ?? []))
            default:
                return CURLRequest.init(url)
            }
        }()
        
        curl.addHeader(.custom(name: "watchdog_ip"), value: ip)
        curl.addHeader(.custom(name: "watchdog_port"), value: "\(port)")
        
        guard let response = try? curl.perform() else {
            pjangoHttpResponse(SERVER_NOT_FOND_RESPONSE)(req, res)
            return false
        }
        pjangoHttpResponse(response.bodyBytes)(req, res)
    
        return false
    }
    
    
}
