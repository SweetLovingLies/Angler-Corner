//
//  ProgressBar.swift
//  CustomProgressBarTest
//
//  Created by Kevin Buchholz on 2/17/25.
//

import SwiftUI

struct ProgressBar: View {
	var progress: CGFloat = 0.6
	var width: CGFloat = 300
	var height: CGFloat = 20
	var CRadius: CGFloat = 50
	
	var body: some View {
		ZStack(alignment: .leading) {
			RoundedRectangle(cornerRadius: CRadius)
				.frame(width: width + 2, height: height + 2)
				.foregroundStyle(.black)
			ZStack{
				RoundedRectangle(cornerRadius: CRadius)
					.fill(LinearGradient(gradient: Gradient(colors: [.yellow, .gray, .white, .yellow]), startPoint: .bottom, endPoint: .top))
					.frame(width: progress * width, height: height)
					.offset(x: 1)
				RoundedRectangle(cornerRadius: CRadius)
					.fill(.yellow)
					.frame(width: progress * width, height: height)
					.offset(x: 1)
					.opacity(0.2)
			}
		}
	}
}

#Preview {
    ProgressBar()
}
