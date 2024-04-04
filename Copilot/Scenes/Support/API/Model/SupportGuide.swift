//
//  SupportGuide.swift
//  Copilot
//
//  Created by Jamal on 3/20/24.
//

import Foundation

struct SupportGuide: Decodable {
    let id: Int
    let title: String
    let titleTr: String
    let titleEn: String
    let description: String
    let descriptionTr: String
    let descriptionEn: String
    let imageFile: String?
    let documentFile: String?
    let documentFileTr: String?
    let documentFileEn: String?
}
