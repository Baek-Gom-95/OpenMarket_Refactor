//
//  CustomError.swift
//  OpenMarket_Refactor
//
//  Created by Baek on 2022/11/30.
//

enum CustomError: Error {
    case statusCodeError
    case unkownError
}

enum ReportError {
    static let checkHealth = "URL주소가 틀렸습니다."
}

