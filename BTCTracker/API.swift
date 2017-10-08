//
//  API.swift
//  BTCTracker
//
//  Created by Finn Gaida on 08.10.17.
//  Copyright © 2017 Finn Gaida. All rights reserved.
//

import UIKit
import Alamofire

enum Endpoint {
    case btc
}

class API: NSObject {

    static let shared = API()
    let baseURL = "https://min-api.cryptocompare.com/data/pricehistorical?tsyms=EUR"

    func url(for endpoint: Endpoint) -> String {
        switch endpoint {
        case .btc: return baseURL + "&fsym=BTC"
        }
    }

    func getData(timestamp: String, response: @escaping (Double?) -> ()) {
        Alamofire.request(url(for: .btc)).responseJSON { res in
            guard let wrapper = res.value as? [String: [String: Double]],
                  let dict = wrapper["BTC"], let val = dict["EUR"] else { print("ouch"); return response(nil) }
            print(val)
            response(Double(val))
        }
    }

}
