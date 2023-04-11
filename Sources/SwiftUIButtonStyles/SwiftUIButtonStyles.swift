import SwiftUI

// MARK: - BackgroundButtonStyle
public struct BackgroundButtonStyle<Background: View>: ButtonStyle {
  private var background: Background

  public init(_ background: () -> Background) {
    self.background = background()
  }

  public func makeBody(configuration: Self.Configuration) -> some View {
    configuration
      .label
      .padding(.vertical)
      .frame(maxWidth: .infinity, alignment: .center)
      .background(background)
      .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
      .opacity(configuration.isPressed ? 0.9 : 1.0)
      .padding(.top)
  }
}

// MARK: - OutlineButtonStyle
public struct OutlineButtonStyle: ButtonStyle {
  private var color: Color
  private var lineWidth: Double

  public init(lineWidth: Double, _ color: () -> Color) {
    self.lineWidth = lineWidth
    self.color = color()
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .buttonStyle(BorderlessButtonStyle())
      .padding(.vertical)
      .frame(maxWidth: .infinity, alignment: .center)
      .foregroundColor(configuration.isPressed ? color.opacity(0.67) : color)
      .background(
        RoundedRectangle(
          cornerRadius: 8,
          style: .continuous
        )
        .stroke(color, lineWidth: lineWidth)
        .background(Color.white.opacity(0.01))
      )
      .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
      .opacity(configuration.isPressed ? 0.9 : 1.0)
  }
}

// MARK: - ProgressButtonStyle
public struct ProgressButtonStyle<Background: View>: ButtonStyle {
  private let isLoading: Bool
  private var background: Background

  public init(isLoading: Bool = false, _ background: () -> Background) {
    self.background = background()
    self.isLoading = isLoading
  }

  @ViewBuilder
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .opacity(isLoading ? 0 : 1)
      .padding(.vertical)
      .frame(maxWidth: .infinity, alignment: .center)
      .background(background)
      .overlay(
        IfTrue(value: isLoading, content: {
          #if iOS
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
          #endif
        })
      )
  }
}

// MARK: - BigButtonStyle
public struct BigButtonStyle: ButtonStyle {

  @State private var color: Color
  private var isEnabled: Bool

  public init(color: Color, isEnabled: Bool) {
    self.color = color
    self.isEnabled = isEnabled
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.title.bold())
      .padding()
      .frame(maxWidth: .infinity, alignment: .center)
      .foregroundColor(isEnabled ? .white : Color.secondary)
      .background(isEnabled ? color : color.opacity(0.3))
      .cornerRadius(8)
      .overlay(
        IfTrue(value: configuration.isPressed, content: {
          Color(white: 1.0, opacity: 0.2)
            .cornerRadius(12)
        })
      )
  }
}

public struct ScalingButtonStyle: ButtonStyle {
  private var color: Color
  private var lineWidth: Double

  public init(lineWidth: Double, _ color: () -> Color) {
    self.lineWidth = lineWidth
    self.color = color()
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(color)
      .padding()
      .frame(maxWidth: .infinity, alignment: .center)
      .background(
        RoundedRectangle(
          cornerRadius: 8,
          style: .continuous
        )
        .stroke(color, lineWidth: configuration.isPressed ? 0 : lineWidth)
        .background(Color.white.opacity(0.01))
      )
      .scaleEffect(configuration.isPressed ? 1.1 : 1)
      .animation(.default, value: configuration.isPressed)
  }
}

fileprivate struct IfTrue<Content: View>: View {
  var value: Bool
  let content: () -> Content

  public init(value: Bool = true, @ViewBuilder content: @escaping () -> Content) {
    self.value = value
    self.content = content
  }

  public var body: some View {
    if value == true {
      content()
    }
  }
}
