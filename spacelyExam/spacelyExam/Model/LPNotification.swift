//
//  LPNotification.swift
//
//  Created by Ippei.T on 2023/01/19.
//

import Foundation

struct LPNotification: Identifiable {
	var id: UUID = UUID()
	var title: String
	var message: String
}
