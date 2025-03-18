//
//  LeaderboardManager 2.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/26/25.
//


//
//  leaderboardData.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/25/25.
//


// MARK: I copied most of this code from my (would be) Swift Student Challenge game for anyone wondering

import Foundation
import SwiftUI

class LeaderboardManager: ObservableObject {
	// Not sure if I need this. I think I could use EnvironmentObject in place of this?
	static let shared = LeaderboardManager()
	private let fileName = "leaderboardData.json"
	
	// Array of Entries
	@Published var leaderboard: [LeaderboardEntry] = [] {
		// If the leaderboard array gets changed, save the entries!
		didSet {
			saveEntries()
		}
	}
	
	// Load entries immediately after call
	init(){
		loadEntries()
	}
	
	// We can edit the core later!
	func updateScore(for entry: LeaderboardEntry, newScore: Int) {
		if let index = leaderboard.firstIndex(where: { $0.id == entry.id }) {
			leaderboard[index].score = newScore
			leaderboard.sort { $0.score > $1.score }
		}
	}
	
	
	func addEntry(name: String, score: Int) {
		// "Name" cannot be empty.
		guard !name.isEmpty else { return }
		let newEntry = LeaderboardEntry(name: name, score: score)
		leaderboard.append(newEntry) // Append new entry to the leaderboard
		leaderboard.sort { $0.score > $1.score }
	}
	
	
	func removeEntry(at index: Int) {
		//		print("Entry removed at index: \(index), entry: \(entry[index])")
		leaderboard.remove(at: index)
	}
	
	func saveEntries() {
		/* Used an external JSON file for saving tasks. Everything else is saved in UserDefaults. May change this later */
		let encoder = JSONEncoder()
		// iso8601 is the international dare strategy. Makes localization easier
		encoder.dateEncodingStrategy = .iso8601
		
		// try to encode leaderboard array
		if let encoded = try? encoder.encode(leaderboard) {
			// Look for the JSON file we made
			let url = getDocumentsDirectory().appendingPathComponent(fileName)
			// Then save to it
			try? encoded.write(to: url)
			//			print("Leaderboard saved successfully.")
		} else {
			print("Failed to encode tasks for saving.")
		}
	}
	
	func loadEntries() {
		// Get url for entries
		let url = getDocumentsDirectory().appendingPathComponent(fileName)
		
		// if the JSON file exists already, load data from there
		if FileManager.default.fileExists(atPath: url.path) {
			do {
				let data = try Data(contentsOf: url)
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601
				
				// turn the JSON file data into a LeaderboardEntry
				let decodedEntries = try decoder.decode([LeaderboardEntry].self, from: data)
				// then set the array equal to the decoded Leaderboard array
				leaderboard = decodedEntries
				// print("Entries loaded successfully.")
			} catch {
				print("Error loading entries: \(error.localizedDescription)")
			}
		} else {
			print("File does not exist at path: \(url.path)")
		}
	}
	
	// Get the documents directory for saving/loading
	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	// Helpers
	func backgroundColor(for entry: LeaderboardEntry) -> LinearGradient {
		let index = LeaderboardManager.shared.leaderboard.firstIndex { $0.id == entry.id }
		
		switch index {
		case 0: return LinearGradient(gradient: Gradient(colors: [.gold3, .gold4, .gold1, .gold3]), startPoint: .top, endPoint: .bottom)
		case 1: return LinearGradient(gradient: Gradient(colors: [.silver2, .silver1, .white, .silver2]), startPoint: .bottom, endPoint: .top)
		case 2: return LinearGradient(gradient: Gradient(colors: [.bronze3, .bronze2, .bronze1, .bronze2, .bronze3]), startPoint: .top, endPoint: .bottom)
		default: return LinearGradient(gradient: Gradient(colors: [.white]), startPoint: .top, endPoint: .bottom)
		}
	}
	
	// Icons for you!
	func icon(for entry: LeaderboardEntry) -> String {
		let index = LeaderboardManager.shared.leaderboard.firstIndex { $0.id == entry.id }
		
		switch index {
		case 0: return "crown.fill"
		case 1: return "medal.fill"
		case 2: return "star.fill"
		default: return "fish.fill"
		}
	}
}
