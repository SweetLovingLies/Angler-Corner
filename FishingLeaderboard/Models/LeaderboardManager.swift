//
//  leaderboardData.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/25/25.
//

import Foundation

struct leaderboardData: Codable {
	let leaderboard: [LeaderboardEntry]
	
	init(leaderboard: [LeaderboardEntry]) {
		self.leaderboard = leaderboard
	}
}
