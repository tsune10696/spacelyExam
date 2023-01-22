//
//  RouterView.swift
//
//  Created by Ippei.T on 2023/01/19.
//

import SwiftUI

struct RouterView: View {
	
	@State private var selectedView: Environment.TabViewTag = .curated
	
	var body: some View {
		TabView(selection: $selectedView) {
			SearchView()
				.tabItem {
					Label("Search", systemImage: "magnifyingglass")
						.environment(\.symbolVariants, selectedView == .search ? .fill : .none)
				}
				.tag(Environment.TabViewTag.search)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		RouterView()
			.previewDevice("iPhone 12")
		
	}
}
