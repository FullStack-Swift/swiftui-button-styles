//
//  ContentView.swift
//  Examples
//
//  Created by Nguyen Phong on 3/24/23.
//

import SwiftUI
import ButtonStyles

struct ContentView: View {

  @State private var isLoading: Bool = true
  @State private var isEnabled: Bool = true

  var body: some View {
    ZStack(alignment: .top) {
      NavigationView {
        ScrollView {
          VStack {
            // MARK: - BackgroundButtonStyle
            Button {

            } label: {
              Text("BackgroundButtonStyle")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
            .buttonStyle(BackgroundButtonStyle{
              Color.green
                .clipShape(RoundedRectangle(cornerRadius: 8))
            })
            .padding()
            // MARK: - OutlineButtonStyle
            Button {

            } label: {
              Text("OutlineButtonStyle")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            }
            .buttonStyle(OutlineButtonStyle(lineWidth: 1) {
              Color.blue
            })
            .padding()
            // MARK: - ProgressButtonStyle
            Button {
              isLoading.toggle()
            } label: {
              Text("ProgressButtonStyle")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
            .buttonStyle(ProgressButtonStyle(isLoading: isLoading,{
              Color.orange
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }))
            .padding()
            // MARK: - BorderedButtonStyle
            Button {
              isEnabled.toggle()
            } label: {
              Text("BigButtonStyle")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
            .buttonStyle(BigButtonStyle(color: .pink, isEnabled: isEnabled))
            .padding()
            // MARK: - ScalingButtonStyle
            Button {

            } label: {
              Text("ScalingButtonStyle")
                .font(.callout)
                .fontWeight(.bold)
            }
            .buttonStyle(ScalingButtonStyle(lineWidth: 1) {
              Color.yellow
            })
            .padding()
          }
          .padding()
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
