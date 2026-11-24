// swift-tools-version:5.9
//
// Package.swift của REPO PHÂN PHỐI (chỉ chứa file này + wrapper rỗng, KHÔNG có source SDK).
// File được sinh bởi Scripts/make_distribution_package.sh từ template này.
//
// Cấu trúc:
//  - binaryTarget  : CTLTrackingAdsV2.xcframework (không có source). SDK KHÔNG phụ thuộc thư viện protobuf:
//                    app host tự sinh AppNews.pb.swift và tự dựng event.
//  - wrapper target: không có code; phụ thuộc vào binaryTarget và swift-protobuf.
//  - dependency    : swift-protobuf, khai báo để app host có sẵn runtime cho AppNews.pb.swift của chính mình
//                    (SDK không dùng nó). Nếu app host muốn tự quản lý swift-protobuf thì xoá
//                    dependency này và dòng `.product(name: "SwiftProtobuf"...)` bên dưới.
//                    Chỉ khai báo phiên bản TỐI THIỂU (`from:`), app host được dùng bản mới hơn.
import PackageDescription

let package = Package(
    name: "CTLTrackingAdsV2",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "CTLTrackingAdsV2",
            targets: ["CTLTrackingAdsV2Target"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.41.0")
    ],
    targets: [
        .binaryTarget(
            name: "CTLTrackingAdsV2",
            url: "https://github.com/CanThaiLinh/CTLTrackingAdsV2/releases/download/1.0.0/CTLTrackingAdsV2.xcframework.zip",
            checksum: "de39b88fa708eb63c60ddbac76e018f8d4ae6824c35311f939af485727971d75"
        ),
        .target(
            name: "CTLTrackingAdsV2Target",
            dependencies: [
                .target(name: "CTLTrackingAdsV2"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ],
            path: "Sources/CTLTrackingAdsV2Target"
        )
    ]
)
