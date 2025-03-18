//
//  LeaderboardView.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/25/25.
//

import Foundation
import SwiftUI

struct LeaderboardView: View {
	@StateObject private var leaderboardManager = LeaderboardManager.shared
	@State private var newEntryName: String = ""
	@State private var newEntryScore: String = ""
	
	var body: some View {
		NavigationStack {
			ZStack {
				// Discovered you could just use a color here
				// Pretty sure this only works if you have something that takes up the full width
				// The Rectangle() method will fill a stack out, which is very helpful sometimes
				Color.darkBlue
					.ignoresSafeArea()
				
				VStack {
					// Leaderboard
					List {
						ForEach(Array(leaderboardManager.leaderboard.enumerated()), id: \.element.id) { index, entry in
							ZStack {
								LeaderboardEntryView(entry: entry, rank: index + 1)
							}
							.listRowBackground(leaderboardManager.backgroundColor(for: entry))
						}
						.onDelete { indexSet in
							leaderboardManager.leaderboard.remove(atOffsets: indexSet)
							leaderboardManager.leaderboard.sort { $0.id < $1.id }
						}
					}
					.scrollContentBackground(.hidden)
					
					HStack {
						TextField("Name", text: $newEntryName)
							.textFieldStyle(RoundedBorderTextFieldStyle())
						TextField("Score", text: $newEntryScore)
							.keyboardType(.numberPad)
							.textFieldStyle(RoundedBorderTextFieldStyle())
						
						Button("Add") {
							if let score = Int(newEntryScore) {
								leaderboardManager.addEntry(name: newEntryName, score: score)
								newEntryName = ""
								newEntryScore = ""
							}
						}
						.buttonStyle(.borderedProminent)
						.bold()
					}
					.padding()
				}
				.toolbar {
					ToolbarItem(placement: .topBarTrailing) {
						EditButton()
							.buttonStyle(.borderedProminent)
							.foregroundStyle(.white)
							.bold()
					}
				}
				
				
				.navigationTitle(Text("Fishing Leaderboard"))
				
				.onAppear {
					UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
					UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
					UINavigationBar.appearance().barTintColor = UIColor.lightPurple
					
				}
				
			}
		}
	}
}

#Preview {
	LeaderboardView()
}
