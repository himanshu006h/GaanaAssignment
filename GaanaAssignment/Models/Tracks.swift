

import Foundation
struct Tracks : Codable {
	let name : String?
	let itemID : String?
	let atw : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case itemID = "itemID"
		case atw = "atw"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		itemID = try values.decodeIfPresent(String.self, forKey: .itemID)
		atw = try values.decodeIfPresent(String.self, forKey: .atw)
	}

}
