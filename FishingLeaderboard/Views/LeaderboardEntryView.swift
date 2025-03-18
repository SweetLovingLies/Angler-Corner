//
//  EntryView.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/25/25.
//

import SwiftUI

struct EntryView: View {
	@StateObject var leaderboardManager = LeaderboardManager.shared
	var entry: LeaderboardEntry
	var rank: Int
	
	// This should always start false... make sure to update this when needed!
	@State private var isEditing = false
	@State private var editedScore: String
	
	init(entry: LeaderboardEntry, rank: Int) {
		self.entry = entry
		self.rank = rank
		_editedScore = State(initialValue: "\(entry.score)")
	}
	
	var body: some View {
		ZStack {
			HStack {
				Image(systemName: leaderboardManager.icon(for: entry))
					.foregroundStyle(.black)
				
				Text("\(rank).")
					.font(.headline)
					.foregroundStyle(.black)
				
				Text(entry.name)
					.font(.headline)
					.frame(maxWidth: .infinity, alignment: .leading)
					.foregroundStyle(.black)
				
				if isEditing {
					TextField("Score", text: $editedScore)
						.keyboardType(.numberPad)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.frame(maxWidth: 70)
					
					Button(action: {
						if let newScore = Int(editedScore) {
							leaderboardManager.updateScore(for: entry, newScore: newScore)
							isEditing = false
						}
					}) {
						Image(systemName: "checkmark.circle.fill")
							.font(.system(size: 20))
							.foregroundStyle(.black)
					}
					.buttonStyle(.borderless)
				} else {
					Text("\(entry.score) pts")
						.font(.subheadline)
						.bold()
						.foregroundStyle(.black)
						.onTapGesture {
							isEditing = true
						}
				}
			}
			.padding()
			.cornerRadius(8)
		}
		.frame(height: 60)
	}
}

#Preview {
	EntryView(entry: LeaderboardEntry(name: "Test User", score: 100), rank: 1)
}
