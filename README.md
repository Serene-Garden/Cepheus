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

## Parameters
```swift
CepheusKeyboard(input: $input,
                        prompt: "Email Address",
                        CepheusIsEnabled: true,
                        style: "field"
                        defaultLanguage: "en-qwerty",
                        languageDisallowRules: "none",
                        allowEmojis: true,
                        isSecure: false,
                        displayingSecureTextIsAllowed: true,
                        autoCorrectionIsEnable: false,
                        aboutLinkIsHidden: false,
                        onSubmit: {
                          print("Email Address Submitted")
                        }, label: {
                          Label("Cepheus Keyboard", systemImage: "keyboard")
})
```

### input
`input: Binding<String>` indicates what the input text is.

### prompt
`prompt: LocalizedStringResource` tells users what the text field is.

Prompt will be displayed on the text-edit field (when `style` is `field`) and the link when the input is empty.

Default as `LocalizedStringResource("Cepheus.prompt", bundle: .atURL(Bundle.module.bundleURL))`.

### CepheusIsEnabled
`CepheusIsEnabled: Bool?` could be toggled if you want to force Cepheus keyboard to be used or not.

This value is not recommened to be used in normal usage, since Cepheus will handle if it should be used by itself.

If this is set to `false`, then Cepheus Keyboard goes into normal `TextField` or `SecureField` from SwiftUI.

`nil` make Cepheus handle whether it should be used or not.

Default as `nil`.

### style
`style: String` is a vital parameter when you wish to have different ways to use keyboard.

- `"field"` is like vanilla SwiftUI `TextField`, pops up in a sheet, displays `prompt` when empty, and shows `input` when there's something.
- `"link"` is still a sheet while its apprearence depends on `label`.
- `"page"` is a `NavigationLink` which links to a new page for typing, using `label` as its apprearence.
- `"field-page"` mixed `"field"`'s appearence and  `"page"`'s interaction, which means it shows as field and navigates to a new page for the keyboard.
- `direct` shows the keyboard itself directly without any interactions.

Default as `"field"`.

Other available value: `"link"``"page"``"field-page"``"direct"`.

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

### aboutLinkIsHidden
`aboutLinkIsHidden: Bool` affects the language sheet, determine if the About link in it will be hidden or not.

Please use `CephuesSettings()` to add a link to the About page if you hide it.

Default as `false`

### autoCorrectionIsEnabled
`autoCorrectionIsEnabled: Bool` determines if autocorrection is allowed.

Since Cepheus doesn't provide autocorrection, so this parameter is only meaningful when `CepheusIsEnabled` is `false`.

Default as `true`

### onSubmit
`onSubmit: () -> Void` receives actions and will be run when Confirm is pressed.

This works like `onSubmit` in the native SwiftUI.

Default as `{}` (runs nothing when submit)

### label
`label: @escaping () -> L = {Text("Cepheus Keyboard")}` determine the appearence of the keyboard button.

It reacives a view and is used when `style` is `"link"` or `"page"`.

Default as `{Text("Cepheus Keyboard")}`

## Requirements
### Declarement
You are responsible for adding one of the following description to your app, where ever it is as long as it could be found.

Just one of them.

> Powered by Cepheus

> Powered by Garden Cepheus

> Powered by Cepheus Keyboard

If Cepheus is unable to be enabled, such as watchOS 9, then this text could be removed.

### About
`CepheusSettingsView()` could be called simply. We recommend to put this somewhere in the your app settings.

This is optional, which means you could not show this. 

`CepheusCreditView()` is also available if you wanted to call it.

We do not wish you to remove credit from the source code. (*You could remove if you really wanna do that.*)

## Other Available Structures
### CepheusEnablingToggle
`CepheusEnablingToggle: View` only gives a toggle, which allows users to choose if they want to use Cepheus or not.

Add paramter `showSymbol: Bool` to show symbol for the toggle.

When Cepheus is called for the first time, Cepheus will disable itself when the device size is 41mm, 44mm or 49mm (which supports native full-keyboard).

Developers should make toggle its availablity `@AppStorage("internalCepheusIsEnabled")`. 

(Please hide the toggle in watchOS 9 cause it's meaningless.)

When parameter `CepheusIsEnabled` is given, Cepheus use this value first.

When system number is under 10, Cepheus never toggles.

### CepheusSettingsView
`CepheusEnablingToggle: View` is the same view as where the "about" link in the language sheet takes you to.


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

**Every Developer & User**
- Really appreaciate for every developer supporing Cepheus, thank you for your patient reading README and using Cepheus.
- And appreaciate for users, which gives me confident to do development further. 

## Privacy
Cepheus collects emojis that are recently used and could be turned off manually.

No any other datas are collected. No data are shared or uploaded to neither other devices nor the Internet.

Cepheus won't be able to know what you've typed.

## Links

https://youtu.be/KvmheS6RhJw

https://www.bilibili.com/video/BV1aw4m1X7m9/?spm_id_from=..search-card.all.click&vd_source=56037b56048bedd71c28cd497f5de805

