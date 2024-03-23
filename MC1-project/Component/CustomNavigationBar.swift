//
//  CustomNavigationbar.swift
//  MC1-project
//
//  Created by 이정동 on 3/21/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let isDisplayBackButton: Bool
    let rightButtonAction: (() -> ())?
    let rightButtonType: NavigationBarButtonType
    let title: String
    
    init(
        isDisplayBackButton: Bool = true,
        rightButtonAction: (()->())? = nil,
        rightButtonType: NavigationBarButtonType = .edit,
        title: String = ""
    ) {
        self.isDisplayBackButton = isDisplayBackButton
        self.rightButtonAction = rightButtonAction
        self.rightButtonType = rightButtonType
        self.title = title
    }
    
    
    var body: some View {
        ZStack {
            
            Text(title)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.wh)
            
            HStack {
                if isDisplayBackButton {
                    Button(
                        action: { dismiss() },
                        label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(Color.wh)
                    })
                    .frame(height: 25)
                } else {
                    Spacer()
                        .frame(height: 25)
                }
                
                Spacer()
                
                
                if let action = rightButtonAction {
                    Button(
                        action: {
                            action()
                        },
                        label: {
                            Text(rightButtonType.rawValue)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(Color.wh)
                    })
                }
            }
        }
        .frame(height: 50)
        .padding(.horizontal)
        .background(Color.bg.opacity(isDisplayBackButton ? 0.98 : 1))
        
        
    }
}

#Preview {
    CustomNavigationBar(isDisplayBackButton: true, rightButtonAction: {
        
    }, rightButtonType: .create, title: "경주")
}
