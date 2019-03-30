//
//  NotFoundFilterPlugin.swift
//  Watchdog
//
//  Created by enum on 2019/3/25.
//

import Foundation
import PerfectHTTP
import Pjango

class NotFoundFilterPlugin: PCHTTPFilterPlugin {
    
    override func responseFilterHeader(req: HTTPRequest, res: HTTPResponse) -> Bool {
        if case .notFound = res.status {
            pjangoHttpRedirect(url: "http://\(WEBSITE_HOST)/domain_error")(req, res)
            return false
        } else {
            return true
        }
        
    }
    
}
