//
//  Article.swift
//  NewsApp
//
//  Created by admios on 8/19/20.
//  Copyright © 2020 rene. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
