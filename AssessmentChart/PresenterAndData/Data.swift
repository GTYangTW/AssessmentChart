//
//  Data.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/7.
//

import Foundation


import Foundation

// MARK: - TPEnginge
struct TPPData: Codable {
    let code, status, message: String
    let data: DataClass
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case status = "status"
        case message = "message"
        case data = "data"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let total: Int
    let page: [Page]
}

// MARK: - Page
struct Page: Codable {
    let eirID, eirName, eirAgent: String
    let projID: Int
    let planName, projName, projNumber, eirTotal: String
    let projYearRange, projTotal, projHostUnit, projUnit: String
    let projunitAliasname: ProjunitAliasname
    let projDepname: ProjDepname
    let projUndertaker: String
    let projUndertakerArray, projUndertakerCname: [String]
    let cname: JSONNull?
    let projPlace, company, amount: String
    let projStatus: ProjStatus
    let projType, projProperty, projPropertyType, projAgent: String
    let cDate, uDate: String

    enum CodingKeys: String, CodingKey, CaseIterable {
        case eirID = "eir_id"
        case eirName = "eir_name"
        case eirAgent = "eir_agent"
        case projID = "proj_id"
        case planName = "plan_name"
        case projName = "proj_name"
        case projNumber = "proj_number"
        case eirTotal = "eir_total"
        case projYearRange = "proj_year_range"
        case projTotal = "proj_total"
        case projHostUnit = "proj_host_unit"
        case projUnit = "proj_unit"
        case projunitAliasname = "projunit_aliasname"
        case projDepname = "proj_depname"
        case projUndertaker = "proj_undertaker"
        case projUndertakerArray = "proj_undertaker_array"
        case projUndertakerCname = "proj_undertaker_cname"
        case cname
        case projPlace = "proj_place"
        case projStatus = "proj_status"
        case company, amount
        case projType = "proj_type"
        case projProperty = "proj_property"
        case projPropertyType = "proj_property_type"
        case projAgent = "proj_agent"
        case cDate, uDate
    }
    enum ProjStatus: String, Codable, CaseIterable {
        case uncontractedPj = "0"
        case contractingPj = "10"
        case completionPj = "110"
        case warrantyPj = "130"
        case finishPj = "140"

        var completeName: String {
            switch self {
            case .uncontractedPj:
                return "工程狀態(為發包工程:尚未簽約的工程)(A5.6簽定訂約尚未完成)"
            case .contractingPj:
                return "工程狀態(在建工程:申報竣工前的工程)(B3.4工程竣工未核定)"
            case .completionPj:
                return "工程狀態(完工驗收中工程:竣工驗收階段(含決算前))(B3.12缮製工程決算書核定前)"
            case .warrantyPj:
                return "工程狀態(保固中工程:決算後)(B3.12缮製工程決算書核定後)"
            case .finishPj:
                return "工程狀態(結案(保固期滿):C發還保固(活)保證金)"
            }
        }
    }
}

enum ProjDepname: String, Codable {
    case 工務科北區工務所 = "工務科-北區工務所"
    case 工務科南港工務所 = "工務科-南港工務所"
    case 工務科發包股 = "工務科-發包股"
    case 工務科西區工務所 = "工務科-西區工務所"
    case 新建工程處處本部 = "新建工程處-處本部"
    case 新建工程處資訊室 = "新建工程處-資訊室"
    case 規劃設計科科本部 = "規劃設計科-科本部"
    case 規劃設計科預算股 = "規劃設計科-預算股"
}


enum ProjunitAliasname: String, Codable {
    case 新工處 = "新工處"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
