

import Foundation
struct GaanaBase : Codable {
	let status : Int?
	let sections : [Sections]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case sections = "sections"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		sections = try values.decodeIfPresent([Sections].self, forKey: .sections)
	}

}
