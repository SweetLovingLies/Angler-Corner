//
//  LeaderboardEntryView 2.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/26/25.
//


//
//  EntryView.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/25/25.
//

import SwiftUI

struct QueueEntryView: View {
	@StateObject var queueManager = QueueManager.shared
	var entry: QueueEntry
		
	init(entry: QueueEntry) {
		self.entry = entry
	}
	
	var body: some View {
		ZStack {
			HStack {
				Text("\(entry.position).")
					.font(.headline)
					.bold()
				Text(entry.name)
					.font(.headline)
					.frame(maxWidth: .infinity, alignment: .leading)
					.foregroundStyle(.black)
			}
			.padding()
			.cornerRadius(8)
		}
		.frame(height: 60)
	}
}

#Preview {
	QueueEntryView(entry: QueueEntry(name: "Test User", position: 0))
}
