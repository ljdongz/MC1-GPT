//
//  PlaceViewModel.swift
//  MC1-project
//
//  Created by 이정동 on 3/23/24.
//

import Foundation
import SwiftUI
import PhotosUI

class PlaceViewModel: ObservableObject {
    @Published var title: String
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var isAlert: Bool
    @Published var thumbnail: Image
    @Published var photosPickerItem: PhotosPickerItem? = nil {
        didSet {
            self.updateImages()
        }
    }
    
    init(
        title: String = "",
        startDate: Date = Date(),
        endDate: Date = Date(),
        isAlert: Bool = false,
        thumbnail: Image = .init(.GPT)
    ) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isAlert = isAlert
        self.thumbnail = thumbnail
    }
}

extension PlaceViewModel {
    func updateImages() {
        Task { await loadTransferable() }
    }
    
    func loadTransferable() async {
        if let data = try? await photosPickerItem?.loadTransferable(type: Data.self) {
            DispatchQueue.main.async {
                if let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)
                    self.thumbnail = image
                    self.photosPickerItem = nil
                }
            }
        }
        
    }
}
