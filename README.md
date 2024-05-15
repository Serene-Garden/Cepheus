# Cepheus
A powerful watchOS full-keyboard.

![:name](https://count.getloli.com/get/@Garden785-Cepheus?theme=rule34)

As the release of Apple Watch Series 7, full-keyboard seems to be quite useless. But old series such as Series 5 or SEs are still unable to type freely.

We developed Cepheus, allowing all users to type with a full-keyboard.

## Features
- Basics
  - Able to enter Latin letters, Arabic letters and symbols.
  - Elegant interface makes Cepheus beauty while still useful.
  - Supports Shift & Caps Lock key which allows capital letters to be typed in.
  - System keyboard is still accessable.
- Emojis
  - Review in lists that helps preview to be quick.
  - Review in groups and subgroups helps users to find the emoji simply.
  - Recent Usage are collected and can be easily accessed.
  - Text field also editable when emoji keyboard is displayed.
- Chinese Pinyin
  - Around 8,453 characters collected for pinyin type-in.
  - Safe Insert make sure indexes will not be out of arrays.
  - Input ignorable allows users to type in Latin letters.
  - Full-sized chinese punctuations are supported in keyboard.

## Requirements

You are responsible for adding one of the following description to your App, where ever it is as long as it could be found.

Just one of them.

> Powered by Cepheus

> Powered by Garden Cepheus

> Powered by Cepheus Keyboard


## Parameters
```swift
CepheusKeyboard(input: $input,
                        prompt: "Email Address",
                        CepheusIsEnabled: true,
                        defaultLanguage: "en-qwerty",
                        languageDisallowRules: "none",
                        allowEmojis: true,
                        isSecure: false,
                        displayingSecureTextIsAllowed: true,
                        autoCorrectionIsEnable: false,
                        onSubmit: {
          print("Email Address Submitted")
        })
```

### input
`input: Binding<String>` indicates what the input text is.

### prompt
`prompt: LocalizedStringResource` tells users what the text field is.

Prompt will be displayed on the text-edit field and the link when the input is empty.

Default as `LocalizedStringResource("Cepheus.prompt", bundle: .atURL(Bundle.module.bundleURL))`.

### CepheusIsEnabled
`CepheusIsEnabled: Bool` could be toggled if you want to give options to users if they use Cepheus Keyboard or not.

If this is set to `false`, then Cepheus Keyboard goes into normal `TextField` or `SecureField` from SwiftUI.

Default as `true`.

### dafaultLanguage
`defaultLanguage: String` is useful when you expected the keyboard to have a specific default language.

This determines the default language for the keyboard.

Default as `en-qwerty`.

Other available value: `"zh-hans-pinyin"`.

### languageDisallowRules
`languageDisallowRules: String` limits the selections of languages.

This changes which type of language can & can’t users select.

Default as `"none"`

Other available values: `"deny-all"``"deny-Latin"``"deny-CJK"``"English-only"`

### allowEmojis
`allowEmojis: Bool` indicates if emojis are allowed.

Default as `true`

### isSecure
`isSecure: Bool` indicates if the keyboard is used for typing privacy-sensitive contents.

When set to `true`, the keyboard will goes like `secureField`. `allowEmojis` is ignored and will always not allow emojis.

When Cepheus is disabled, the keyboard will becamse `secureField` instead of typical `textField`.

Default as `false`

### displayingSecureTextIsAllowed
`displayingSecureTextIsAllowed: Bool` determines if the eye icon before backspace will be displayed or not.

Tapping the icon will toggle the text between hidden and readable status.

When `false`, there will be no eye icon and the text will be hidden. This parameter is meaningless when `isSecure` is `false`.

Default as `true`

### autoCorrectionIsEnabled
`autoCorrectionIsEnabled: Bool` determines if autocorrection is allowed.

Since Cepheus doesn't provide autocorrection, so this parameter is only meaningful when `CepheusIsEnabled` is `false`.

Default as `true`

### onSubmit
`onSubmit: () -> Void` receives actions and will be run when Confirm is pressed.

This works like `onSubmit` in the native SwiftUI.

Default as `{}` (runs nothing when submit)

## Credits
**ThreeManager785**
- Develop
- Data Collection
- Design

**WindowsMEMZ**
- Chinese Dictionary Sorting
- Debug
- Inspiration

**Linecom**
- Feedbacks

**Captain Log**
- Chinese Character List in Frequency
> 转自船长日志, 本文链接地址: http://www.cslog.cn/Content/word-frequency-list-of-chinese/

## Privacy
Cepheus collects emojis that are recently used.

No any other datas are collected. No data are shared or uploaded to neither other devices nor the Internet.

Cepheus won't be able to know what you've typed.

## Links

https://youtu.be/KvmheS6RhJw

https://www.bilibili.com/video/BV1aw4m1X7m9/?spm_id_from=..search-card.all.click&vd_source=56037b56048bedd71c28cd497f5de805

