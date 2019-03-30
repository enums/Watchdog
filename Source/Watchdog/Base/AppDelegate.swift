//
//  AppDelegate.swift
//  Calatrava
//
//  Created by 郑宇琦 on 2017/6/24.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import SwiftyJSON
import PerfectHTTP
import Pjango

class AppDelegate: PjangoDelegate {
    
    func setSettings() {
        
        // Pjango
        #if os(macOS)
            PJANGO_WORKSPACE_PATH = APP_CONFIG.string(forKey: "macos_workspace_path") ?? "/Watchdog"
        #else
            PJANGO_WORKSPACE_PATH = APP_CONFIG.string(forKey: "workspace_path") ?? "/Watchdog"
        #endif
        
        PJANGO_LOG_DEBUG = APP_CONFIG.bool(forKey: "log_debug") ?? true
        
        PJANGO_SERVER_PORT = UInt16(APP_CONFIG.int(forKey: "port") ?? 80)
        
        // Django
        
        PJANGO_BASE_DIR = APP_CONFIG.string(forKey: "base_dir") ?? ""
        
        PJANGO_TEMPLATES_DIR = APP_CONFIG.string(forKey: "templates") ?? "templates"
        
        PJANGO_STATIC_URL = APP_CONFIG.string(forKey: "static") ?? "static"
    }
    
    func setUrls() -> [String: [PCUrlConfig]]? {
        
        return [
            PJANGO_HOST_DEFAULT: [
                pjangoUrl("domain_error", name: "error.domain_error", handle: DomainErrorView.asHandle()),
                pjangoUrl("website_dead", name: "error.website_dead", handle: WebsiteDeadView.asHandle()),
                
                pjangoUrl("api/reload", name: "api.reload", handle: reloadHandle),
            ],
            
        ]
    }
    
    func registerPlugins() -> [PCPlugin]? {
        return [
            BootPlugin.meta,
            RouterFilterPlugin.meta,
            NotFoundFilterPlugin.meta,
        ]
    }
}
