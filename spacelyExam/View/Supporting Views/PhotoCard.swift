//
//  PhotoCard.swift
//
//  Created by Ippei.T on 2023/01/19.
//

import SwiftUI
import PexelsSwift
import LPColorUI

struct PhotoCard: View {
	@StateObject private var model = ViewModel.shared
	
	var photo: PSPhoto
	
	@State private var showDetails: Bool = false
	@State private var downloading: Bool = false
    
    @State private var showSecondSheet: Bool = false
	
	var body: some View {
		Group {
			ZStack(alignment: .bottom) {
                image
                detailBox
			}
			.clipShape(RoundedRectangle(cornerRadius: showDetails ? 16 : 12))
            .onTapGesture {
                showSecondSheet = true
            }
            .sheet(isPresented: $showSecondSheet) {
                SearchDetailView(photo: photo)
            }
		}
		.shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 4)
		.padding(.horizontal, showDetails ? 16 : 20)
		.padding(.vertical, showDetails ? 4 : 10)
		.onChange(of: model.showNotification) { newValue in
			if newValue == true {
				model.playHaptic()
				downloading = false
			}
		}
	}
	
	var detailBox: some View {
		return HStack(alignment: showDetails ? .center : .bottom, spacing: 12) {
			HStack {
				SubtitleView(title: photo.photographer, subtitle: "Photographer")
				Spacer()

			}
			.offset(x: 0, y: showDetails ? 0 : 70)
			.opacity(showDetails ? 1 : 0)
			
			expandButton
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(showDetails ? 20 : 16)
		.background(Rectangle()
						.cornerRadius(12)
						.foregroundStyle(.thinMaterial)
						.offset(x: 0, y: showDetails ? 0 : 70)
						.opacity(showDetails ? 1 : 0)
						.shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 2)
						.padding(8)
		)
	}
	
	var expandButton: some View {
		Button {
			model.playHaptic()
			withAnimation(.spring(response: 0.3,
								  dampingFraction: 0.7,
								  blendDuration: 1)
			) {
				showDetails.toggle()
			}
		} label: {
			Image(systemName: "plus")
				.rotationEffect(showDetails ?
									.degrees(-135) : .zero)
				.font(.headline)
		}
		.frame(width: 36,height: 36)
		.background(
			Circle()
				.foregroundStyle(showDetails ?
									.regularMaterial : .ultraThickMaterial)
		)
	}
	
	var image: some View {
		AsyncImage(url: URL(string: photo.source[PSPhoto.Size.large2x.rawValue]!),
				   transaction: Transaction(animation: .easeInOut)) { phase in
			switch phase {
			case .empty:
				ZStack {
					Rectangle().foregroundColor(.init(hex: photo.averageColor))
					ProgressView()
				}.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
			case .success(let image):
				image
					.resizable()
					.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
					.transition(.scale(scale: 1.05, anchor: .center).combined(with: .opacity).animation(.easeInOut))
			case .failure(_):
				ZStack {
					Rectangle().foregroundColor(.init(hex: photo.averageColor))
					Image(systemName: "wifi.exclamationmark")
						.font(.largeTitle)
				}.aspectRatio(Double(photo.width)/Double(photo.height), contentMode: .fit)
			@unknown default: EmptyView()
			}
		}
		.frame(maxWidth: .infinity)
	}
}

