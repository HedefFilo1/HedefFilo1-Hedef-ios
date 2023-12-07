//
//  Campaign.swift
//  Copilot
//
//  Created by Jamal on 12/7/23.
//

import Foundation

enum CampaignType: String {
    case campaign = "CAMPAIGN"
    case sponsership = "SPONSORSHIP"
    case news = "NEWS"
}

struct Campaign: Decodable {
    let id: Int
    let type: String
    let titleEn: String
    let titleTr: String
    let contentEn: String
    let contentTr: String
    let imageUrlEn: String
    let imageUrlTr: String
    let expiresAt: String
    let created: String
    
    var campaignType: CampaignType {
        return CampaignType(rawValue: type) ?? .campaign
    }
    
    var displayExpireDate: String {
        return expiresAt.displayDate()
    }
}
