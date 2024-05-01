//
//  CodeStrings.swift
//  Copilot
//
//  Created by Jamal on 9/29/23.
//

import Foundation
struct CodeStrings {
    
    static let trTr = "tr-TR"
    static let enUS = "en-US"
    static let trKey = "tr"
    static let enKey = "en"
    
    static let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let patternCharacter: Character = "#"
    static let phonePattern = "#### ### ## ##"
    static let error = "Error"
    static let phoneMask = "0555 555 55 55"
    
    static let GMSServiceAPIKey = "AIzaSyD4qUo185FsJScEIoM34rO9juJPSvqZ2-E"
    //    static let googlePlacesAPIKey = "AIzaSyByiNsyzjZ0wpUUpfc5e1Yer7TcRM8j190"
    static let googlePlacesAPIKey = "AIzaSyBfH6ZJs4Efbri9v4MxhbTBX6W_RAtDsWY"
    
    static let hgsEmpty = "copilotapp.message.hgs_empty"
    static let maintenaceKey = "copilotapp.upcoming_appointment_recordtype_Maintenance"
    static let mechanicalFailurKey = "copilotapp.upcoming_appointment_recordtype_MechanicalFailure"
    static let damageKey = "copilotapp.upcoming_appointment_recordtype_Damage"
    static let tireChangeKey = "copilotapp.upcoming_appointment_recordtype_TireChange"
    
    static var vehicleGuidPdfUrl: String {
        let url = App.getString(key: CodeStrings.vehicleGuideKey)
        if let url = url, url.count > 0 {
            return url
        } else {
            return "https://drive.google.com/file/d/1tXaArVnsTV42WKIX-25Uei-B49TrwcGI/view?usp=sharing"
        }
    }
    static let vehicleGuideKey = "copilotapp.vehicle_guide_pdf_url"
    static let plateNumberPattern = "## ### ###"
    static let callSupportCenterPhone = "tel://4441433"
    static let call112 = "tel://112"
    static let bullet = "\u{2022}"
    static let turkish = "Turkish"
    static let english = "English"
}

// MAKR: Network
extension CodeStrings {
    static let didReceiveUnauthorizedError = "didReceiveUnauthorizedError"
    
    static let networkErrorCode = "-1001"
    static let networkErrorCodeTitle = "Network Error: -1001"
    static let networkErrorCodeMessage = "Your net communication interrupted please try again."
    
    static let noJSONDataErrorCode = "-102"
    static let noJSONDataErrorTitle = "No Server JSON Data: -102"
    static let noJSONDataErrorMessage = "Server is not responding any data"
    
    static let dataIsNilErrorTitle = "unknown:"
    static let dataIsNilErrorMessage = "data is nil"
    
    static let token = "Token"
    static let tokenIsNotValidErrorTitle = "Unathorized:"
    static let tokenIsNotValidErrorMessage = "Your are not Authorized"
    
    static let internalServerError = "Internal Server Error"
    
    static let responseIsNilErrorCode = "-103"
    static let responseIsNilErrorTitle = "No JSON Data: -103"
    static let responseIsNilErrorMessage = "Server is not responding any data"
    
    static let decodingResponseDataCorruptedCode = "-111"
    static let decodingResponseDataCorruptedTitle = "Decoding Response: -111"
    
    static let decodingResponseKeyNotFoundCode = "-112"
    static let decodingResponseKeyNotFoundTitle = "Decoding Response: -112"
    static let decodingResponseKeyNotFoundMessage = "Key not found"
    static let codingPath = "codingPath"
    
    static let decodingResponseValueNotFoundCode = "-113"
    static let decodingResponseValueNotFoundTitle = "Decoding Response: -113"
    static let decodingResponseValueNotFoundMessage = "Value not found"
    
    static let decodingResponseTypeMismatchCode = "-114"
    static let decodingResponseTypeMismatchTitle = "Decoding Response: -114"
    static let decodingResponseTypeMismatchMessage = "Type mismatch"
    
    static let decodingResponseUnknownResponseCode = "-115"
    static let decodingResponseUnknownResponseTitle = "Decoding Response: -115"
    
    static let decodeErrorDataCorruptedCode = "-999"
    static let decodeErrorDataCorruptedTitle = "Decoding Error: -999"
    
    static let decodeErrorKeyNotFoundCode = "-998"
    static let decodeErrorKeyNotFoundTitle = "Decoding Error: -998"
    static let decodeErrorKeyNotFoundMessage = "Key not found"
    
    static let decodeErrorValueNotFoundCode = "-997"
    static let decodeErrorValueNotFoundTitle = "Decoding Error: -997"
    static let decodeErrorValueNotFoundMessage = "Value not found"
    
    static let decodeErrorTypeMismatchCode = "-996"
    static let decodeErrorTypeMismatchTitle = "Decoding Error: -996"
    static let decodeErrorTypeMismatchMessage = "Type mismatch"
    
    static let decodeErrorUnknownResponseCode = "-995"
    static let decodeErrorUnknownResponseTitle = "Decoding Error: -995"
    
    static let unknownError = "unknown error"
    static let authorization = "Authorization"
    static let bearer = "Bearer"
    
    static let logStart = "\n*******************************************\n"
    static let logNextLine = "\n-------------------------------------------\n"
    static let logForIdentifier = "Log for request with identifier:"
    static let url = "URL"
    static let method = "Method"
    static let headers = "Headers"
    static let body = "Body"
    static let statusCode = "Status code"
    
    static let response = "Response"
}
