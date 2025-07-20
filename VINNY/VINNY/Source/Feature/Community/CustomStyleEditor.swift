//
//  CustomStyleEditor.swift
//  VINNY
//
//  Created by 홍지우 on 7/20/25.
//

import SwiftUI

struct CustomTextEditorStyle: ViewModifier {
    let placeholder: String
    @Binding var text: String // 글자 수 받기 위해 @Binding 사용
    let showCount: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(6)
            .background(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .lineSpacing(8)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .font(.suit(.light, size: 16))
                        .foregroundStyle(Color.contentAssistive)
                }
            }
            .autocorrectionDisabled()
            .background(Color.backFillRegular)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scrollContentBackground(.hidden)
            .font(.suit(.light, size: 16))
            .foregroundStyle(Color.contentAdditive)
            .modifier(ConditionalOverlay(show: showCount, text: $text))
    }
}

struct ConditionalOverlay: ViewModifier {
    let show: Bool
    @Binding var text: String
    
    func body(content: Content) -> some View {
        if show {
            content.overlay(alignment: .topTrailing) {
                Button(action: {
                    print("닫기")
                }) {
                    Image("close")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top, 12)
                        .padding(.trailing, 16)
                }
                .onChange(of: text) {
                    if text.count > 15 {
                        text = String(text.prefix(15))
                    }
                }
//                Text("\(text.count) / 500")
//                    .font(.suit(.light, size: 16))
//                    .foregroundStyle(Color.contentAssistive)
//                    .padding(.trailing, 15)
//                    .padding(.bottom, 15)
//                    .onChange(of: text) {
//                        if text.count > 500 {
//                            text = String(text.prefix(500))
//                        }
//                    }
            }
        } else {
            content
        }
    }
}

extension TextEditor {
    func customStyleEditor(
        placeholder: String,
        userInput: Binding<String>,
        showCount: Bool = true
    ) -> some View {
        self.modifier(CustomTextEditorStyle(
            placeholder: placeholder,
            text: userInput,
            showCount: showCount
        ))
    }
}
