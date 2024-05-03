# Cepheus
A powerful watchOS full-keyboard.

![:name](https://count.getloli.com/get/@Garden785-Cepheus?theme=rule34)

As the release of Apple Watch Series 7, full-keyboard seems to be quite useless. But old series such as Series 5 or SEs are still unable to type freely.

We developed Cepheus, allowing all users to type with a full-keyboard.

It supports English and Simplified Chinese Pinyin.

Watch our video to learn more.

https://youtu.be/KvmheS6RhJw

https://www.bilibili.com/video/BV1aw4m1X7m9/?spm_id_from=..search-card.all.click&vd_source=56037b56048bedd71c28cd497f5de805

## Aspects
```swift
CepheusKeyboard(input: $input,
                        prompt: "Email Address",
                        CepheusIsEnabled: true,
                        defaultLanguage: "en-qwerty",
                        languageDisallowRules: "deny-all",
                        allowEmojis: true,
                        isSecure: false,
                        displayingSecureTextIsAllowed: false)
```

### input
`input: String` 
