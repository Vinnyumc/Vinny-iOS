import SwiftUI
import Foundation

// 커뮤니티 결과 셀: 게시글 이미지 그리드
struct CommunityResultCell: View {
    @EnvironmentObject var container: DIContainer
    let posts: [PostSearchResultDTO]             // ← API 결과 주입
    let onSelectPost: ((Int) -> Void)? = nil     // ← 탭 시 외부에서 핸들링 가능하도록
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 1), count: 3)
    
    var body: some View {
        // 부모(SearchResultView)에 ScrollView가 있으므로 여기선 LazyVGrid만
        LazyVGrid(columns: columns, spacing: 1) {
            ForEach(posts, id: \.id) { post in
                Button {
                    handleTap(post.id)
                } label: {
                    // 대표 이미지: 첫 번째 URL만 사용, 없으면 빈 문자열로 placeholder 표시
                    PostImageTile(urlString: post.imageUrls?.first ?? "")
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 1)
    }
    // MARK: - Tap Handling
    private func handleTap(_ postId: Int) {
        if let onSelectPost { onSelectPost(postId); return }
        
        Task {
#if DEBUG
            print("[CommunityResultCell] tapped post: \(postId)")
#endif
            _ = try? await PostAPITarget.fetchPostDetail(postId: postId) // 이건 그대로 OK
            await MainActor.run {
                container.navigationRouter.push(to: .PostView(id: postId)) // ← 레이블 id 로!
            }
        }
    }
}
// 작은 타일로 분리해서 타입체크 부담↓
private struct PostImageTile: View {
    let urlString: String

    var body: some View {
        GeometryReader { proxy in
            let side = proxy.size.width

            ZStack {
                // Placeholder background
                Rectangle()
                    .fill(Color.gray.opacity(0.12))

                if let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: side, height: side)
                                .clipped()

                        case .failure(_):
                            Image(systemName: "photo")
                                .foregroundStyle(.gray)

                        default:
                            ProgressView()
                                .scaleEffect(0.8)
                        }
                    }
                } else {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.gray)
                }
            }
            .frame(width: side, height: side)
            .clipped()
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
//굳
//끝제발
