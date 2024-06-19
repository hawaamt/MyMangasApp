//
//  Image+clipCenter.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 7/6/24.
//

import SwiftUI

extension Image {
    func clipCenter(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height, alignment: .center)
            .clipped()
    }
    
    func clipCenter(width: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, alignment: .center)
            .clipped()
    }
    
    func clipCenter(height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(height: height, alignment: .center)
            .clipped()
    }
}
