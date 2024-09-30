//
//  SlideView.swift
//
//
//  Created by 한현규 on 9/5/24.
//

import SwiftUI

struct SlideView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    private let slide: Slide
    
    
    init(slide: Slide) {
        self.slide = slide
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                    
                PDFKitView(documentURL: slide.slideURL)                    
            }
            
            .navigationTitle(slide.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(slide.name)
                }
                
                ToolbarItem(placement: .navigation) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
    
        }
        .tint(.red)
        .toolbarBackground(.red, for: .navigationBar)
        .foregroundStyle(.white)
    }
    
    

}

#Preview {
    let slide = Slide(
        id: 1,
        name: "Lecture 1",
        slideURL: URL(string: "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf")!
        )
    return SlideView(slide: slide)
}
