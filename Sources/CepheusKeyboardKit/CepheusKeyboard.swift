//
//  KeyboardView.swift
//  Cepheus Watch App
//
//  Created by 雷美淳 on 2024/4/11.
//

import SwiftUI
//import Speech
let screenWidth = WKInterfaceDevice.current().screenBounds.size.width
let screenHeight = WKInterfaceDevice.current().screenBounds.size.height

public struct CepheusKeyboard: View {
    //Configurations
    public var input: Binding<String>
    public var prompt: LocalizedStringKey?
    public var stringPrompt: String?
    public var CepheusIsEnabled: Bool = true
    public var defaultLanguage: String =  "en-qwerty"
    public var languageDisallowRules: String = "none" //none, deny-all, deny-Latin, deny-CJK, English-only
    public var allowEmojis: Bool = true
    public var isSecure: Bool = false
    public var displayingSecureTextIsAllowed: Bool = true
    public var autoCorrectionIsEnabled: Bool = true
    public var onSubmit: () -> Void = {}
    
    @State var CepheusKeyboardIsDisplaying = false
    @State var dottedText = ""
    /// <#Description#>
    /// - Parameters:
    ///   - input: <#input description#>
    ///   - prompt: <#prompt description#>
    ///   - CepheusIsEnabled: <#CepheusIsEnabled description#>
    ///   - defaultLanguage: <#defaultLanguage description#>
    ///   - languageDisallowRules: <#languageDisallowRules description#>
    ///   - allowEmojis: <#allowEmojis description#>
    ///   - isSecure: <#isSecure description#>
    ///   - displayingSecureTextIsAllowed: <#displayingSecureTextIsAllowed description#>
    ///   - CepheusKeyboardIsDisplaying: <#CepheusKeyboardIsDisplaying description#>
    ///   - dottedText: <#dottedText description#>
    ///   - autoCorrectionIsEnabled: <#autoCorrectionIsEnabled description#>
    ///   - onSubmit: <#onSubmit description#>
    public init(input: Binding<String>, prompt: LocalizedStringKey = LocalizedStringKey("Cepheus.prompt"), CepheusIsEnabled: Bool = true, defaultLanguage: String = "en-qwerty", languageDisallowRules: String = "none", allowEmojis: Bool = true, isSecure: Bool = false, displayingSecureTextIsAllowed: Bool = true, CepheusKeyboardIsDisplaying: Bool = false, dottedText: String = "", autoCorrectionIsEnabled: Bool = true, onSubmit: @escaping () -> Void = {}) {
        self.input = input
        self.prompt = prompt
        self.CepheusIsEnabled = CepheusIsEnabled
        self.defaultLanguage = defaultLanguage
        self.languageDisallowRules = languageDisallowRules
        self.allowEmojis = allowEmojis
        self.isSecure = isSecure
        self.displayingSecureTextIsAllowed = displayingSecureTextIsAllowed
        self.CepheusKeyboardIsDisplaying = CepheusKeyboardIsDisplaying
        self.dottedText = dottedText
        self.autoCorrectionIsEnabled = autoCorrectionIsEnabled
        self.onSubmit = onSubmit
    }
    /// <#Description#>
    /// - Parameters:
    ///   - input: <#input description#>
    ///   - prompt: <#prompt description#>
    ///   - CepheusIsEnabled: <#CepheusIsEnabled description#>
    ///   - defaultLanguage: <#defaultLanguage description#>
    ///   - languageDisallowRules: <#languageDisallowRules description#>
    ///   - allowEmojis: <#allowEmojis description#>
    ///   - isSecure: <#isSecure description#>
    ///   - displayingSecureTextIsAllowed: <#displayingSecureTextIsAllowed description#>
    ///   - CepheusKeyboardIsDisplaying: <#CepheusKeyboardIsDisplaying description#>
    ///   - dottedText: <#dottedText description#>
    ///   - autoCorrectionIsEnabled: <#autoCorrectionIsEnabled description#>
    ///   - onSubmit: <#onSubmit description#>
    @_disfavoredOverload public init(input: Binding<String>, prompt: String = String(localized: "Cepheus.prompt"), CepheusIsEnabled: Bool = true, defaultLanguage: String = "en-qwerty", languageDisallowRules: String = "none", allowEmojis: Bool = true, isSecure: Bool = false, displayingSecureTextIsAllowed: Bool = true, CepheusKeyboardIsDisplaying: Bool = false, dottedText: String = "", autoCorrectionIsEnabled: Bool = true, onSubmit: @escaping () -> Void = {}) {
        self.input = input
        self.stringPrompt = prompt
        self.CepheusIsEnabled = CepheusIsEnabled
        self.defaultLanguage = defaultLanguage
        self.languageDisallowRules = languageDisallowRules
        self.allowEmojis = allowEmojis
        self.isSecure = isSecure
        self.displayingSecureTextIsAllowed = displayingSecureTextIsAllowed
        self.CepheusKeyboardIsDisplaying = CepheusKeyboardIsDisplaying
        self.dottedText = dottedText
        self.autoCorrectionIsEnabled = autoCorrectionIsEnabled
        self.onSubmit = onSubmit
    }
    public var body: some View {
        if CepheusIsEnabled {
            if #available(watchOS 10.0, *) {
                Button(action: {
                    CepheusKeyboardIsDisplaying = true
                }, label: {
                    HStack {
                        if input.wrappedValue.isEmpty {
                            if let prompt {
                                Text(prompt)
                                    .foregroundStyle(.secondary)
                            } else if let stringPrompt {
                                Text(stringPrompt)
                                    .foregroundStyle(.secondary)
                            }
                        } else {
                            Text(isSecure ? dottedText : input.wrappedValue)
                        }
                        Spacer()
                    }
                    .onChange(of: input.wrappedValue) {
                        dottedText = CepheusKeyboardLettersToDots(input.wrappedValue)
                    }
                    .onChange(of: CepheusKeyboardIsDisplaying) {
                        if !CepheusKeyboardIsDisplaying {
                            onSubmit()
                        }
                    }
                    .sheet(isPresented: $CepheusKeyboardIsDisplaying, content: {
                        CepheusKeyboardMainView(input: input, defaultLanguage: defaultLanguage, isSecure: isSecure, languageDisallowRules: languageDisallowRules, allowEmojis: allowEmojis, displayingSecureTextIsAllowed: displayingSecureTextIsAllowed, prompt: prompt, stringPrompt: stringPrompt)
                    })
                })
            } else {
                Text("Cepheus.unavailable", bundle: .module)
            }
        } else {
            if !isSecure {
                TextField(text: input, label: {
                    if let prompt {
                        Text(prompt)
                    } else if let stringPrompt {
                        Text(stringPrompt)
                    }
                })
                .autocorrectionDisabled(!autoCorrectionIsEnabled)
                .onSubmit {
                    onSubmit()
                }
                //        TextField(prompt, text: $input)
            } else {
                SecureField(text: input, label: {
                    if let prompt {
                        Text(prompt)
                    } else if let stringPrompt {
                        Text(stringPrompt)
                    }
                })
                .autocorrectionDisabled(!autoCorrectionIsEnabled)
                .onSubmit {
                    onSubmit()
                }
                //        SecureField(prompt, text: $input)
            }
        }
    }
}

struct CepheusKeyboardMainView: View {
    //INPUTS
    @Binding var input: String //The input text
    var defaultLanguage: String =  "en-qwerty" //The default language
    var isSecure: Bool = false //Yes for entering passwords
    var languageDisallowRules: String = "none" //Disallow languages //none, deny-all, deny-Latin, deny-CJK, English-only
    var allowEmojis: Bool = true //Allow to enter emoji or not
    var displayingSecureTextIsAllowed: Bool = true //Determine if the user is able to check password
    var prompt: LocalizedStringKey?
    var stringPrompt: String?
    
    //LANGUAGES
    let languageCodes = ["en-qwerty", "zh-hans-pinyin"]
    @State var keyboardLanguage = "en-qwerty"
    //TEXT STATUS
    @State var textField = ""
    @State var secureField = ""
    @State var keyboardState = 0
    @State var capitalLetterIsTyped = false
    @State var capsLockIsOn = false
    @State var cursor = 0
    //SHEETS
    @State var languageSheetIsDisplaying = false
    @State var emojiSheetIsDisplaying = false
    //PINYIN
    @State var inputPinyin = ""
    @State var outputCharacter = ""
    @State var pinyinLocation = -1
    //DISMISS
    @Environment(\.dismiss) var dismiss
    var body: some View {
        if #available(watchOS 10.0, *) {
            VStack {
                CepheusKeyboardTextFieldPreviewView(textField: $textField, cursor: $cursor, pinyinLocation: $pinyinLocation, pinyinInput: $inputPinyin, language: $keyboardLanguage, isSecure: isSecure, displayingSecureTextIsAllowed: displayingSecureTextIsAllowed, prompt: prompt, stringPrompt: stringPrompt)
                if keyboardLanguage == "zh-hans-pinyin" {
                    CepheusPiyin(input: $textField, inputPinyin: $inputPinyin, pinyinLocation: $pinyinLocation, cursor: $cursor)
                }
                Spacer()
                    .frame(height: screenHeight/((keyboardLanguage == "zh-hans-pinyin") ? 50 : 15))
                CepheusKeyboardTextKeysView(textField: $textField, cursor: $cursor, language: $keyboardLanguage, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin)
                Spacer()
                
                HStack {
                    Button(action: {
                        languageSheetIsDisplaying = true
                    }, label: {
                        Image(systemName: "globe")
                    })
                    .sheet(isPresented: $languageSheetIsDisplaying, content: {
                        CepheusKeyboardLanguagePickerView(language: $keyboardLanguage, textField: $textField, cursor: $cursor, languageDisallowRules: languageDisallowRules)
                    })
                    Spacer()
                    if inputPinyin.isEmpty {
                        Button(action: {
                            textField = CepheusKeyboardAddLetter(" ", textField: textField, cursor: cursor)
                            cursor += 1
                        }, label: {
                            Text("Cepheus.space", bundle: .module)
                        })
                    } else {
                        Button(action: {
                            pinyinLocation += 1
                            inputPinyin = backspace(textField: inputPinyin, cursor: 1)
                        }, label: {
                            Text("Cepheus.pinyin.ignore", bundle: .module)
                        })
                    }
                    Spacer()
                    Button(action: {
                        emojiSheetIsDisplaying = true
                    }, label: {
                        Image(uiImage: UIImage(data: Data(base64Encoded: emojiSymbol)!)!.withRenderingMode(.alwaysTemplate)) //EDITED
                            .resizable()
                            .foregroundStyle(Color.white)
                            .frame(width: 18, height: 18)
                            .sheet(isPresented: $emojiSheetIsDisplaying, content: {
                                CepheusKeyboardEmojiView(textField: $textField, cursor: $cursor)
                            })
                    })
                    .disabled(!(allowEmojis && !isSecure))
                }
                .offset(y: -10)
                .frame(width: screenWidth*0.8)
            }
            .buttonStyle(.plain)
            .onAppear {
                if !languageCodes.contains(defaultLanguage) {
                    keyboardLanguage = "en-qwerty"
                } else {
                    keyboardLanguage = defaultLanguage
                }
                textField = input //The editable text is starting in textField not input.
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button(action: {
                        dismiss() //Simply close the sheet.
                    }, label: {
                        Image(systemName: "xmark")
                    })
                })
                ToolbarItem(placement: .confirmationAction, content: {
                    Button(action: {
                        input = textField //Save the content then close.
                        dismiss()
                    }, label: {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.tint)
                    })
                })
            }
            .ignoresSafeArea(edges: .bottom)
            .onChange(of: inputPinyin) {
                if inputPinyin.isEmpty {
                    pinyinLocation = -1
                }
            }
            //    .ignoresSafeArea()
        }
    }
    func backspace(textField: String, cursor: Int) -> String {
        var singleLetters: [Character] = []
        for letter in textField {
            singleLetters.append(letter)
        }
        if cursor-1 >= 0 {
            singleLetters.remove(at: cursor-1)
        }
        return singleLetters.map{String($0)}.joined()
    }
}

struct CepheusKeyboardTextFieldPreviewView: View {
    @Binding var textField: String //The displayed text
    @Binding var cursor: Int //Where should the cursor be
    @Binding var pinyinLocation: Int
    @Binding var pinyinInput: String
    @Binding var language: String
    @State var cursorHiddenTexts = "" //The hidden text that helps display the cursor
    @State var digitalCrownRotation = 0.0 //The degrees the crown had rotated
    @State var secureFieldIsEdited = false
    @State var textFieldCount = 0
    @State var secureField = ""
    @State var secureTextIsDisplaying = false
    @State var pinyinHiddenText = ""
    @FocusState var cursorIsOnFocus: Bool
    var isSecure: Bool = false
    var displayingSecureTextIsAllowed: Bool = true
    var prompt: LocalizedStringKey?
    var stringPrompt: String?
    var body: some View {
        if #available(watchOS 10.0, *) {
            HStack {
                ScrollView(.horizontal) {
                    ZStack {
                        if (prompt != "") && textField.isEmpty {
                            HStack {
                                if let prompt {
                                    Text(prompt)
                                        .foregroundStyle(.secondary)
                                } else if let stringPrompt {
                                    Text(stringPrompt)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                        }
                        HStack(spacing: 0) {
                            if secureTextIsDisplaying {
                                Text(secureField)
                                //                .foregroundStyle(.blue)
                            } else {
                                //                ForEach(0..<textField.count, id: \.self) { i in
                                //                  Text(String(textField[textField.index(textField.startIndex, offsetBy: i)]))
                                //                    .onTapGesture {
                                //                      digitalCrownRotation = Double(i)
                                //                    }
                                //                } // EDITED - 6lines & line#219 - move indicator when clicking a character //REMOVED
                                Text(textField)
                            }
                            Spacer()
                        }
                        .onChange(of: textField) {
                            if secureTextIsDisplaying {
                                secureFieldIsEdited = true
                                secureField = CepheusKeyboardLettersToDots(textField)
                                cursorHiddenTexts = cuttedTextAtCursor(textField: secureField, cursor: cursor)
                                secureFieldIsEdited = false
                            } else {
                                cursorHiddenTexts = cuttedTextAtCursor(textField: textField, cursor: cursor)
                            }
                        }
                        .onChange(of: secureTextIsDisplaying) {
                            if secureTextIsDisplaying {
                                secureFieldIsEdited = true
                                secureField = CepheusKeyboardLettersToDots(textField)
                                cursorHiddenTexts = cuttedTextAtCursor(textField: secureField, cursor: cursor)
                                secureFieldIsEdited = false
                            } else {
                                cursorHiddenTexts = cuttedTextAtCursor(textField: textField, cursor: cursor)
                            }
                        }
                        HStack {
                            if pinyinLocation != -1 {
                                Text(pinyinHiddenText)
                                    .foregroundStyle(.green)
                                    .opacity(0)
                                Text(pinyinInput)
                                    .foregroundStyle(.yellow)
                                    .padding(-5)
                                    .opacity(0)
                                    .background {
                                        RoundedRectangle(cornerRadius: 3)
                                            .foregroundStyle(.white)
                                            .opacity(0.2)
                                            .padding(-5)
                                    }
                                Spacer()
                            }
                        }
                        HStack {
                            Text(cursorHiddenTexts)
                                .foregroundStyle(.red)
                                .opacity(0)
                            Capsule()
                                .frame(width: 2, height: 30)
                                .foregroundStyle(cursorIsOnFocus ? Color.blue : Color.secondary)
                                .padding(-5)
                            Spacer()
                        }
                    }
                    .privacySensitive(isSecure)
                }
                .focusable()
                .focused($cursorIsOnFocus)
                .digitalCrownRotation($digitalCrownRotation, from: pinyinInput.isEmpty ? 0.0 : Double(pinyinLocation-1), through: pinyinInput.isEmpty ? Double(textField.count) : Double(pinyinLocation + pinyinInput.count), by: 1, sensitivity: .low, isContinuous: false)
                .scrollIndicators(.hidden)
                .animation(.linear(duration: 0.2), value: digitalCrownRotation)
                //        .animation(.easeIn(duration: 0.2), value: textField) // EDITED - 3lines - Animaton when inputing & deleting; Hide digital crown scroll indicator
                .onChange(of: digitalCrownRotation, {
                    //QUICK NAVI: CURSOR MOVEMENT
                    if abs(digitalCrownRotation - Double(cursor)) >= 1 {
                        if !pinyinInput.isEmpty {
                            if cursor < pinyinLocation {
                                //              digitalCrownRotation -= digitalCrownRotation - Double(cursor)
                                if digitalCrownRotation - Double(cursor) > 0 {
                                    cursor += Int(digitalCrownRotation - Double(cursor))
                                    //                praint("CURSOR MOVEMENT INSPECTION 1 TOGGLED")
                                    //                praint("(\(digitalCrownRotation), \(cursor), \(pinyinLocation), \(pinyinInput.count))")---
                                    
                                }
                            } else if cursor >= (pinyinLocation + pinyinInput.count-1) {
                                //              digitalCrownRotation += digitalCrownRotation - Double(cursor)
                                if digitalCrownRotation - Double(cursor) < 0 {
                                    //                praint("CURSOR MOVEMENT INSPECTION 2 TOGGLED")
                                    //                praint("(\(digitalCrownRotation), \(cursor), \(pinyinLocation), \(pinyinInput.count))")
                                    cursor += Int(digitalCrownRotation - Double(cursor))
                                }
                            } else {
                                cursor += Int(digitalCrownRotation - Double(cursor))
                                //              praint("CURSOR MOVEMENT INSPECTION 3 TOGGLED")
                                //              praint("(\(digitalCrownRotation), \(cursor), \(pinyinLocation), \(pinyinInput.count))")
                            }
                        } else {
                            cursor += Int(digitalCrownRotation - Double(cursor))
                        }
                    }
                })
                if isSecure && displayingSecureTextIsAllowed {
                    Button(action: {
                        secureTextIsDisplaying.toggle()
                    }, label: {
                        Image(systemName: secureTextIsDisplaying ? "eye" : "eye.slash")
                    })
                }
                Button(action: {
                    if cursor - pinyinLocation >= 0 && language == "zh-hans-pinyin" || language != "zh-hans-pinyin" {
                        textField = backspace(textField: textField, cursor: cursor)
                        if cursor > 0 {
                            cursor -= 1
                        }
                        if !pinyinInput.isEmpty {
                            pinyinInput = backspace(textField: pinyinInput, cursor: cursor-pinyinHiddenText.count+1)
                            //            praint("[1]\(pinyinInput)")
                        }
                    }
                }, label: {
                    Image(systemName: "delete.backward.fill")
                })
                .buttonStyle(.plain)
                .onChange(of: cursor) {
                    cursorHiddenTexts = cuttedTextAtCursor(textField: secureTextIsDisplaying ? secureField : textField, cursor: cursor)
                    pinyinHiddenText = cuttedTextAtCursor(textField: secureTextIsDisplaying ? secureField : textField, cursor: pinyinLocation-1)
                    digitalCrownRotation = Double(cursor)
                    if cursor < 0 {
                        cursor = 0
                    }
                }
                .onChange(of: pinyinInput) {
                    pinyinHiddenText = cuttedTextAtCursor(textField: secureTextIsDisplaying ? secureField : textField, cursor: pinyinLocation-1)
                    if pinyinInput.isEmpty {
                        pinyinLocation = -1
                        pinyinHiddenText = ""
                    }
                }
            }
            .onAppear {
                secureTextIsDisplaying = isSecure
                cursorHiddenTexts = cuttedTextAtCursor(textField: secureTextIsDisplaying ? secureField : textField, cursor: cursor)
                cursor = textField.count
            }
            .onChange(of: language) {
                if language != "zh-hans-pinyin" {
                    pinyinInput = ""
                    pinyinLocation = -1
                    pinyinHiddenText = ""
                }
            }
        }
    }
    func backspace(textField: String, cursor: Int) -> String {
        var singleLetters: [Character] = []
        for letter in textField {
            singleLetters.append(letter)
        }
        if cursor-1 >= 0 && cursor <= singleLetters.count {
            singleLetters.remove(at: cursor-1)
        }
        return singleLetters.map{String($0)}.joined()
    }
    func cuttedTextAtCursor(textField: String, cursor: Int) -> String {
        var singleLetters: [Character] = []
        var letterCount = 0
        for letter in textField {
            letterCount += 1
            if letterCount <= cursor {
                singleLetters.append(letter)
            }
        }
        return singleLetters.map{String($0)}.joined()
    }
}

struct CepheusKeyboardTextKeysView: View {
    let qwertyEngLet1 = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
    let qwertyEngLet2 = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
    let qwertyEngLet3 = ["z", "x", "c", "v", "b", "n", "m"]
    let qwertyNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    let qwertyNum2: [String: [String]] = ["en-qwerty": ["-", "/", ":", ";", "(", ")", "$", "&", "@", "\""], "zh-hans-pinyin": ["-", "/", "：", "；", "（", "）", "¥", "@", "“", "”"]]
    let qwertySym1 = ["en-qwerty": ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="], "zh-hans-pinyin": ["【", "】", "{", "}", "#", "%", "^", "*", "+", "="]]
    let qwertySym2 = ["en-qwerty": ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "·"], "zh-hans-pinyin": ["_", "—", "\\", "|", "～", "《", "》", "$", "&", "·"]]
    let qwertySym3 = ["en-qwerty": [".", ",", "?", "!", "'"], "zh-hans-pinyin": ["…", "，", "、", "？", "！", "’"]]
    let qwertyPunc = ["en-qwerty": [".", ",", "?", "!", "'"], "zh-hans-pinyin": ["。", "，", "、", "？", "！", "."]]
    let qwertyPuncKeySpaceDivide: [String: CGFloat] = ["en-qwerty": 10, "zh-hans-pinyin": 13]
    @Binding var textField: String //The displayed text
    @Binding var cursor: Int //Where should the cursor be
    @Binding var language: String
    @Binding var pinyinLocation: Int
    @Binding var inputPinyin: String
    @State var keyboardState = 0
    @State var letterIsCapital = false
    @State var capsLockIsOn = false
    var body: some View {
        if #available(watchOS 10.0, *) {
            Group {
                if keyboardState == 0 {
                    Group {
                        CepheusKeyboardSingleKeyRowView(keys: qwertyEngLet1, textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin)
                        Spacer()
                        CepheusKeyboardSingleKeyRowView(keys: qwertyEngLet2, textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin)
                        Spacer()
                        CepheusKeyboardSingleKeyRowView(keys: qwertyEngLet3, isLastRow: true, textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin)
                    }
                } else if keyboardState == 1 {
                    Group {
                        CepheusKeyboardSingleKeyRowView(keys: qwertyNumbers, textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin)
                        Spacer()
                        CepheusKeyboardSingleKeyRowView(keys: qwertyNum2[language] ?? ["ERROR"], textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin)
                        Spacer()
                        CepheusKeyboardSingleKeyRowView(keys: qwertyPunc[language] ?? ["ERROR"], isLastRow: true, textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin, keySpaceDividedNumber: qwertyPuncKeySpaceDivide[language] ?? 10)
                    }
                } else if keyboardState == 2 {
                    Group {
                        CepheusKeyboardSingleKeyRowView(keys: qwertySym1[language] ?? ["ERROR"], textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin)
                        Spacer()
                        CepheusKeyboardSingleKeyRowView(keys: qwertySym2[language] ?? ["ERROR"], textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin)
                        Spacer()
                        CepheusKeyboardSingleKeyRowView(keys: qwertySym3[language] ?? ["ERROR"], isLastRow: true, textField: $textField, cursor: $cursor, letterIsCapital: $letterIsCapital, capsLockIsOn: $capsLockIsOn, keyboardState: $keyboardState, language: $language, pinyinLocation: $pinyinLocation, inputPinyin: $inputPinyin, keySpaceDividedNumber: qwertyPuncKeySpaceDivide[language] ?? 10)
                    }
                }
            }
            .font(.system(size: 15))
        }
    }
}

struct CepheusKeyboardSingleKeyRowView: View {
    var keys: [String]
    var isLastRow: Bool = false
    @Binding var textField: String
    @Binding var cursor: Int
    @Binding var letterIsCapital: Bool
    @Binding var capsLockIsOn: Bool
    @Binding var keyboardState: Int
    @Binding var language: String
    @Binding var pinyinLocation: Int
    @Binding var inputPinyin: String
    var keySpaceDividedNumber: CGFloat = 13
    var body: some View {
        if #available(watchOS 10.0, *) {
            HStack { //The first letter line of keyboard
                if isLastRow {
                    if keyboardState == 0 {
                        Group {
                            if capsLockIsOn {
                                Image(systemName: "capslock.fill")
                            } else if letterIsCapital {
                                Image(systemName: "shift.fill")
                            } else {
                                Image(systemName: "shift")
                            }
                        }
                        .font(.footnote)
                        .onTapGesture(count: 2) {
                            capsLockIsOn = true
                            letterIsCapital = true
                        }
                        .onTapGesture {
                            if capsLockIsOn {
                                capsLockIsOn = false
                                letterIsCapital = false
                            } else {
                                letterIsCapital.toggle()
                            }
                        }
                    } else if keyboardState == 1 {
                        Button(action: {
                            keyboardState = 2
                        }, label: {
                            Text("[#+=]")
                                .font(.system(size: 11))
                                .fontDesign(.rounded)
                        })
                    } else if keyboardState == 2 {
                        Button(action: {
                            keyboardState = 1
                        }, label: {
                            Text("[123]")
                                .font(.system(size: 11))
                                .fontDesign(.rounded)
                        })
                    }
                    Spacer()
                }
                ForEach(keys, id: \.self) { key in
                    Button(action: {
                        textField = CepheusKeyboardAddLetter(letterIsCapital ? key.uppercased() : key.lowercased(), textField: textField, cursor: cursor)
                        cursor += 1
                        if letterIsCapital && !capsLockIsOn {
                            letterIsCapital = false
                        }
                        if language == "zh-hans-pinyin" {
                            if pinyinLocation == -1 {
                                pinyinLocation = cursor
                            }
                            inputPinyin = CepheusKeyboardAddLetter(key, textField: inputPinyin, cursor: cursor-pinyinLocation)
                        }
                    }, label: {
                        if letterIsCapital { //If uppercased, then letters will be displayed in capital.
                            Text(key)
                                .textCase(.uppercase)
                        } else { //If not, lowercase.
                            Text(key)
                                .textCase(.lowercase)
                        }
                    })
                    .frame(width: screenWidth/keySpaceDividedNumber)
                }
                if isLastRow {
                    Spacer()
                    if keyboardState == 0 {
                        Button(action: {
                            keyboardState = 1
                        }, label: {
                            Text("[123]")
                                .font(.system(size: 11))
                                .fontDesign(.rounded)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5) // EDITED - 2lines - Fix 41mm line break
                        })
                    } else if keyboardState == 1 {
                        Button(action: {
                            keyboardState = 0
                        }, label: {
                            Text("[ABC]")
                                .font(.system(size: 11))
                                .fontDesign(.rounded)
                        })
                    } else if keyboardState == 2 {
                        Button(action: {
                            keyboardState = 0
                        }, label: {
                            Text("[ABC]")
                                .font(.system(size: 11))
                                .fontDesign(.rounded)
                        })
                    }
                }
            }
        }
    }
    func CepheusKeyboardAddLetter(_ letter: String, textField: String, cursor: Int) -> String {
        var singleLetters: [Character] = []
        for letter in textField {
            singleLetters.append(letter)
        }
        if cursor >= 0 {
            singleLetters.insert(Character(letter), at: cursor)
        }
        return singleLetters.map{String($0)}.joined()
    }
}

struct CepheusKeyboardLanguagePickerView: View {
    let languageCodes = ["en-qwerty", "zh-hans-pinyin"]
    let languageIcons = ["en-qwerty": "En", "zh-hans-pinyin": "拼"]
    let languageNames: [String: LocalizedStringResource] = ["en-qwerty": LocalizedStringResource("Language.english", bundle: .module), "zh-hans-pinyin": LocalizedStringResource("Language.chinese-simplified", bundle: .module)]
    let languageFootnotes: [String: LocalizedStringResource] = ["en-qwerty": LocalizedStringResource("Language.footnote.qwerty", bundle: .module), "zh-hans-pinyin": LocalizedStringResource("Language.footnote.pinyin", bundle: .module)]
    let languageTypes = ["en-qwerty": "Latin", "zh-hans-pinyin": "CJK"]
    @Binding var language: String
    @Binding var textField: String
    @Binding var cursor: Int
    @Environment(\.dismiss) var dismiss
    var languageDisallowRules: String = "none"
    var body: some View {
        if #available(watchOS 10.0, *) {
            List {
                ForEach(languageCodes, id: \.self) { singleLanguage in
                    if shouldDispalyLanguage(language: singleLanguage, rules: languageDisallowRules) {
                        Button(action: {
                            language = singleLanguage
                            dismiss()
                        }, label: {
                            HStack {
                                Text(languageIcons[singleLanguage] ?? "Aa")
                                    .font(.system(size: 20))
                                    .foregroundStyle(.tint)
                                    .fontDesign(.rounded)
                                VStack(alignment: .leading) {
                                    Text(languageNames[singleLanguage] ?? "Unknown")
                                    Text(languageFootnotes[singleLanguage] ?? "\(language)")
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                if language == singleLanguage {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.tint)
                                }
                            }
                        })
                    }
                }
                if languageDisallowRules == "deny-all" {
                    Text("Language.none-available", bundle: .module)
                        .foregroundStyle(.secondary)
                }
                TextFieldLink(prompt: Text("Languange.use-system-keyboard.prompt", bundle: .module), label: {
                    HStack {
                        Image(systemName: "keyboard")
                            .font(.system(size: 20))
                            .foregroundStyle(.tint)
                            .fontDesign(.rounded)
                        VStack(alignment: .leading) {
                            Text("Language.use-system-keyboard", bundle: .module)
                        }
                    }
                }, onSubmit: { output in
                    textField = CepheusKeyboardAddLetter(output, textField: textField, cursor: cursor)
                    //          textField = output
                })
            }
            .navigationTitle(Text("Language.title", bundle: .module))
        }
    }
    func shouldDispalyLanguage(language: String, rules: String) -> Bool {
        if rules == "none" {
            return true
        } else if rules == "deny-all" {
            return false
        } else {
            if language == "en-qwerty" && rules.contains("only-English") {
                return true
            } else if languageTypes[language] == "Latin" {
                if rules.contains("deny-Latin") {
                    return false
                } else {
                    return true
                }
            } else if languageTypes[language] == "CJK" {
                if rules.contains("deny-CJK") {
                    return false
                } else {
                    return true
                }
            } else {
                return true
            }
        }
    }
}

func CepheusKeyboardAddLetter(_ letter: String, textField: String, cursor: Int) -> String {
    var singleLetters: [Character] = []
    var inputLetters: [Character] = []
    for i in textField {
        singleLetters.append(i)
    }
    for i in letter {
        inputLetters.append(i)
    }
    //  praint(singleLetters)
    for i in 0..<inputLetters.count {
        singleLetters.insert(inputLetters[i], at: cursor+i)
        //    praint(singleLetters)
    }
    return singleLetters.map{String($0)}.joined()
}

func CepheusKeyboardLettersToDots(_ letters: String) -> String {
    var output = ""
    for _ in letters {
        output.append("●")
    }
    return output
}

let emojiSymbol = "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"
