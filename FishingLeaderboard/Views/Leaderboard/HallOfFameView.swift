//
//  HallOfFameView.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/28/25.
//

import SwiftUI

struct HallOfFameView: View {
	@StateObject private var leaderboardManager = LeaderboardManager.shared

		var body: some View {
			ZStack {
				Color.darkBlue
					.ignoresSafeArea()
				VStack {
					Text("🏆 Hall of Fame 🏆")
						.font(.largeTitle)
						.bold()
					
					List {
						ForEach(Array(leaderboardManager.hallOfFame.enumerated()), id: \.element.id) { index, entry in
							ZStack {
								LeaderboardEntryView(entry: entry, rank: index + 1)
							}
							.listRowBackground(leaderboardManager.hallOfFameBGColor(for: entry))
						}
					}
					.scrollContentBackground(.hidden)
				}
				.foregroundStyle(.white)
				.onAppear {
					leaderboardManager.loadHallOfFame()
				}
			}
		}
}


#Preview {
	HallOfFameView()
}
