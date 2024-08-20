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
    let id: Int?
    let type: String?
    let titleEn: String?
    let titleTr: String?
    let title: String?
    let contentEn: String?
    let contentTr: String?
    let imageUrlEn: String?
    let imageUrlTr: String?
    let expiresAt: String?
    let created: String?
    let imageFile: String?
    
    var content: String {
        let language = App.language
        if language == CodeStrings.turkish {
            return contentTr ?? ""
        }
        return contentEn ?? ""
    }
    
    var campaignType: CampaignType {
        let str = type ?? ""
        return CampaignType(rawValue: str) ?? .campaign
    }
    
    var displayExpireDate: String {
        let date = expiresAt ?? ""
        return date.displayDate()
    }
}
