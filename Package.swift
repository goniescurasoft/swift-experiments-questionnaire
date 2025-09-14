// swift-tools-version: 6.1

import PackageDescription

let package = Package(
  name: "swift-experiments-questionnaire",
  platforms: [.iOS(.v18)],
  products: [
    .library(
      name: "swift-experiments-questionnaire",
      targets: ["swift-experiments-questionnaire"]
    ),
  ],
  targets: [
    .target(
      name: "swift-experiments-questionnaire"
    ),
    .testTarget(
      name: "swift-experiments-questionnaireTests",
      dependencies: ["swift-experiments-questionnaire"]
    ),
  ]
)
