//
//  FontRegistrar.swift
//  PacienteMidoconlineSDK
//
//  Created by Christian Martinez on 24/06/25.
//

import CoreText
import UIKit

enum FontRegistrar {
    static func register() {
        guard !registered else { return }
        registered = true

        ["Montserrat-Regular.ttf",
        ].forEach { filename in

            if let url = Bundle.module.url(forResource: filename, withExtension: nil) {
                CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            }
        }
    }
    nonisolated(unsafe) private static var registered = false
}
