//
//  RouterFilterPlugin.swift
//  Watchdog
//
//  Created by 郑宇琦 on 2019/3/24.
//

import Foundation
import Pjango
import PerfectHTTP
import PerfectCURL

#if os(macOS)
let MONITOR_HOST = "monitor.enumsblogtest.com"
#else
let MONITOR_HOST = "monitor.enumsblog.com"
#endif

class RouterLogger {
    
    static let shared = RouterLogger.init()
    
    var queue = DispatchQueue.init(label: "logger")
    
    func log(domain: String) {
        queue.async {
            let url = "http://\(MONITOR_HOST)/api/log?domain=\(domain)"
            let curl = CURLRequest.init(url)
            curl.addHeader(.custom(name: "monitor_command"), value: "skip")
            _ = try? curl.perform()
        }
    }
}

class RouterFilterPlugin: PCHTTPFilterPlugin {
    
    open override func requestFilter(req: HTTPRequest, res: HTTPResponse) -> Bool {
        guard let host = req.header(.host) else {
            pjangoHttpRedirect(url: "http://\(WEBSITE_HOST)/domain_error")(req, res)
            return false
        }
        if host == WEBSITE_HOST {
            return true
        }
        guard let serverPort = REDIRECTION_HOSTS[host] else {
            pjangoHttpRedirect(url: "http://\(WEBSITE_HOST)/domain_error")(req, res)
            return false
        }
        let ip = req.remoteAddress.host
        let port = req.remoteAddress.port
        let url = "http://\(host):\(serverPort)\(req.uri)"
        
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
        
        for header in req.headers {
            curl.addHeader(header.0, value: header.1)
        }
        
        curl.addHeader(.custom(name: "watchdog_ip"), value: ip)
        curl.addHeader(.custom(name: "watchdog_port"), value: "\(port)")
        
        guard let response = try? curl.perform() else {
            pjangoHttpRedirect(url: "http://\(WEBSITE_HOST)/website_dead")(req, res)
            return false
        }
        
        res.status = HTTPResponseStatus.statusFrom(code: response.responseCode)
        
        for header in response.headers {
            res.addHeader(header.0, value: header.1)
        }
        
        pjangoHttpResponse(response.bodyBytes)(req, res)
        
        if req.header(.custom(name: "monitor_command")) != "skip" {
            RouterLogger.shared.log(domain: host)
        }
    
        return false
    }
    
    
}
