//
//  CommunityView.swift
//  VINNY
//
//  Created by 한태빈 on 7/4/25.
//

import SwiftUI


struct CommunityView: View {
    @EnvironmentObject var container: DIContainer
    
    init(container: DIContainer) {
        
    }
    
    // MARK: - Networking
    @MainActor
    private func fetchPosts(reset: Bool) async {
        if reset { page = 0 }
        if isLoading { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            let result: PostListResultDTO = try await PostAPITarget.getPosts(page: page, size: size)
            let newPosts = result.posts

            if reset {
                posts = newPosts
            } else {
                // Append while de-duplicating by postId
                var seen = Set(posts.map { $0.postId })
                let filtered = newPosts.filter { seen.insert($0.postId).inserted }
                posts += filtered
            }

            // Update paging info from server response
            let info = result.pageInfo
            // Prepare next page index and whether there is a next page
            hasNext = (info.page + 1) < info.totalPages
            page = info.page + 1
            // NOTE: If your backend sometimes returns totalPages=0 for empty, keep hasNext false implicitly.
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    private func loadMoreIfNeeded(current item: PostItemDTO) async {
        guard hasNext, !isLoading else { return }
        if let last = posts.last, last.postId == item.postId {
            await fetchPosts(reset: false)
        }
    }
    
    @State private var posts: [PostItemDTO] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var page: Int = 0
    @State private var size: Int = 10
    @State private var hasNext: Bool = true
    
    var body: some View {
        
        VStack(spacing: 0) {
            /// 상단 고정
            VStack(spacing: 0) {
                HStack(spacing: 16) {
                    Text("커뮤니티")
                        .font(.suit(.bold, size: 24))
                        .foregroundStyle(Color.contentBase)
                    
                    Spacer()
                    
                    Button(action: {
                        container.navigationRouter.push(to: .PostUploadView)
                    }) {
                        Image("plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                Button(action: {
                    container.navigationRouter.push(to: .SearchView)
                }) {
                    HStack(spacing: 8) {
                        Image("magnifier")
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        Text("빈티지샵, 게시글 검색하기")
                            .font(.suit(.regular, size: 16))
                            .foregroundStyle(Color.contentAssistive)
                        
                        Spacer()
                        
                        Image("close")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(Color.backFillRegular)
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
                
            /// 스크롤뷰
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    if isLoading {
                        ProgressView()
                            .frame(maxHeight: .infinity)
                    } else if let err = errorMessage {
                        Text(err)
                            .foregroundStyle(.red)
                            .frame(maxHeight: .infinity)
                    } else {
                        ForEach(posts, id: \.self) { item in
                            PostCardView(item: item)
                                .environmentObject(container)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                                .onAppear {
                                    Task { await loadMoreIfNeeded(current: item) }
                                }
                        }
                        
                        if isLoading && !posts.isEmpty {
                            ProgressView()
                                .padding(.vertical, 16)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 56)
                }
                .scrollTargetLayout()
                Spacer().frame(height: 70)
            }
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        }
        .background(Color.backFillStatic)
        .navigationBarBackButtonHidden()
        .task { await fetchPosts(reset: true) }
        .refreshable { await fetchPosts(reset: true) }
    }
}

#Preview {
    let container = DIContainer()
    CommunityView(container: container)
        .environmentObject(container)
}
