import SwiftUI
import Kingfisher

struct SavedPostView: View {
    @EnvironmentObject var viewModel: MypageViewModel
    @EnvironmentObject var container: DIContainer

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)

    var body: some View {
        if viewModel.savedPosts.isEmpty {
            EmptyView()
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(viewModel.savedPosts, id: \.postId) { post in
                        Button {
                            container.navigationRouter.push(to: .PostView(id: post.postId))
                        } label: {
                            GeometryReader { geo in
                                if let imageUrl = post.imageUrl,
                                   let url = URL(string: imageUrl) {
                                    KFImage(url)
                                        .placeholder {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundStyle(.gray.opacity(0.2))
                                                ProgressView()
                                            }
                                        }
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width, height: geo.size.width)
                                        .clipped()
                                } else {
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.1))
                                            .frame(width: geo.size.width, height: geo.size.width)

                                        Image("noneProfile")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geo.size.width * 0.5)
                                    }
                                }
                            }
                            .aspectRatio(1, contentMode: .fit)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top, 1)
            }
        }
    }
}
