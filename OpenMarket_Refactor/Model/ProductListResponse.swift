//
//  ProductListResponse.swift
//  OpenMarket_Refactor
//
//  Created by Baek on 2022/11/30.
//

struct ProductListResponse: Decodable {
    let pageNo: Int
    let itemsPerPage: Int
    let totalCount: Int
    let offset: Int
    let limit: Int
    let lastPage: Int
    let hasNext: Bool
    let hasPrev: Bool
    let pages: [Product]
}
