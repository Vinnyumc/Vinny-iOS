//
//  LocationView.swift
//  VINNY
//
//  Created by 한태빈 on 7/6/25.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject var container: DIContainer
    init(container: DIContainer){
        
    }
    @State private var selectedCategories: Set<String> = []
    let maxSelectionCount = 3
    let categories = [
        "홍대", "성수", "강남", "이태원", "동묘", "합정", "망원", "명동"
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
                    Text("마지막이에요! 관심 지역을 선택해주세요.")
                        .font(.suit(.bold, size: 20))
                        .foregroundStyle(Color("ContentBase"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    Text("최대 3개까지 선택할 수 있어요.")
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
                .padding(.top, 170)
                
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
                .padding(.top, 164)
                
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
    LocationView(container: container)
        .environmentObject(container)
}
