//
//  emojiView.swift
//  Cepheus Watch App
//
//  Created by 雷美淳 on 2024/4/15.
//

import SwiftUI

private let cepheusEmojiDictionary: [String: [String: [String]]] = {
  NSDictionary(contentsOf: Bundle.module.url(forResource: "EmojiDictionary", withExtension: "plist")!)! as! [String: [String: [String]]]
}()

struct CepheusKeyboardEmojiView: View {
  
  
  let emojiGroupNames: [String: LocalizedStringResource] = ["1": LocalizedStringResource("Emoji.group.1", bundle: .atURL(Bundle.module.bundleURL)), "2": LocalizedStringResource("Emoji.group.2", bundle: .atURL(Bundle.module.bundleURL)), "3": LocalizedStringResource("Emoji.group.3", bundle: .atURL(Bundle.module.bundleURL)), "4": LocalizedStringResource("Emoji.group.4", bundle: .atURL(Bundle.module.bundleURL)), "5": LocalizedStringResource("Emoji.group.5", bundle: .atURL(Bundle.module.bundleURL)), "6": LocalizedStringResource("Emoji.group.6", bundle: .atURL(Bundle.module.bundleURL)), "7": LocalizedStringResource("Emoji.group.7", bundle: .atURL(Bundle.module.bundleURL)), "8": LocalizedStringResource("Emoji.group.8", bundle: .atURL(Bundle.module.bundleURL)), "9": LocalizedStringResource("Emoji.group.9", bundle: .atURL(Bundle.module.bundleURL)), "10": LocalizedStringResource("Emoji.group.10", bundle: .atURL(Bundle.module.bundleURL))]
  let emojiGroupNamesShortened: [String: LocalizedStringResource] = ["1": LocalizedStringResource("Emoji.group.1.shortened", bundle: .atURL(Bundle.module.bundleURL)), "2": LocalizedStringResource("Emoji.group.2.shortened", bundle: .atURL(Bundle.module.bundleURL)), "3": LocalizedStringResource("Emoji.group.3.shortened", bundle: .atURL(Bundle.module.bundleURL)), "4": LocalizedStringResource("Emoji.group.4.shortened", bundle: .atURL(Bundle.module.bundleURL)), "5": LocalizedStringResource("Emoji.group.5.shortened", bundle: .atURL(Bundle.module.bundleURL)), "6": LocalizedStringResource("Emoji.group.6.shortened", bundle: .atURL(Bundle.module.bundleURL)), "7": LocalizedStringResource("Emoji.group.7.shortened", bundle: .atURL(Bundle.module.bundleURL)), "8": LocalizedStringResource("Emoji.group.8.shortened", bundle: .atURL(Bundle.module.bundleURL)), "9": LocalizedStringResource("Emoji.group.9.shortened", bundle: .atURL(Bundle.module.bundleURL)), "10": LocalizedStringResource("Emoji.group.10.shortened", bundle: .atURL(Bundle.module.bundleURL))]
  let emojiGroupExamples: [String: String] = ["0": "🕗", "1": "😀", "2": "👋", "4": "🌳", "5": "🍔", "6": "🏖️", "7": "🎉", "8": "📒", "9": "🔢", "10": "🏁"]
  let emojiSubgroupNames: [String: [LocalizedStringResource]] = [
    "1": [LocalizedStringResource("Emoji.subgroup.1.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.2", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.3", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.4", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.5", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.6", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.7", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.8", bundle: .atURL(Bundle.module.bundleURL)),  LocalizedStringResource("Emoji.subgroup.1.9", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.10", bundle: .atURL(Bundle.module.bundleURL)),  LocalizedStringResource("Emoji.subgroup.1.11", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.12", bundle: .atURL(Bundle.module.bundleURL)),  LocalizedStringResource("Emoji.subgroup.1.13", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.14", bundle: .atURL(Bundle.module.bundleURL)),  LocalizedStringResource("Emoji.subgroup.1.15", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.1.16", bundle: .atURL(Bundle.module.bundleURL))],
    "2": [LocalizedStringResource("Emoji.subgroup.2.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.2", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.3", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.4", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.5", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.6", bundle: .atURL(Bundle.module.bundleURL)),  LocalizedStringResource("Emoji.subgroup.2.7", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.8", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.9", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.10", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.11", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.12", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.13", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.14", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.15", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.2.16", bundle: .atURL(Bundle.module.bundleURL))],
    "3": [LocalizedStringResource("Emoji.subgroup.3.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.3.2", bundle: .atURL(Bundle.module.bundleURL))],
    "4": [LocalizedStringResource("Emoji.subgroup.4.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.4.2", bundle: .atURL(Bundle.module.bundleURL)),LocalizedStringResource("Emoji.subgroup.4.3", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.4.4", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.4.5", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.4.6", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.4.7", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.4.8", bundle: .atURL(Bundle.module.bundleURL))],
    "5": [LocalizedStringResource("Emoji.subgroup.5.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.5.2", bundle: .atURL(Bundle.module.bundleURL)),LocalizedStringResource("Emoji.subgroup.5.3", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.5.4", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.5.5", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.5.6", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.5.7", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.5.8", bundle: .atURL(Bundle.module.bundleURL))],
    "6": [LocalizedStringResource("Emoji.subgroup.6.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.2", bundle: .atURL(Bundle.module.bundleURL)),LocalizedStringResource("Emoji.subgroup.6.3", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.4", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.5", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.6", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.7", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.8", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.9", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.10", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.6.11", bundle: .atURL(Bundle.module.bundleURL))],
    "7": [LocalizedStringResource("Emoji.subgroup.7.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.7.2", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.7.3", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.7.4", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.7.5", bundle: .atURL(Bundle.module.bundleURL))],
    "8": [LocalizedStringResource("Emoji.subgroup.8.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.2", bundle: .atURL(Bundle.module.bundleURL)),LocalizedStringResource("Emoji.subgroup.8.3", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.4", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.5", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.6", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.7", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.8", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.9", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.10", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.11", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.12", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.13", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.14", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.15", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.16", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.17", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.8.18", bundle: .atURL(Bundle.module.bundleURL))],
    "9": [LocalizedStringResource("Emoji.subgroup.9.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.2", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.3", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.4", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.5", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.6", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.7", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.8", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.9", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.10", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.11", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.12", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.13", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.9.14", bundle: .atURL(Bundle.module.bundleURL))],
    "10": [LocalizedStringResource("Emoji.subgroup.10.1", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.10.2", bundle: .atURL(Bundle.module.bundleURL)), LocalizedStringResource("Emoji.subgroup.10.3", bundle: .atURL(Bundle.module.bundleURL))]]
  let groupExamplesAreDisplayed = true
  @Binding var textField: String
  @Binding var cursor: Int
  @Environment(\.dismiss) var dismiss
  @State var recentUsedEmojis: [Any] = []
  @State var pinyinLocation = -1
  @State var inputPinyin = ""
  @State var language = "en-qwerty"
  @State var clearRecentUsedEmojiAlertIsPresenting = false
  @AppStorage("CepheusRecentUsedEmojiCollectionsAllowed") var CepheusRecentUsedEmojiCollectionsAllowed = true
  var body: some View {
    if #available(watchOS 10.0, *) {
      NavigationStack {
        TabView {
          ForEach(1...10, id: \.self) { group in
            let group = String(group)
            if group != "3" {
              ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                  ForEach(0..<wholeGroup(cepheusEmojiDictionary[group] ?? [:]).count, id: \.self) { emoji in
                    Group {
                      if (emoji-1)%4 == 0 {
                        Button(action: {
                          textField = CepheusKeyboardAddLetter(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji-1) as? String ?? "", textField: textField, cursor: cursor)
                          recentUsedEmojis = addEmojiToRecents(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji-1) as? String ?? "")
                          cursor += 1
                        }, label: {
                          Text(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji-1) as? String ?? "")
                            .font(.system(size: screenWidth/6))
                        }).buttonStyle(.plain)
                        Button(action: {
                          textField = CepheusKeyboardAddLetter(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+0) as? String ?? "", textField: textField, cursor: cursor)
                          recentUsedEmojis = addEmojiToRecents(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+0) as? String ?? "")
                          cursor += 1
                        }, label: {
                          Text(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+0) as? String ?? "")
                            .font(.system(size: screenWidth/6))
                        }).buttonStyle(.plain)
                        Button(action: {
                          textField = CepheusKeyboardAddLetter(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+1) as? String ?? "", textField: textField, cursor: cursor)
                          recentUsedEmojis = addEmojiToRecents(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+1) as? String ?? "")
                          cursor += 1
                        }, label: {
                          Text(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+1) as? String ?? "")
                            .font(.system(size: screenWidth/6))
                        }).buttonStyle(.plain)
                        Button(action: {
                          textField = CepheusKeyboardAddLetter(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+2) as? String ?? "", textField: textField, cursor: cursor)
                          recentUsedEmojis = addEmojiToRecents(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+2) as? String ?? "")
                          cursor += 1
                        }, label: {
                          Text(arraySafeAccess(wholeGroup(cepheusEmojiDictionary[group] ?? [:]), element: emoji+2) as? String ?? "")
                            .font(.system(size: screenWidth/6))
                        }).buttonStyle(.plain)
                      }
                    }
                  }
                  .navigationTitle(Text(emojiGroupNamesShortened[group] ?? LocalizedStringResource("Emoji.group.unknown", bundle: .atURL(Bundle.module.bundleURL))))
                }
              }
            }
          }
        }
        .tabViewStyle(.verticalPage)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Button(action: {
              dismiss()
            }, label: {
              Image(systemName: "checkmark")
            })
          }
          ToolbarItem(placement: .topBarTrailing) {
            NavigationLink(destination: {
              List {
                if !recentUsedEmojis.isEmpty {
                  NavigationLink(destination: {
                    ScrollView {
                      LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(0..<recentUsedEmojis.count, id: \.self) { emoji in
                          if (emoji-1)%4 == 0 {
                            Button(action: {
                              textField = CepheusKeyboardAddLetter(arraySafeAccess(recentUsedEmojis, element: emoji-1) as? String ?? "", textField: textField, cursor: cursor)
                              cursor += 1
                            }, label: {
                              Text(arraySafeAccess(recentUsedEmojis, element: emoji-1) as? String ?? "")
                                .font(.system(size: screenWidth/6))
                            }).buttonStyle(.plain)
                            Button(action: {
                              textField = CepheusKeyboardAddLetter(arraySafeAccess(recentUsedEmojis, element: emoji+0) as? String ?? "", textField: textField, cursor: cursor)
                              cursor += 1
                            }, label: {
                              Text(arraySafeAccess(recentUsedEmojis, element: emoji+0) as? String ?? "")
                                .font(.system(size: screenWidth/6))
                            }).buttonStyle(.plain)
                            Button(action: {
                              textField = CepheusKeyboardAddLetter(arraySafeAccess(recentUsedEmojis, element: emoji+1) as? String ?? "", textField: textField, cursor: cursor)
                              cursor += 1
                            }, label: {
                              Text(arraySafeAccess(recentUsedEmojis, element: emoji+1) as? String ?? "")
                                .font(.system(size: screenWidth/6))
                            }).buttonStyle(.plain)
                            Button(action: {
                              textField = CepheusKeyboardAddLetter(arraySafeAccess(recentUsedEmojis, element: emoji+2) as? String ?? "", textField: textField, cursor: cursor)
                              cursor += 1
                            }, label: {
                              Text(arraySafeAccess(recentUsedEmojis, element: emoji+2) as? String ?? "")
                                .font(.system(size: screenWidth/6))
                            }).buttonStyle(.plain)
                          }
                        }
                      }
                    }
                    .navigationTitle(Text("Emoji.group.recents", bundle: Bundle.module))
                    .toolbar {
                      ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                          clearRecentUsedEmojiAlertIsPresenting = true
                        }, label: {
                          Image(systemName: "trash")
                        })
                      }
                    }
                    .alert("Emoji.group.recents.clear", isPresented: $clearRecentUsedEmojiAlertIsPresenting, actions: {
                      Button(role: .destructive, action: {
                        recentUsedEmojis = []
                        UserDefaults.standard.set(recentUsedEmojis, forKey: "Cepheus-recentUsedEmoji")
                      }, label: {
                        HStack {
                          Text("Emoji.group.recents.clear.confirm")
                          Spacer()
                        }
                      })
                      Button(action: {
                        
                      }, label: {
                        Text("Emoji.group.recents.clear.cancel")
                      })
                    }, message: {
                      Text("Emoji.group.recents.clear.message")
                    })
                  }, label: {
                    HStack {
                      Text(emojiGroupExamples["0"] ?? "🕙")
                      Text("Emoji.group.recents", bundle: Bundle.module)
                    }
                  })
                }
                ForEach(1...10, id: \.self) { group in
                  let group = String(group)
                  if group != "3" {
                    NavigationLink(destination: {
                      List {
                        ForEach(0..<(emojiSubgroupNames[group]?.count ?? 1), id: \.self) { subgroup in
                          NavigationLink(destination: {
                            ScrollView {
                              LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(0...(cepheusEmojiDictionary[group]?[String(subgroup+1)]?.count ?? 1), id: \.self) { emoji in
                                  if (emoji-1)%4 == 0 {
                                    Button(action: {
                                      textField = CepheusKeyboardAddLetter(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji-1) as? String ?? "", textField: textField, cursor: cursor)
                                      recentUsedEmojis = addEmojiToRecents(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji-1) as? String ?? "")
                                      cursor += 1
                                    }, label: {
                                      Text(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji-1) as? String ?? "")
                                        .font(.system(size: screenWidth/6))
                                    }).buttonStyle(.plain)
                                    Button(action: {
                                      textField = CepheusKeyboardAddLetter(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+0) as? String ?? "", textField: textField, cursor: cursor)
                                      recentUsedEmojis = addEmojiToRecents(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+0) as? String ?? "")
                                      cursor += 1
                                    }, label: {
                                      Text(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+0) as? String ?? "")
                                        .font(.system(size: screenWidth/6))
                                    }).buttonStyle(.plain)
                                    Button(action: {
                                      textField = CepheusKeyboardAddLetter(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+1) as? String ?? "", textField: textField, cursor: cursor)
                                      recentUsedEmojis = addEmojiToRecents(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+1) as? String ?? "")
                                      cursor += 1
                                    }, label: {
                                      Text(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+1) as? String ?? "")
                                        .font(.system(size: screenWidth/6))
                                    }).buttonStyle(.plain)
                                    Button(action: {
                                      textField = CepheusKeyboardAddLetter(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+2) as? String ?? "", textField: textField, cursor: cursor)
                                      recentUsedEmojis = addEmojiToRecents(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+2) as? String ?? "")
                                      cursor += 1
                                    }, label: {
                                      Text(arraySafeAccess(cepheusEmojiDictionary[group]?[String(subgroup+1)] ?? [], element: emoji+2) as? String ?? "")
                                        .font(.system(size: screenWidth/6))
                                    }).buttonStyle(.plain)
                                  }
                                }
                              }
                            }
                            .navigationTitle(Text(arraySafeAccess(emojiSubgroupNames[group] ?? [], element: subgroup) as? LocalizedStringResource ?? LocalizedStringResource("Emoji.subgroup.unknown", bundle: .atURL(Bundle.module.bundleURL))))
                          }, label: {
                            Text(arraySafeAccess(emojiSubgroupNames[group] ?? [], element: subgroup) as? LocalizedStringResource ?? LocalizedStringResource("Emoji.subgroup.unknown", bundle: .atURL(Bundle.module.bundleURL)))
                          })
                        }
                      }
                      .navigationTitle(Text(emojiGroupNames[group] ?? LocalizedStringResource("Emoji.group.unknown", bundle: .atURL(Bundle.module.bundleURL))))
                    }, label: {
                      HStack {
                        Text(emojiGroupExamples[group] ?? "❓")
                        Text(emojiGroupNames[group] ?? LocalizedStringResource("Emoji.group.unknown", bundle: .atURL(Bundle.module.bundleURL)))
                      }
                    })
                  }
                }
              }
              .navigationTitle(Text("Emoji.list.title", bundle: Bundle.module))
            }, label: {
              Image(systemName: "list.bullet")
            })
            
          }
        }
      }
      .overlay {
        VStack {
          Spacer()
          CepheusKeyboardTextFieldPreviewView(textField: $textField, cursor: $cursor, pinyinLocation: $pinyinLocation, pinyinInput: $inputPinyin, language: $language)
            .offset(y: -10)
            .frame(width: screenWidth*0.85)
            .background {
              Rectangle()
                .foregroundStyle(.black)
                .blur(radius: 15)
                .opacity(0.7)
                .frame(width: screenWidth, height: 65) // EDITED
                .padding(-12)
            }
        }
        .ignoresSafeArea()
      }
      .onAppear {
        recentUsedEmojis = UserDefaults.standard.array(forKey: "Cepheus-recentUsedEmoji") ?? []
      }
    }
  }
  func addEmojiToRecents(_ emoji: String) -> [Any] {
    if CepheusRecentUsedEmojiCollectionsAllowed {
      var emojiFound = -1
      var emojiCount = -1
      var editableArray = UserDefaults.standard.array(forKey: "Cepheus-recentUsedEmoji") ?? []
      for element in editableArray {
        emojiCount += 1
        if element as! String == emoji {
          emojiFound = emojiCount
        }
      }
      if emojiFound != -1 {
        editableArray.remove(at: emojiFound)
      }
      editableArray.insert(emoji, at: 0)
      UserDefaults.standard.set(editableArray, forKey: "Cepheus-recentUsedEmoji")
      return editableArray
    } else {
      return UserDefaults.standard.array(forKey: "Cepheus-recentUsedEmoji") ?? []
    }
  }
}

func wholeGroup(_ dictionary: [String: [String]]) -> [String] {
  var output: [String] = []
  for subgroup in 1...20 {
    output += dictionary[String(subgroup)] ?? []
  }
  return output
}
