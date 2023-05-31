//
//  NetworkInterceptor.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation

public struct NetworkInterceptor {

    var intercept: (URLRequest) -> URLRequest

}
