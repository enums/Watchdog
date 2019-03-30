//
//  ReloadHandle.swift
//  Watchdog
//
//  Created by enum on 2019/3/26.
//

import Foundation
import Pjango

func reloadHandle() -> PCUrlHandle {
    
    return pjangoHttpResponse { req, res in
        
        loadHostsConfig()
        
        pjangoHttpResponse("1")(req, res)
    }
}
