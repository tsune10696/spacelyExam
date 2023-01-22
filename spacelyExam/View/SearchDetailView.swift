//
//  SearchDetailView.swift
//
//  Created by Ippei.T on 2023/01/19.
//

import SwiftUI
import PexelsSwift
import LPColorUI

struct SearchDetailView: View {
    
    @StateObject private var model = ViewModel.shared
    var photo: PSPhoto
    
    var body: some View {

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
