//
//  SubtitleView.swift
//
//  Created by Ippei.T on 2023/01/19.
//

import SwiftUI

//撮影者名を表すためのView
struct SubtitleView: View {
	var title: String
	var subtitle: String
	var spacing: Double = 4
	
	var body: some View {
		VStack(alignment: .leading, spacing: spacing) {
			Text(title)
				.font(.headline)
				.foregroundColor(.primary)
			if !subtitle.isEmpty {
				Text(subtitle)
					.bold()
					.font(.caption)
					.foregroundStyle(.secondary)
			}
		}
	}
}
