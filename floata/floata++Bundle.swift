//
//  floata++Bundle.swift
//  floata
//
//  Created by 홍태희 on 2021/11/22.
//

import Foundation

extension Bundle {
    var apiKey : String {
        guard let file = self.path(forResource: "Weather", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["OPENWEATHERMAP_KEY"] as? String else { fatalError("Weather.plist에 API_KEY 설정을 해주세요.") }
        return key
    }
}
