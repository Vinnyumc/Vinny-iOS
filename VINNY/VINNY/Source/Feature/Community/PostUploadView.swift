//
//  PostUploadView.swift
//  VINNY
//
//  Created by 홍지우 on 7/20/25.
//

import SwiftUI

struct PostUploadView: View {
    @StateObject var viewModel = PostUploadViewModel()
    @State private var selectedImageCount: Int = 0
    
    private var postImages: [String] = ["emptyBigImage"]
    @State private var currentIndex: Int = 0
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    private var styles: [String] = [
        "🪖 밀리터리", "🇺🇸 아메카지", "🛹 스트릿", "🏔️ 아웃도어", "👕 캐주얼", "👖 데님", "💼 하이엔드", "🛠️ 워크웨어", "👞 레더", "‍🏃‍♂️ 스포티", "🐴 웨스턴", "👚 Y2K"
    ]
    @State private var selectedStyles: Set<String> = []
    
    private var brandTags: [String] = ["발렌시아가", "마르지엘라", "폴로"]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 상단 고정 바
            ZStack {
                HStack {
                    Button (action: {
                        print("뒤로 가기")
                    }) {
                        Image("arrowBack")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    Spacer()
                }
                Text("게시글 업로드")
                    .font(.suit(.regular, size: 18))
                    .foregroundStyle(Color.contentBase)
            }
            .padding(16)
            
            Divider()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    // MARK: - 페이지뷰
                    VStack(spacing: 12) {
                        TabView(selection: $currentIndex) {
                            ForEach(0..<postImages.count, id: \.self) { index in
                                Image(postImages[index])
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 4)
                            }
                        }
                        .aspectRatio(1, contentMode: .fill)
                        .padding(.vertical, 4)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        
                        /// PostCard와 동일
                        HStack(spacing: 4) {
                            ForEach(0..<postImages.count, id: \.self) { index in
                                Circle()
                                    .fill(index == currentIndex ? Color.gray : Color.gray.opacity(0.3))
                                    .frame(width: 4, height: 4)
                            }
                        }
                        .animation(.easeInOut, value: currentIndex)
                        .padding(.top, 8)
                    }
                    
                    // MARK: - 이미지 선택
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 12) {
                            Text("이미지 선택")
                                .font(.suit(.bold, size: 18))
                                .foregroundStyle(Color.contentBase)
                            
                            Spacer()
                            
                            Text("\(selectedImageCount)개/5개")
                                .font(.suit(.light, size: 14))
                                .foregroundStyle(Color.contentAssistive)
                        }
                        
                        Image("emptyBigImage")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    
                    // MARK: - 내용 입력
                    Rectangle()
                        .frame(width: .infinity, height: 4)
                        .foregroundStyle(Color.borderDividerRegular)
                        .padding(.vertical, 10)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("내용 입력")
                            .font(.suit(.bold, size: 18))
                            .foregroundStyle(Color.contentBase)
                            .padding(.top, 10)
                            .padding(.bottom, 6)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("제목")
                                .font(.suit(.medium, size: 14))
                                .foregroundStyle(Color.contentAdditive)
                            
                            TextEditor(text: $viewModel.title)
                                .customStyleEditor(placeholder: "제목은 최대 15자까지 가능해요", userInput: $viewModel.title, maxLength: 15)
                                .frame(height: 48)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("내용")
                                .font(.suit(.medium, size: 14))
                                .foregroundStyle(Color.contentAdditive)
                                .padding(.top, 10)
                                .padding(.bottom, 6)
                            
                            TextEditor(text: $viewModel.content)
                                .customStyleEditor(placeholder: "나만의 멋진 내용을 적어주세요!", userInput: $viewModel.content, maxLength: nil)
                                .frame(height: 156)
                        }
                        .padding(.vertical, 8)
                    }
                    .padding(.horizontal, 16)
                    
                    Rectangle()
                        .frame(width: .infinity, height: 4)
                        .foregroundStyle(Color.borderDividerRegular)
                        .padding(.vertical, 10)
                    
                    // MARK: - 스타일 선택
                    VStack(alignment: .leading, spacing: 0) {
                        Text("스타일 선택")
                            .font(.suit(.bold, size: 18))
                            .foregroundStyle(Color.contentBase)
                            .padding(.top, 10)
                            .padding(.bottom, 6)
                        
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                            ForEach(styles, id: \.self) { style in
                                Button(action: {
                                    print("\(style)")
                                }) {
                                    SelectingTagComponent(
                                        tag: style,
                                        selectedTag: selectedStyles.contains(style),
                                        onTap: {
                                            if selectedStyles.contains(style) {
                                                selectedStyles.remove(style)
                                            } else {
                                                selectedStyles.insert(style)
                                            }
                                        }
                                    )
                                }
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: - 브랜드 입력
                    VStack(alignment: .leading, spacing: 0) {
                        Text("브랜드 입력")
                            .font(.suit(.bold, size: 18))
                            .foregroundStyle(Color.contentBase)
                            .padding(.top, 10)
                            .padding(.bottom, 6)
                        
                        TextEditor(text: $viewModel.brand)
                            .customStyleEditor(placeholder: "태그할 브랜드를 입력해주세요", userInput: $viewModel.brand, maxLength: nil)
                            .frame(height: 48)
                            .padding(.vertical, 8)
                        
                        HStack(spacing: 8) {
                            ForEach(brandTags, id: \.self) { style in
                                TagComponent(tag: style)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .padding(.horizontal, 16)
                    
                    // MARK: - 빈티지샵 태그
                    VStack(alignment: .leading, spacing: 0) {
                        Text("빈티지샵 태그")
                            .font(.suit(.bold, size: 18))
                            .foregroundStyle(Color.contentBase)
                            .padding(.top, 10)
                            .padding(.bottom, 6)
                        
                        TextEditor(text: $viewModel.shoptag)
                            .customStyleEditor(placeholder: "태그할 샵 이름을 입력해주세요", userInput: $viewModel.shoptag, maxLength: nil)
                            .frame(height: 48)
                            .padding(.vertical, 8)
                    }
                    .padding(.horizontal, 16)
                }
            }
            
            // MARK: - 하단 고정 버튼(업로드)
            Button(action: {
                print("업로드")
            }) {
                Text("업로드")
                    .font(.suit(.medium, size: 16))
                    .foregroundStyle(Color.contentInverted)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color.backFillInverted)
                    )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color.backFillRegular)
            )
        }
        .background(Color.backFillStatic)
    }
}

#Preview {
    PostUploadView()
}
