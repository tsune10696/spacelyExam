//
//  String+Encoding.swift
//
//  Created by Ippei.T on 2023/01/19.
//

import Foundation

extension String {
	
	var percentEncoded: String {
		self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
	}
	
}
