import SwiftUI
import Kingfisher

struct ProfilePostView: View {
    @EnvironmentObject var viewModel: MypageViewModel
    @EnvironmentObject var container: DIContainer

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)

    var body: some View {
        if viewModel.writtenPosts.isEmpty {
            EmptyView()
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(viewModel.writtenPosts, id: \.postId) { post in
                        Button {
                            container.navigationRouter.push(to: .PostView(id: post.postId))
                        } label: {
                            GeometryReader { geometry in
                                ZStack {
                                    if let imageUrl = post.imageUrl, let url = URL(string: imageUrl) {
                                        KFImage(url)
                                            .placeholder {
                                                Rectangle()
                                                    .foregroundStyle(.gray.opacity(0.2))
                                            }
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: geometry.size.width, height: geometry.size.width)
                                            .clipped()
                                    } else {
                                        ZStack {
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.1))
                                            Image("noneProfile")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(20)
                                        }
                                        .frame(width: geometry.size.width, height: geometry.size.width)
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
