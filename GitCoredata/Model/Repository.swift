//
//  Repository.swift
//  GitCoredata
//
//  Created by user263604 on 6/29/24
//
import Foundation

struct Repository: Identifiable, Codable {
    let id: Int
    let name: String
    let owner: Owner
    let description: String?
    let html_url: String
    let contributors_url: String?

    struct Owner: Codable {
        let avatar_url: String
        let login: String
    }
}
