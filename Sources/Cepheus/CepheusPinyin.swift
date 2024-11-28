//
//  ContentView.swift
//  Cepheus Watch App
//
//  Created by 雷美淳 on 2024/4/11.
//

import SwiftUI

//struct PinyinGroupingView: View {
//  @State var input: String = "" //The input where the pinyin goes in
//  @State var output: [String] = [] //The seperated pinyin in string array
//
//  var body: some View {
//    List {
//      TextField("Input", text: $input)
//        .autocorrectionDisabled()
//        .onChange(of: input) {
//          output = groupedPinyin(input: input)
//        }
//      Text("\(output)")
//    }
//  }
//}

struct CepheusPiyin: View {
  //Isolation
  //Pinyin sorted alphabetical, characters sorted in frequentation
  //Add characters to this dictionary if you want
  //Total of 8453 characters
  private let CepheusPinyinDictionary: [String: [String]] = {
    NSDictionary(contentsOf: Bundle.module.url(forResource: "PinyinDictionary", withExtension: "plist")!)! as! [String: [String]]
  }()
  //Isolation
  
  @Binding var input: String //TEXTFIELD
  @Binding var inputPinyin: String
  @Binding var pinyinLocation: Int
  @Binding var cursor: Int
  @State var seperatedPinyin: [String] = []
  @State var onFocusPinyinSyllable = ""
  @State var pinyinTab = 0
  var body: some View {
    if #available(watchOS 10.0, *) {
      HStack {
        if !onFocusPinyinSyllable.isEmpty {
          HStack {
            if pinyinTab > 0 {
              Button(action: {
                pinyinTab -= 1
              }, label: {
                Image(systemName: "chevron.compact.left")
                  .padding(.trailing, 5)
              })
            }
            Spacer()
            ForEach(pinyinTab*6..<pinyinTab*6+6, id: \.self) { character in
              Button(action: {
                for i in 0..<onFocusPinyinSyllable.count {
                  if i != 0 {
                    cursor -= 1
                  }
                  inputPinyin = backspace(textField: inputPinyin, cursor: 1)
                  input = backspace(textField: input, cursor: pinyinLocation)
                }
                input = CepheusKeyboardAddLetter((arraySafeAccess(CepheusPinyinDictionary[onFocusPinyinSyllable] ?? [onFocusPinyinSyllable], element: character) ?? invalidPinyinReturn(onFocusPinyinSyllable, character: character)) as! String, textField: input, cursor: pinyinLocation-1)
//                praint((arraySafeAccess(CepheusPinyinDictionary[onFocusPinyinSyllable] ?? [onFocusPinyinSyllable], element: character) ?? invalidPinyinReturn(onFocusPinyinSyllable, character: character)) as! String)
//                praint(CepheusKeyboardAddLetter((arraySafeAccess(CepheusPinyinDictionary[onFocusPinyinSyllable] ?? [onFocusPinyinSyllable], element: character) ?? invalidPinyinReturn(onFocusPinyinSyllable, character: character)) as! String, textField: input, cursor: pinyinLocation-1))
                pinyinLocation += ((arraySafeAccess(CepheusPinyinDictionary[onFocusPinyinSyllable] ?? [onFocusPinyinSyllable], element: character) ?? invalidPinyinReturn(onFocusPinyinSyllable, character: character)) as! String).count
                cursor += ((arraySafeAccess(CepheusPinyinDictionary[onFocusPinyinSyllable] ?? [onFocusPinyinSyllable], element: character) ?? invalidPinyinReturn(onFocusPinyinSyllable, character: character)) as! String).count - 1
              }, label: {
                Text((arraySafeAccess(CepheusPinyinDictionary[onFocusPinyinSyllable] ?? [onFocusPinyinSyllable], element: character) ?? invalidPinyinReturn(onFocusPinyinSyllable, character: character)) as! String)
                  .padding(.horizontal, 1)
              })
              .opacity((arraySafeAccess(CepheusPinyinDictionary[onFocusPinyinSyllable] ?? [onFocusPinyinSyllable], element: character) == nil) ? 0 : 1)
              .disabled(arraySafeAccess(CepheusPinyinDictionary[onFocusPinyinSyllable] ?? [onFocusPinyinSyllable], element: character) == nil)
            }
            Spacer()
            if pinyinTab < Int((CepheusPinyinDictionary[onFocusPinyinSyllable] ?? ["？"]).count/6) {
              Button(action: {
                pinyinTab += 1
              }, label: {
                Image(systemName: "chevron.compact.right")
                  .padding(.leading, 5)
              })
            }
          }
        } else {
          Text(String("等待拼音"))
            .foregroundStyle(.secondary)
          Spacer()
        }
      }
      .onChange(of: inputPinyin) {
        seperatedPinyin = groupedPinyin(input: inputPinyin)
        onFocusPinyinSyllable = (arraySafeAccess(seperatedPinyin, element: 0) ?? "") as! String
        //        print(inputPinyin)
      }
      .onChange(of: seperatedPinyin) {
        pinyinTab = 0
      }
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
  func invalidPinyinReturn(_ input: String, character: Int) -> String {
    if CepheusPinyinDictionary[input] != nil {
      return "？"
    } else {
      if character == 0 {
        return input
      } else {
        return "？"
      }
    }
  }
}

func groupedPinyin(input: String) -> [String] {
  var letters: [String] = [] //The seperated letters, one by one
  var shouldLetterBeSkipped: [Bool] = [] //This determines if it will be count as a new syllable.
  var syllable = "" //A single syllable and will be added to the output when process finished.
  var output: [String] = [] //Final return variables
  letters = []
  shouldLetterBeSkipped = []
  for letter in input {
    letters.append(String(letter).lowercased())
  } //Breaks the pinyin into single letters.
  shouldLetterBeSkipped = Array(repeating: false, count: letters.count) //Initialize the array for skipping letters, length as same as the letter counts.
  for composerCursor in 0..<letters.count { //Check the syllables
    if !shouldLetterBeSkipped[composerCursor] { //The letter should be skipped if it's not the first letter in a syllable.
      syllable = "" //Initialize syllable for a new syllable
      switch letters[composerCursor] { //Check the first letter of syllable
      case "a":
        syllable = a_ability(letters, cursor: composerCursor)
      case "b":
        syllable = "b" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "ei": true, "en": true, "eng": true, "i": true, "ian": true, "iao": true, "ie": true, "in": true, "ing": true, "o": true, "u": true])
      case "c":
        if (arraySafeAccess(letters, element: composerCursor+1) ?? "") as! String == "h" {
          syllable = "ch" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "en": true, "eng": true, "i": true, "ong": true, "ou": true, "u": true, "ua": true, "uai": true, "uan": true, "uang": true, "ui": true, "un": true, "uo": true], isSyllableDoubleLetter: true)
        } else {
          syllable = "c" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "en": true, "eng": true, "i": true, "ong": true, "ou": true, "u": true, "uan": true, "ui": true, "un": true, "uo": true])
        }
      case "d":
        syllable = "d" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "i": true, "ian": true, "iang": true, "iao": true, "ie": true, "ing": true, "iu": true, "ong": true, "ou": true, "u": true, "uan": true, "ui": true, "un": true, "uo": true])
      case "e":
        syllable = e_ability(letters, cursor: composerCursor, allow_eng: false)
      case "f":
        syllable = "f" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "an": true, "ang": true, "ei": true, "en": true, "eng": true, "o": true, "ou": true, "u": true])
      case "g":
        syllable = "g" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "ong": true, "ou": true, "u": true, "ua": true, "uai": true, "uan": true, "uang": true, "uo": true, "un": true])
      case "h":
        syllable = "h" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "ong": true, "ou": true, "u": true, "ua": true, "uai": true, "uan": true, "uang": true, "ui": true, "un": true, "uo": true])
      case "i":
        syllable = "i"
      case "j":
        syllable = "j" + connectVowels(letters, cursor: composerCursor, allowments: ["i": true, "ia": true, "ian": true, "iang": true, "iao": true, "ie": true, "in": true, "ing": true, "iong": true, "iu": true, "u": true, "uan": true, "ue": true, "un": true])
      case "k":
        syllable = "k" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "ong": true, "ou": true, "u": true, "ua": true, "uai": true, "uan": true, "uang": true, "ui": true, "un": true, "uo": true])
      case "l":
        syllable = "l" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "eng": true, "i": true, "ia": true, "ian": true, "iang": true, "iao": true, "ie": true, "in": true, "ing": true, "iu": true, "o": true, "ong": true, "ou": true, "u": true, "uan": true, "un": true, "uo": true, "v": true, "ve": true])
      case "m":
        syllable = "m" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "i": true, "ian": true, "iao": true, "ie": true, "in": true, "ing": true, "iu": true, "o": true, "ou": true, "u": true])
      case "n":
        syllable = "n" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "i": true, "ia": true, "ian": true, "iang": true, "iao": true, "ie": true, "in": true, "ing": true, "iu": true, "ong": true, "ou": true, "u": true, "uan": true, "un": true, "uo": true, "v": true, "ve": true])
      case "o":
        syllable = o_ability(letters, cursor: composerCursor, allow_ong: false)
      case "p":
        syllable = "p" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "ei": true, "en": true, "eng": true, "i": true, "ian": true, "iao": true, "ie": true, "in": true, "ing": true, "o": true, "ou": true, "u": true])
      case "q":
        syllable = "q" + connectVowels(letters, cursor: composerCursor, allowments: ["i": true, "ia": true, "ian": true, "iang": true, "iao": true, "ie": true, "in": true, "ing": true, "iong": true, "iu": true, "u": true, "uan": true, "ue": true, "un": true])
      case "r":
        syllable = "r" + connectVowels(letters, cursor: composerCursor, allowments: ["an": true, "ang": true, "ao": true, "e": true, "en": true, "eng": true, "i": true, "ong": true, "ou": true, "u": true, "uan": true, "ui": true, "un": true, "uo": true])
      case "s":
        if (arraySafeAccess(letters, element: composerCursor+1) ?? "") as! String == "h" {
          syllable = "sh" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "i": true, "ong": true, "ou": true, "u": true, "ua": true, "uai": true, "uan": true, "uang": true, "ui": true, "un": true, "uo": true], isSyllableDoubleLetter: true)
        } else {
          syllable = "s" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "i": true, "ong": true, "ou": true, "u": true, "uan": true, "ui": true, "un": true, "uo": true])
        }
      case "t":
        syllable = "t" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "eng": true, "i": true, "ian": true, "iao": true, "ie": true, "ing": true, "ong": true, "ou": true, "u": true, "uan": true, "ui": true, "un": true, "uo": true])
      case "u":
        syllable = "u"
      case "v":
        syllable = "v"
      case "w":
        syllable = "w" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ei": true, "en": true, "eng": true, "o": true, "u": true])
      case "x":
        syllable = "x" + connectVowels(letters, cursor: composerCursor, allowments: ["i": true, "ia": true, "ian": true, "iang": true, "iao": true, "ie": true, "in": true, "ing": true, "iong": true, "iu": true, "u": true, "uan": true, "ue": true, "un": true])
      case "y":
        syllable = "y" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "an": true, "ang": true, "ao": true, "e": true, "i": true, "in": true, "ing": true, "ong": true, "ou": true, "u": true, "uan": true, "ue": true, "un": true])
      case "z":
        if (arraySafeAccess(letters, element: composerCursor+1) ?? "") as! String == "h" {
          syllable = "zh" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "i": true, "ong": true, "ou": true, "u": true, "ua": true, "uai": true, "uan": true, "uang": true, "ui": true, "un": true, "uo": true], isSyllableDoubleLetter: true)
        } else {
          syllable = "z" + connectVowels(letters, cursor: composerCursor, allowments: ["a": true, "ai": true, "an": true, "ang": true, "ao": true, "e": true, "ei": true, "en": true, "eng": true, "i": true, "ong": true, "ou": true, "u": true, "uan": true, "ui": true, "un": true, "uo": true])
        }
      default:
        syllable = letters[composerCursor] //Letters out of A-Z or "zh""ch""sh" will be directlly set for a syllable.
      }
      for skippedLetter in 0..<syllable.count {
        shouldLetterBeSkipped[composerCursor+skippedLetter] = true
      }
      if syllable != "'" && syllable != "’" && syllable != "‘" && syllable != " " {
        output.append(syllable)
        //        print(syllable)
      }
    }
  }
  return output
}

func arraySafeAccess(_ array: Array<Any>, element: Int) -> Any? {
  //This function avoids index out of range error when accessing a range.
  //If out, then it will return nil instead of throwing an error.
  //Normally it will just return the content, but in optional.
  if element >= array.count || element < 0 { //Index out of range
    return nil
  } else { //Index in range
    //    print(array)
    //    print(element)
    return array[element]
  }
}

func connectVowels(_ array: Array<Any>, cursor: Int, allowments: [String: Bool], isSyllableDoubleLetter: Bool = false) -> String {
  //This function returns the correct vowel part for a consonant.
  //Cursor should be on the consonant letter.
  //The allowment is a dictionary that tells what vowels are acceptable.
  //If a vowel didn't been marked, it's default value will be false.
  var vowelCursor = 0 //This indicates where the vowels starts, the int means how many letters it should move from consonants to vowels.
  if isSyllableDoubleLetter {
    vowelCursor = cursor+2 //For "zh""ch""sh", their vowels start 2 letters after the first letter.
  } else {
    vowelCursor = cursor+1 //For other single letter consonants, their vowels should only move 1.
  }
  let firstLetter: String = arraySafeAccess(array, element: vowelCursor) as? String ?? "" //The letter after the cursor (a consonant letter)
  switch firstLetter {
  case "a":
    return a_ability(array, cursor: vowelCursor, allow_ai: allowments["ai"] ?? false, allow_ao: allowments["ao"] ?? false, allow_an: allowments["an"] ?? false, allow_ang: allowments["ang"] ?? false)
  case "e":
    return e_ability(array, cursor: vowelCursor, allow_ei: allowments["ei"] ?? false, allow_er: allowments["er"] ?? false, allow_en: allowments["en"] ?? false, allow_eng: allowments["eng"] ?? false)
  case "i":
    return i_ability(array, cursor: vowelCursor,allow_ia: allowments["ia"] ?? false, allow_iao: allowments["iao"] ?? false, allow_ian: allowments["ian"] ?? false, allow_iang: allowments["iang"] ?? false, allow_ie: allowments["ie"] ?? false, allow_iong: allowments["iong"] ?? false, allow_iu: allowments["iu"] ?? false, allow_in: allowments["in"] ?? false, allow_ing: allowments["ing"] ?? false)
  case "o":
    return o_ability(array, cursor: vowelCursor, allow_ou: allowments["ou"] ?? false, allow_ong: allowments["ong"] ?? false)
  case "u":
    return u_ability(array, cursor: vowelCursor, allow_ua: allowments["ua"] ?? false, allow_uai: allowments["uai"] ?? false, allow_uan: allowments["uan"] ?? false, allow_uang: allowments["uang"] ?? false, allow_ue: allowments["ue"] ?? false, allow_ui: allowments["ui"] ?? false, allow_uo: allowments["uo"] ?? false, allow_un: allowments["un"] ?? false)
  case "v":
    return v_ability(array, cursor: vowelCursor, allow_ve: allowments["ve"] ?? false)
  default:
    return ""
  }
}

func a_ability(_ array: Array<Any>, cursor: Int, allow_ai: Bool = true, allow_ao: Bool = true, allow_an: Bool = true, allow_ang: Bool = true) -> String {
  //This checks what the final vowels (staring with "a") will be.
  //Cursor should point to "a".
  //a, ai, ao, an, ang
  let secondLetter: String = arraySafeAccess(array, element: cursor+1) as? String ?? "" //The letter after cursor (a)
  let thirdLetter: String = arraySafeAccess(array, element: cursor+2) as? String ?? "" //The letter after the second one
  switch secondLetter { //Check the second letter in order to confirm what they are
  case "n": //an, ang
    if thirdLetter == "g" { //ang
      if allow_ang {
        return "ang"
      } else if allow_an {
        return "an"
      } else {
        return "a"
      }
    } else {
      if allow_an { //an
        return "an"
      } else {
        return "a"
      }
    }
  case "i": //ai
    if allow_ai {
      return "ai"
    } else {
      return "a"
    }
  case "o": //ao
    if allow_ao {
      return "ao"
    } else {
      return "a"
    }
  default : //a
    return "a"
  }
}

func e_ability(_ array: Array<Any>, cursor: Int, allow_ei: Bool = true, allow_er: Bool = true, allow_en: Bool = true, allow_eng: Bool = true) -> String {
  //This checks what the final vowels (staring with "e") will be.
  //Cursor should point to "e".
  //e, ei, er, en, eng
  let secondLetter: String = arraySafeAccess(array, element: cursor+1) as? String ?? "" //The letter after cursor (e)
  let thirdLetter: String = arraySafeAccess(array, element: cursor+2) as? String ?? "" //The letter after the second one
  switch secondLetter { //Check the second letter in order to confirm what they are
  case "i": //ei
    if allow_ei {
      return "ei"
    } else {
      return "e"
    }
  case "r": //er
    if allow_er {
      return "er"
    } else {
      return "e"
    }
  case "n": //en, eng
    if thirdLetter == "g" { //eng
      if allow_eng {
        return "eng"
      } else if allow_en {
        return "en"
      } else {
        return "e"
      }
    } else { //en
      if allow_en {
        return "en"
      } else {
        return "e"
      }
    }
  default : //e
    return "e"
  }
}

func i_ability(_ array: Array<Any>, cursor: Int, allow_ia: Bool = true, allow_iao: Bool = true, allow_ian: Bool = true, allow_iang: Bool = true, allow_ie: Bool = true, allow_iong: Bool = true, allow_iu: Bool = true, allow_in: Bool = true, allow_ing: Bool = true) -> String {
  //This checks what the final vowels (staring with "i") will be.
  //Cursor should point to "i".
  //i, ia, iao, ian, iang, ie, iong, iu, in, ing
  let secondLetter: String = arraySafeAccess(array, element: cursor+1) as? String ?? "" //The letter after cursor (i)
  let thirdLetter: String = arraySafeAccess(array, element: cursor+2) as? String ?? "" //The letter after the second one
  let fourthLetter: String = arraySafeAccess(array, element: cursor+3) as? String ?? "" //The letter after the third one
  switch secondLetter { //Check the second letter in order to confirm what they are
  case "a": //ia, iao, ian, iang
    if thirdLetter == "o" { //iao
      if allow_iao {
        return "iao"
      } else if allow_ia {
        return "ia"
      } else {
        return "i"
      }
    } else if thirdLetter == "n" { //ian, iang
      if fourthLetter == "g" { //iang
        if allow_ing {
          return "iang"
        } else if allow_ian {
          return "ian"
        } else if allow_ia {
          return "ia"
        } else {
          return "i"
        }
      } else { //ian
        if allow_ian {
          return "ian"
        } else if allow_ia {
          return "ia"
        } else {
          return "i"
        }
      }
    } else { //ia
      if allow_ia {
        return "ia"
      } else {
        return "i"
      }
    }
  case "e": //ie
    if allow_ie {
      return "ie"
    } else {
      return "i"
    }
  case "o": //iong
    if thirdLetter == "n" && fourthLetter == "g" {
      if allow_iong {
        return "iong"
      } else {
        return "i"
      }
    } else {
      return "i"
    }
  case "u": //iu
    if allow_iu {
      return "iu"
    } else {
      return "i"
    }
  case "n":
    if thirdLetter == "g" { //ing
      if allow_ing {
        return "ing"
      } else if allow_in {
        return "in"
      } else {
        return "i"
      }
    } else { //in
      if allow_in {
        return "in"
      } else {
        return "i"
      }
    }
  default: //i
    return "i"
  }
}

func o_ability(_ array: Array<Any>, cursor: Int, allow_ou: Bool = true, allow_ong: Bool = true) -> String {
  //This checks what the final vowels (staring with "o") will be.
  //Cursor should point to "o".
  //o, ou, ong
  let secondLetter: String = arraySafeAccess(array, element: cursor+1) as? String ?? "" //The letter after cursor (o)
  let thirdLetter: String = arraySafeAccess(array, element: cursor+2) as? String ?? "" //The letter after the second one
  switch secondLetter { //Check the second letter in order to confirm what they are
  case "u": //ou
    if allow_ou {
      return "ou"
    } else {
      return "o"
    }
  case "n": //ong
    if thirdLetter == "g" { //ong
      if allow_ong {
        return "ong"
      } else {
        return "o"
      }
    } else {
      return "o"
    }
  default : //o
    return "o"
  }
}

func u_ability(_ array: Array<Any>, cursor: Int, allow_ua: Bool = true, allow_uai: Bool = true, allow_uan: Bool = true, allow_uang: Bool = true, allow_ue: Bool = true, allow_ui: Bool = true, allow_uo: Bool = true, allow_un: Bool = true) -> String {
  //This checks what the final vowels (staring with "u") will be.
  //Cursor should point to "u".
  //u, ua, uai, uan, uang, ue, ui, uo, un
  let secondLetter: String = arraySafeAccess(array, element: cursor+1) as? String ?? "" //The letter after cursor (u)
  let thirdLetter: String = arraySafeAccess(array, element: cursor+2) as? String ?? "" //The letter after the second one
  let fourthLetter: String = arraySafeAccess(array, element: cursor+3) as? String ?? "" //The letter after the third one
  switch secondLetter { //Check the second letter in order to confirm what they are
  case "a": //ua, uai, uan
    if thirdLetter == "i" { //uai
      if allow_uai {
        return "uai"
      } else if allow_ua {
        return "ua"
      } else {
        return "u"
      }
    } else if thirdLetter == "n" { //uan, uang
      if fourthLetter == "g" { //uang
        if allow_uang {
          return "uang"
        } else if allow_uan {
          return "uan"
        } else if allow_ua {
          return "ua"
        } else {
          return "u"
        }
      } else { //uan
        if allow_uan {
          return "uan"
        } else if allow_ua {
          return "ua"
        } else {
          return "u"
        }
      }
    } else { //ua
      if allow_ua {
        return "ua"
      } else {
        return "u"
      }
    }
  case "e": //ue
    if allow_ue {
      return "ue"
    } else {
      return "u"
    }
  case "i": //ui
    if allow_ui {
      return "ui"
    } else {
      return "u"
    }
  case "o": //uo
    if allow_uo {
      return "uo"
    } else {
      return "u"
    }
  case "n": //un
    if allow_un {
      return "un"
    } else {
      return "u"
    }
  default : //u
    return "u"
  }
}

func v_ability(_ array: Array<Any>, cursor: Int, allow_ve: Bool = true) -> String {
  //This checks what the final vowels (staring with "v") will be.
  //Cursor should point to "v".
  //v, ve
  let secondLetter: String = arraySafeAccess(array, element: cursor+1) as? String ?? "" //The letter after cursor (v)
  switch secondLetter { //Check the second letter in order to confirm what they are
  case "e": //ve
    if allow_ve {
      return "ve"
    } else {
      return "v"
    }
  default: //v
    return "v"
  }
}
