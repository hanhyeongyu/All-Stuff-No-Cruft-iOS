//
//  PDFKitView.swift
//
//
//  Created by 한현규 on 9/2/24.
//

import SwiftUI
import PDFKit



struct PDFKitView: UIViewRepresentable {
    
    let documentURL: URL
    
    init(documentURL: URL) {
        self.documentURL = documentURL
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document = PDFDocument(url: documentURL)        
        //pdfView.minScaleFactor = 0.5
        //pdfView.maxScaleFactor = 5.0    
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        
    }
}

