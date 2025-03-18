//
//  QueueView.swift
//  FishingLeaderboard
//
//  Created by Morgan Harris on 2/25/25.
//

import Foundation
import SwiftUI

struct QueueView: View {
	@StateObject private var queueManager = QueueManager.shared
	@State private var newEntryName: String = ""
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color.darkBlue
					.ignoresSafeArea()
				
				VStack {
					// The Queue
					List {
						ForEach(queueManager.queue, id: \.id) { entry in
							ZStack {
								QueueEntryView(entry: entry)
							}
							.listRowBackground(queueManager.backgroundColor(for: entry))
						}
						.onMove { fromOffsets, toOffset in
							queueManager.queue.move(fromOffsets: fromOffsets, toOffset: toOffset)

							for (index, _) in queueManager.queue.enumerated() {
								queueManager.queue[index].position = index
							}
						}

						.onDelete { indexSet in
							queueManager.queue.remove(atOffsets: indexSet)
						}
					}
					.scrollContentBackground(.hidden)
					
					HStack {
						TextField("Name", text: $newEntryName)
							.textFieldStyle(RoundedBorderTextFieldStyle())
						
						Button("Add") {
							queueManager.addEntry(name: newEntryName)
								newEntryName = ""
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
				
				
				.navigationTitle(Text("Game Queue"))
				
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
	QueueView()
}
