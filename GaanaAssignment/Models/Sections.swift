

import Foundation
struct Sections : Codable {
	let name : String?
	let tracks : [Tracks]?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case tracks = "tracks"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		tracks = try values.decodeIfPresent([Tracks].self, forKey: .tracks)
	}

}
