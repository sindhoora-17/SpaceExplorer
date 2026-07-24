import SwiftUI

struct AsteroidDetailView: View {

    let asteroid: Asteroid

    var averageDiameter: Double {
        let min = asteroid.estimatedDiameter.meters.estimatedDiameterMin
        let max = asteroid.estimatedDiameter.meters.estimatedDiameterMax
        return (min + max) / 2
    }

    var approach: CloseApproachData? {
        asteroid.closeApproachData.first
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(asteroid.name).font(.largeTitle).fontWeight(.bold)

                    Text(asteroid.isPotentiallyHazardous ? "Potentially Hazardous" : "Safe")
                        .font(.headline)
                        .foregroundStyle(asteroid.isPotentiallyHazardous ? .red : .green)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            (asteroid.isPotentiallyHazardous ? Color.red : Color.green)
                                .opacity(0.12)
                        )
                        .clipShape(Capsule())
                }

                InfoCard(
                    title: "Estimated Diameter",
                    value: String(format: "%.2f meters", averageDiameter),
                    icon: "circle.dashed"
                )

                if let approach = approach {
                    InfoCard(
                        title: "Close Approach Date",
                        value: approach.closeApproachDate,
                        icon: "calendar"
                    )

                    InfoCard(
                        title: "Miss Distance",
                        value: formattedNumber(approach.missDistance.kilometers) + " km",
                        icon: "arrow.left.and.right"
                    )

                    InfoCard(
                        title: "Velocity",
                        value: formattedNumber(approach.relativeVelocity.kilometersPerHour) + " km/h",
                        icon: "speedometer"
                    )
                }

                InfoCard(
                    title: "Absolute Magnitude",
                    value: String(format: "%.2f", asteroid.absoluteMagnitude),
                    icon: "sparkles"
                )
            }
            .padding()
        }
        .navigationTitle("Asteroid Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    func formattedNumber(_ value: String) -> String {
        guard let number = Double(value) else {
            return value
        }

        return number.formatted(.number.precision(.fractionLength(2)))
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .frame(width: 42, height: 42)
                .background(.blue.opacity(0.12))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.headline)
            }

            Spacer()
        }
        .padding()
        .background(.black.opacity(0.05))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
