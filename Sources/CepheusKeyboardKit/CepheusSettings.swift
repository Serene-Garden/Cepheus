//
//  CepheusSettings.swift
//
//
//  Created by 雷美淳 on 2024/5/15.
//

import SwiftUI

public struct CepheusSettingsView: View {
  public let CepheusVersion = "1.3.3"
  public init(CepheusLocalizedByKeyboardLanguage: Bool = true, CepheusRecentUsedEmojiCollectionsAllowed: Bool = true, CepheusSaveWhenDismissed: Bool = false) {
    self.CepheusLocalizedByKeyboardLanguage = CepheusLocalizedByKeyboardLanguage
    self.CepheusRecentUsedEmojiCollectionsAllowed = CepheusRecentUsedEmojiCollectionsAllowed
    self.CepheusSaveWhenDismissed = CepheusSaveWhenDismissed
  }
  @AppStorage("CepheusLocalizedByKeyboardLanguage") var CepheusLocalizedByKeyboardLanguage = true
  @AppStorage("CepheusRecentUsedEmojiCollectionsAllowed") var CepheusRecentUsedEmojiCollectionsAllowed = true
  @AppStorage("CepheusSaveWhenDismissed") var CepheusSaveWhenDismissed = false
  public var body: some View {
    if #available(watchOS 10.0, *) {
      Group {
        List {
          Group {
            HStack {
              Spacer()
              VStack(alignment: .center) {
                Text(String("Cepheus"))
                  .bold()
                  .font(.title2)
                Group {
                  Text(String("By Serene Garden"))
                  Text(String(CepheusVersion))
                    .monospaced()
                }
                //        .foregroundStyle(.secondary)
                .font(.caption)
              }
              Spacer()
            }
          }
          .listRowBackground(Rectangle().opacity(0).frame(height: 0))
          //        Form {
          Section {
            Toggle(isOn: $CepheusLocalizedByKeyboardLanguage, label: {
              CepheusLabel(localizedStringKey: "About.settings.localize-according-to-keyboard", labelIcon: "textformat.superscript", labelIconIsSymbol: true)
            })
            Toggle(isOn: $CepheusRecentUsedEmojiCollectionsAllowed, label: {
              CepheusLabel(localizedStringKey: "About.settings.allow-recent-emojis-collections", labelIcon: "clock", labelIconIsSymbol: true)
            })
            Toggle(isOn: $CepheusSaveWhenDismissed, label: {
              CepheusLabel(localizedStringKey: "About.settings.save-edits-when-dismiss", labelIcon: "square.and.arrow.down", labelIconIsSymbol: true)
            })
          }
          Section {
            NavigationLink(destination: {
              CepheusCreditView()
            }, label: {
              HStack {
                Image(systemName: "fleuron")
                  .font(.system(size: 20))
                  .foregroundStyle(.tint)
                  .fontDesign(.rounded)
                VStack(alignment: .leading) {
                  Text(String(localized: "About.credits", bundle: Bundle.module))
                }
              }
            })
          }
        }
      }
    }
  }
}

public struct CepheusCreditView: View {
  public init(CaptainLogLinkIsDisplaying: Bool = false) {
    self.CaptainLogLinkIsDisplaying = CaptainLogLinkIsDisplaying
  }
  @State var CaptainLogLinkIsDisplaying = false
  public var body: some View {
    List {
      Section(content: {
        Text(String("ThreeManager785"))
        Text(String("WindowsMEMZ"))
        VStack(alignment: .leading) {
          Text(String("CaptainLog"))
          if CaptainLogLinkIsDisplaying {
            Text(String("转自船长日志, 本文链接地址: http://www.cslog.cn/Content/word-frequency-list-of-chinese/"))
              .font(.footnote)
              .foregroundStyle(.secondary)
          }
        }
        .onTapGesture {
          CaptainLogLinkIsDisplaying.toggle()
        }
      }, footer: {
        Text(String("https://github.com/Serene-Garden/Cepheus"))
      })
    }
  }
}

