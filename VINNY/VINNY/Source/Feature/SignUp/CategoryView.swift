//
//  CategoryView.swift
//  VINNY
//
//  Created by 한태빈 on 7/6/25.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var container: DIContainer
    init(container: DIContainer){
        
    }
    @State private var selectedCategories: Set<String> = []
    let maxSelectionCount = 3
    let categories = [
        "🪖 밀리터리", "🇺🇸 아메카지", "🛹 스트릿", "🏔️ 아웃도어", "👕 캐주얼", "👖 데님", "💼 하이엔드", "🛠️ 워크웨어", "👞 레더", "🏃‍♂️ 스포티", "🐴 웨스턴", "기타"
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    

    var body: some View {
        ZStack{
            Color.backRootRegular
                .ignoresSafeArea()
            
            //맨 위 텍스트 두 줄
            VStack{
                VStack(spacing: 2){
                    Text("좋아하는 빈티지 취향을 3개까지 골라주세요!")
                        .font(.suit(.bold, size: 20))
                        .foregroundStyle(Color("ContentBase"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    Text("빈티지샵, 피드 추천 등 다양하게 맞춤형으로 활용됩니다.")
                        .font(.suit(.medium, size: 16))
                        .foregroundStyle(Color("ContentAdditive"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                }
                
                // 2*4 버튼들
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(categories, id: \.self) {categories in
                        let isSelected = selectedCategories.contains(categories)
                        Text(categories)
                            .font(.suit(.regular, size: 16))
                            .foregroundStyle(isSelected ? Color("ContentAdditive") : Color("ContentDisabled"))
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                    .stroke(isSelected ? Color("BorderOutlineStrong") : Color("BackFillRegular"), lineWidth: 2)
                                                   )
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("BackFillRegular"))
                            )
                            .onTapGesture {
                                toggleSelection(for: categories)
                            }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 118)
                
                // 다음으로 버튼
                Button(action:{
                    
                }){
                    Text("다음으로")
                        .font(.suit(.medium, size: 16))
                        .foregroundStyle(selectedCategories.isEmpty ? Color("ContentBase") : Color("ContentInverted"))
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(selectedCategories.isEmpty ? Color("BackFillRegular") : Color("BackFillInverted"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(selectedCategories.isEmpty)
                .padding(.horizontal, 20)
                .padding(.top, 112)
                
                // 선택에 대한 정보 문구
                Text("최소 한 개를 선택해야 다음으로 넘어갈 수 있어요")
                    .font(.suit(.regular, size: 12))
                    .foregroundStyle(Color("ContentAssistive"))
                    .padding(.top, 8)
                        }
            }
        }
    private func toggleSelection(for category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            if selectedCategories.count < maxSelectionCount {
                selectedCategories.insert(category)
            }
        }
    }
}

#Preview {
    let container = DIContainer()
    CategoryView(container: container)
        .environmentObject(container)
}
