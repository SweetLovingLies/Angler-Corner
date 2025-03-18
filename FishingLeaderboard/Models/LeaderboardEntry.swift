//
//  LeaderboardEntry.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/25/25.
//

import Foundation

struct LeaderboardEntry: Codable {
	let name: String
	let score: Int
	
	enum CodingKeys: String, CodingKey {
		case name, score
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		score = try container.decode(Int.self, forKey: .score)
	}
}
