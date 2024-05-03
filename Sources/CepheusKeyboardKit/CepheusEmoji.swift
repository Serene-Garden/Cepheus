//
//  emojiView.swift
//  Cepheus Watch App
//
//  Created by 雷美淳 on 2024/4/15.
//

import SwiftUI

struct CepheusKeyboardEmojiView: View {
  
  //Isolation
  //Don't do structure modifications without safety protection.
  //Better update via automatic programms
  private let cepheusEmojiDictionary: [Int: [Int: [String]]] = [1: [1: ["😀", "😃", "😄", "😁", "😆", "😅", "🤣", "😂", "🙂", "🙃", "🫠", "😉", "😊", "😇"], 2: ["🥰", "😍", "🤩", "😘", "😗", "☺️", "😚", "😙", "🥲"], 3: ["😋", "😛", "😜", "🤪", "😝", "🤑"], 4: ["🤗", "🤭", "🫢", "🫣", "🤫", "🤔", "🫡"], 5: ["🤐", "🤨", "😐", "😑", "😶", "🫥", "😶‍🌫️", "😏", "😒", "🙄", "😬", "😮‍💨", "🤥", "🫨", "🙂‍↔️", "🙂‍↕️"], 6: ["😌", "😔", "😪", "🤤", "😴"], 7: ["😷", "🤒", "🤕", "🤢", "🤮", "🤧", "🥵", "🥶", "🥴", "😵", "😵‍💫", "🤯"], 8: ["🤠", "🥳", "🥸"], 9: ["😎", "🤓", "🧐"], 10: ["😕", "🫤", "😟", "🙁", "☹️", "😮", "😯", "😲", "😳", "🥺", "🥹", "😦", "😧", "😨", "😰", "😥", "😢", "😭", "😱", "😖", "😣", "😞", "😓", "😩", "😫", "🥱"], 11: ["😤", "😡", "😠", "🤬", "😈", "👿", "💀", "☠️"], 12: ["💩", "🤡", "👹", "👺", "👻", "👽", "👾", "🤖"], 13: ["😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾"], 14: ["🙈", "🙉", "🙊"], 15: ["💌", "💘", "💝", "💖", "💗", "💓", "💞", "💕", "💟", "❣️", "💔", "❤️‍🔥", "❤️‍🩹", "❤️", "🩷", "🧡", "💛", "💚", "💙", "🩵", "💜", "🤎", "🖤", "🩶", "🤍"], 16: ["💋", "💯", "💢", "💥", "💫", "💦", "💨", "🕳️", "💬", "👁️‍🗨️", "🗨️", "🗯️", "💭", "💤"]], 2: [1: ["👋", "🤚", "🖐️", "✋", "🖖", "🫱", "🫲", "🫳", "🫴", "🫷", "🫸"], 2: ["👌", "🤌", "🤏", "✌️", "🤞", "🫰", "🤟", "🤘", "🤙"], 3: ["👈", "👉", "👆", "🖕", "👇", "☝️", "🫵"], 4: ["👍", "👎", "✊", "👊", "🤛", "🤜"], 5: ["👏", "🙌", "🫶", "👐", "🤲", "🤝", "🙏"], 6: ["✍️", "💅", "🤳"], 7: ["💪", "🦾", "🦿", "🦵", "🦶", "👂", "🦻", "👃", "🧠", "🫀", "🫁", "🦷", "🦴", "👀", "👁️", "👅", "👄", "🫦"], 8: ["👶", "🧒", "👦", "👧", "🧑", "👱", "👨", "🧔", "🧔‍♂️", "🧔‍♀️", "👨‍🦰", "👨‍🦱", "👨‍🦳", "👨‍🦲", "👩", "👩‍🦰", "🧑‍🦰", "👩‍🦱", "🧑‍🦱", "👩‍🦳", "🧑‍🦳", "👩‍🦲", "🧑‍🦲", "👱‍♀️", "👱‍♂️", "🧓", "👴", "👵"], 9: ["🙍", "🙍‍♂️", "🙍‍♀️", "🙎", "🙎‍♂️", "🙎‍♀️", "🙅", "🙅‍♂️", "🙅‍♀️", "🙆", "🙆‍♂️", "🙆‍♀️", "💁", "💁‍♂️", "💁‍♀️", "🙋", "🙋‍♂️", "🙋‍♀️", "🧏", "🧏‍♂️", "🧏‍♀️", "🙇", "🙇‍♂️", "🙇‍♀️", "🤦", "🤦‍♂️", "🤦‍♀️", "🤷", "🤷‍♂️", "🤷‍♀️"], 10: ["🧑‍⚕️", "👨‍⚕️", "👩‍⚕️", "🧑‍🎓", "👨‍🎓", "👩‍🎓", "🧑‍🏫", "👨‍🏫", "👩‍🏫", "🧑‍⚖️", "👨‍⚖️", "👩‍⚖️", "🧑‍🌾", "👨‍🌾", "👩‍🌾", "🧑‍🍳", "👨‍🍳", "👩‍🍳", "🧑‍🔧", "👨‍🔧", "👩‍🔧", "🧑‍🏭", "👨‍🏭", "👩‍🏭", "🧑‍💼", "👨‍💼", "👩‍💼", "🧑‍🔬", "👨‍🔬", "👩‍🔬", "🧑‍💻", "👨‍💻", "👩‍💻", "🧑‍🎤", "👨‍🎤", "👩‍🎤", "🧑‍🎨", "👨‍🎨", "👩‍🎨", "🧑‍✈️", "👨‍✈️", "👩‍✈️", "🧑‍🚀", "👨‍🚀", "👩‍🚀", "🧑‍🚒", "👨‍🚒", "👩‍🚒", "👮", "👮‍♂️", "👮‍♀️", "🕵️", "🕵️‍♂️", "🕵️‍♀️", "💂", "💂‍♂️", "💂‍♀️", "🥷", "👷", "👷‍♂️", "👷‍♀️", "🫅", "🤴", "👸", "👳", "👳‍♂️", "👳‍♀️", "👲", "🧕", "🤵", "🤵‍♂️", "🤵‍♀️", "👰", "👰‍♂️", "👰‍♀️", "🤰", "🫃", "🫄", "🤱", "👩‍🍼", "👨‍🍼", "🧑‍🍼"], 11: ["👼", "🎅", "🤶", "🧑‍🎄", "🦸", "🦸‍♂️", "🦸‍♀️", "🦹", "🦹‍♂️", "🦹‍♀️", "🧙", "🧙‍♂️", "🧙‍♀️", "🧚", "🧚‍♂️", "🧚‍♀️", "🧛", "🧛‍♂️", "🧛‍♀️", "🧜", "🧜‍♂️", "🧜‍♀️", "🧝", "🧝‍♂️", "🧝‍♀️", "🧞", "🧞‍♂️", "🧞‍♀️", "🧟", "🧟‍♂️", "🧟‍♀️", "🧌"], 12: ["💆", "💆‍♂️", "💆‍♀️", "💇", "💇‍♂️", "💇‍♀️", "🚶", "🚶‍♂️", "🚶‍♀️", "🚶‍➡️", "🚶‍♀️‍➡️", "🚶‍♂️‍➡️", "🧍", "🧍‍♂️", "🧍‍♀️", "🧎", "🧎‍♂️", "🧎‍♀️", "🧎‍➡️", "🧎‍♀️‍➡️", "🧎‍♂️‍➡️", "🧑‍🦯", "🧑‍🦯‍➡️", "👨‍🦯", "👨‍🦯‍➡️", "👩‍🦯", "👩‍🦯‍➡️", "🧑‍🦼", "🧑‍🦼‍➡️", "👨‍🦼", "👨‍🦼‍➡️", "👩‍🦼", "👩‍🦼‍➡️", "🧑‍🦽", "🧑‍🦽‍➡️", "👨‍🦽", "👨‍🦽‍➡️", "👩‍🦽", "👩‍🦽‍➡️", "🏃", "🏃‍♂️", "🏃‍♀️", "🏃‍➡️", "🏃‍♀️‍➡️", "🏃‍♂️‍➡️", "💃", "🕺", "🕴️", "👯", "👯‍♂️", "👯‍♀️", "🧖", "🧖‍♂️", "🧖‍♀️", "🧗", "🧗‍♂️", "🧗‍♀️"], 13: ["🤺", "🏇", "⛷️", "🏂", "🏌️", "🏌️‍♂️", "🏌️‍♀️", "🏄", "🏄‍♂️", "🏄‍♀️", "🚣", "🚣‍♂️", "🚣‍♀️", "🏊", "🏊‍♂️", "🏊‍♀️", "⛹️", "⛹️‍♂️", "⛹️‍♀️", "🏋️", "🏋️‍♂️", "🏋️‍♀️", "🚴", "🚴‍♂️", "🚴‍♀️", "🚵", "🚵‍♂️", "🚵‍♀️", "🤸", "🤸‍♂️", "🤸‍♀️", "🤼", "🤼‍♂️", "🤼‍♀️", "🤽", "🤽‍♂️", "🤽‍♀️", "🤾", "🤾‍♂️", "🤾‍♀️", "🤹", "🤹‍♂️", "🤹‍♀️"], 14: ["🧘", "🧘‍♂️", "🧘‍♀️", "🛀", "🛌"], 15: ["🧑‍🤝‍🧑", "👭", "👫", "👬", "💏", "👩‍❤️‍💋‍👨", "👨‍❤️‍💋‍👨", "👩‍❤️‍💋‍👩", "💑", "👩‍❤️‍👨", "👨‍❤️‍👨", "👩‍❤️‍👩", "👨‍👩‍👦", "👨‍👩‍👧", "👨‍👩‍👧‍👦", "👨‍👩‍👦‍👦", "👨‍👩‍👧‍👧", "👨‍👨‍👦", "👨‍👨‍👧", "👨‍👨‍👧‍👦", "👨‍👨‍👦‍👦", "👨‍👨‍👧‍👧", "👩‍👩‍👦", "👩‍👩‍👧", "👩‍👩‍👧‍👦", "👩‍👩‍👦‍👦", "👩‍👩‍👧‍👧", "👨‍👦", "👨‍👦‍👦", "👨‍👧", "👨‍👧‍👦", "👨‍👧‍👧", "👩‍👦", "👩‍👦‍👦", "👩‍👧", "👩‍👧‍👦", "👩‍👧‍👧"], 16: ["🗣️", "👤", "👥", "🫂", "👪", "🧑‍🧑‍🧒", "🧑‍🧑‍🧒‍🧒", "🧑‍🧒", "🧑‍🧒‍🧒", "👣"]], 4: [1: ["🐵", "🐒", "🦍", "🦧", "🐶", "🐕", "🦮", "🐕‍🦺", "🐩", "🐺", "🦊", "🦝", "🐱", "🐈", "🐈‍⬛", "🦁", "🐯", "🐅", "🐆", "🐴", "🫎", "🫏", "🐎", "🦄", "🦓", "🦌", "🦬", "🐮", "🐂", "🐃", "🐄", "🐷", "🐖", "🐗", "🐽", "🐏", "🐑", "🐐", "🐪", "🐫", "🦙", "🦒", "🐘", "🦣", "🦏", "🦛", "🐭", "🐁", "🐀", "🐹", "🐰", "🐇", "🐿️", "🦫", "🦔", "🦇", "🐻", "🐻‍❄️", "🐨", "🐼", "🦥", "🦦", "🦨", "🦘", "🦡", "🐾"], 2: ["🦃", "🐔", "🐓", "🐣", "🐤", "🐥", "🐦", "🐧", "🕊️", "🦅", "🦆", "🦢", "🦉", "🦤", "🪶", "🦩", "🦚", "🦜", "🪽", "🐦‍⬛", "🪿", "🐦‍🔥"], 3: ["🐸"], 4: ["🐊", "🐢", "🦎", "🐍", "🐲", "🐉", "🦕", "🦖"], 5: ["🐳", "🐋", "🐬", "🦭", "🐟", "🐠", "🐡", "🦈", "🐙", "🐚", "🪸", "🪼"], 6: ["🐌", "🦋", "🐛", "🐜", "🐝", "🪲", "🐞", "🦗", "🪳", "🕷️", "🕸️", "🦂", "🦟", "🪰", "🪱", "🦠"], 7: ["💐", "🌸", "💮", "🪷", "🏵️", "🌹", "🥀", "🌺", "🌻", "🌼", "🌷", "🪻"], 8: ["🌱", "🪴", "🌲", "🌳", "🌴", "🌵", "🌾", "🌿", "☘️", "🍀", "🍁", "🍂", "🍃", "🪹", "🪺", "🍄"]], 5: [1: ["🍇", "🍈", "🍉", "🍊", "🍋", "🍋‍🟩", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍑", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥"], 2: ["🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🥜", "🫘", "🌰", "🫚", "🫛", "🍄‍🟫"], 3: ["🍞", "🥐", "🥖", "🫓", "🥨", "🥯", "🥞", "🧇", "🧀", "🍖", "🍗", "🥩", "🥓", "🍔", "🍟", "🍕", "🌭", "🥪", "🌮", "🌯", "🫔", "🥙", "🧆", "🥚", "🍳", "🥘", "🍲", "🫕", "🥣", "🥗", "🍿", "🧈", "🧂", "🥫"], 4: ["🍱", "🍘", "🍙", "🍚", "🍛", "🍜", "🍝", "🍠", "🍢", "🍣", "🍤", "🍥", "🥮", "🍡", "🥟", "🥠", "🥡"], 5: ["🦀", "🦞", "🦐", "🦑", "🦪"], 6: ["🍦", "🍧", "🍨", "🍩", "🍪", "🎂", "🍰", "🧁", "🥧", "🍫", "🍬", "🍭", "🍮", "🍯"], 7: ["🍼", "🥛", "☕", "🫖", "🍵", "🍶", "🍾", "🍷", "🍸", "🍹", "🍺", "🍻", "🥂", "🥃", "🫗", "🥤", "🧋", "🧃", "🧉", "🧊"], 8: ["🥢", "🍽️", "🍴", "🥄", "🔪", "🫙", "🏺"]], 6: [1: ["🌍", "🌎", "🌏", "🌐", "🗺️", "🗾", "🧭"], 2: ["🏔️", "⛰️", "🌋", "🗻", "🏕️", "🏖️", "🏜️", "🏝️", "🏞️"], 3: ["🏟️", "🏛️", "🏗️", "🧱", "🪨", "🪵", "🛖", "🏘️", "🏚️", "🏠", "🏡", "🏢", "🏣", "🏤", "🏥", "🏦", "🏨", "🏩", "🏪", "🏫", "🏬", "🏭", "🏯", "🏰", "💒", "🗼", "🗽"], 4: ["⛪", "🕌", "🛕", "🕍", "⛩️", "🕋"], 5: ["⛲", "⛺", "🌁", "🌃", "🏙️", "🌄", "🌅", "🌆", "🌇", "🌉", "♨️", "🎠", "🛝", "🎡", "🎢", "💈", "🎪"], 6: ["🚂", "🚃", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞", "🚋", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓", "🚔", "🚕", "🚖", "🚗", "🚘", "🚙", "🛻", "🚚", "🚛", "🚜", "🏎️", "🏍️", "🛵", "🦽", "🦼", "🛺", "🚲", "🛴", "🛹", "🛼", "🚏", "🛣️", "🛤️", "🛢️", "⛽", "🛞", "🚨", "🚥", "🚦", "🛑", "🚧"], 7: ["⚓", "🛟", "⛵", "🛶", "🚤", "🛳️", "⛴️", "🛥️", "🚢"], 8: ["✈️", "🛩️", "🛫", "🛬", "🪂", "💺", "🚁", "🚟", "🚠", "🚡", "🛰️", "🚀", "🛸"], 9: ["🛎️", "🧳"], 10: ["⌛", "⏳", "⌚", "⏰", "⏱️", "⏲️", "🕰️", "🕛", "🕧", "🕐", "🕜", "🕑", "🕝", "🕒", "🕞", "🕓", "🕟", "🕔", "🕠", "🕕", "🕡", "🕖", "🕢", "🕗", "🕣", "🕘", "🕤", "🕙", "🕥", "🕚", "🕦"], 11: ["🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘", "🌙", "🌚", "🌛", "🌜", "🌡️", "☀️", "🌝", "🌞", "🪐", "⭐", "🌟", "🌠", "🌌", "☁️", "⛅", "⛈️", "🌤️", "🌥️", "🌦️", "🌧️", "🌨️", "🌩️", "🌪️", "🌫️", "🌬️", "🌀", "🌈", "🌂", "☂️", "☔", "⛱️", "⚡", "❄️", "☃️", "⛄", "☄️", "🔥", "💧", "🌊"]], 7: [1: ["🎃", "🎄", "🎆", "🎇", "🧨", "✨", "🎈", "🎉", "🎊", "🎋", "🎍", "🎎", "🎏", "🎐", "🎑", "🧧", "🎀", "🎁", "🎗️", "🎟️", "🎫"], 2: ["🎖️", "🏆", "🏅", "🥇", "🥈", "🥉"], 3: ["⚽", "⚾", "🥎", "🏀", "🏐", "🏈", "🏉", "🎾", "🥏", "🎳", "🏏", "🏑", "🏒", "🥍", "🏓", "🏸", "🥊", "🥋", "🥅", "⛳", "⛸️", "🎣", "🤿", "🎽", "🎿", "🛷", "🥌"], 4: ["🎯", "🪀", "🪁", "🔫", "🎱", "🔮", "🪄", "🎮", "🕹️", "🎰", "🎲", "🧩", "🧸", "🪅", "🪩", "🪆", "♠️", "♥️", "♦️", "♣️", "♟️", "🃏", "🀄", "🎴"], 5: ["🎭", "🖼️", "🎨", "🧵", "🪡", "🧶", "🪢"]], 8: [1: ["👓", "🕶️", "🥽", "🥼", "🦺", "👔", "👕", "👖", "🧣", "🧤", "🧥", "🧦", "👗", "👘", "🥻", "🩱", "🩲", "🩳", "👙", "👚", "🪭", "👛", "👜", "👝", "🛍️", "🎒", "🩴", "👞", "👟", "🥾", "🥿", "👠", "👡", "🩰", "👢", "🪮", "👑", "👒", "🎩", "🎓", "🧢", "🪖", "⛑️", "📿", "💄", "💍", "💎"], 2: ["🔇", "🔈", "🔉", "🔊", "📢", "📣", "📯", "🔔", "🔕"], 3: ["🎼", "🎵", "🎶", "🎙️", "🎚️", "🎛️", "🎤", "🎧", "📻"], 4: ["🎷", "🪗", "🎸", "🎹", "🎺", "🎻", "🪕", "🥁", "🪘", "🪇", "🪈"], 5: ["📱", "📲", "☎️", "📞", "📟", "📠"], 6: ["🔋", "🪫", "🔌", "💻", "🖥️", "🖨️", "⌨️", "🖱️", "🖲️", "💽", "💾", "💿", "📀", "🧮"], 7: ["🎥", "🎞️", "📽️", "🎬", "📺", "📷", "📸", "📹", "📼", "🔍", "🔎", "🕯️", "💡", "🔦", "🏮", "🪔"], 8: ["📔", "📕", "📖", "📗", "📘", "📙", "📚", "📓", "📒", "📃", "📜", "📄", "📰", "🗞️", "📑", "🔖", "🏷️"], 9: ["💰", "🪙", "💴", "💵", "💶", "💷", "💸", "💳", "🧾", "💹"], 10: ["✉️", "📧", "📨", "📩", "📤", "📥", "📦", "📫", "📪", "📬", "📭", "📮", "🗳️"], 11: ["✏️", "✒️", "🖋️", "🖊️", "🖌️", "🖍️", "📝"], 12: ["💼", "📁", "📂", "🗂️", "📅", "📆", "🗒️", "🗓️", "📇", "📈", "📉", "📊", "📋", "📌", "📍", "📎", "🖇️", "📏", "📐", "✂️", "🗃️", "🗄️", "🗑️"], 13: ["🔒", "🔓", "🔏", "🔐", "🔑", "🗝️"], 14: ["🔨", "🪓", "⛏️", "⚒️", "🛠️", "🗡️", "⚔️", "💣", "🪃", "🏹", "🛡️", "🪚", "🔧", "🪛", "🔩", "⚙️", "🗜️", "⚖️", "🦯", "🔗", "⛓️‍💥", "⛓️", "🪝", "🧰", "🧲", "🪜"], 15: ["⚗️", "🧪", "🧫", "🧬", "🔬", "🔭", "📡"], 16: ["💉", "🩸", "💊", "🩹", "🩼", "🩺", "🩻"], 17: ["🚪", "🛗", "🪞", "🪟", "🛏️", "🛋️", "🪑", "🚽", "🪠", "🚿", "🛁", "🪤", "🪒", "🧴", "🧷", "🧹", "🧺", "🧻", "🪣", "🧼", "🫧", "🪥", "🧽", "🧯", "🛒"], 18: ["🚬", "⚰️", "🪦", "⚱️", "🧿", "🪬", "🗿", "🪧", "🪪"]], 9: [1: ["🏧", "🚮", "🚰", "♿", "🚹", "🚺", "🚻", "🚼", "🚾", "🛂", "🛃", "🛄", "🛅"], 2: ["⚠️", "🚸", "⛔", "🚫", "🚳", "🚭", "🚯", "🚱", "🚷", "📵", "🔞", "☢️", "☣️"], 3: ["⬆️", "↗️", "➡️", "↘️", "⬇️", "↙️", "⬅️", "↖️", "↕️", "↔️", "↩️", "↪️", "⤴️", "⤵️", "🔃", "🔄", "🔙", "🔚", "🔛", "🔜", "🔝"], 4: ["🛐", "⚛️", "🕉️", "✡️", "☸️", "☯️", "✝️", "☦️", "☪️", "☮️", "🕎", "🔯", "🪯"], 5: ["♈", "♉", "♊", "♋", "♌", "♍", "♎", "♏", "♐", "♑", "♒", "♓", "⛎"], 6: ["🔀", "🔁", "🔂", "▶️", "⏩", "⏭️", "⏯️", "◀️", "⏪", "⏮️", "🔼", "⏫", "🔽", "⏬", "⏸️", "⏹️", "⏺️", "⏏️", "🎦", "🔅", "🔆", "📶", "🛜", "📳", "📴"], 7: ["♀️", "♂️", "⚧️"], 8: ["✖️", "➕", "➖", "➗", "🟰", "♾️"], 9: ["‼️", "⁉️", "❓", "❔", "❕", "❗", "〰️"], 10: ["💱", "💲"], 11: ["⚕️", "♻️", "⚜️", "🔱", "📛", "🔰", "⭕", "✅", "☑️", "✔️", "❌", "❎", "➰", "➿", "〽️", "✳️", "✴️", "❇️", "©️", "®️", "™️"], 12: ["#️⃣", "*️⃣", "0️⃣", "1️⃣", "2️⃣", "3️⃣", "4️⃣", "5️⃣", "6️⃣", "7️⃣", "8️⃣", "9️⃣", "🔟"], 13: ["🔠", "🔡", "🔢", "🔣", "🔤", "🅰️", "🆎", "🅱️", "🆑", "🆒", "🆓", "ℹ️", "🆔", "Ⓜ️", "🆕", "🆖", "🅾️", "🆗", "🅿️", "🆘", "🆙", "🆚", "🈁", "🈂️", "🈷️", "🈶", "🈯", "🉐", "🈹", "🈚", "🈲", "🉑", "🈸", "🈴", "🈳", "㊗️", "㊙️", "🈺", "🈵"], 14: ["🔴", "🟠", "🟡", "🟢", "🔵", "🟣", "🟤", "⚫", "⚪", "🟥", "🟧", "🟨", "🟩", "🟦", "🟪", "🟫", "⬛", "⬜", "◼️", "◻️", "◾", "◽", "▪️", "▫️", "🔶", "🔷", "🔸", "🔹", "🔺", "🔻", "💠", "🔘", "🔳", "🔲"]], 10: [1: ["🏁", "🚩", "🎌", "🏴", "🏳️", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️"], 2: ["🇦🇨", "🇦🇩", "🇦🇪", "🇦🇫", "🇦🇬", "🇦🇮", "🇦🇱", "🇦🇲", "🇦🇴", "🇦🇶", "🇦🇷", "🇦🇸", "🇦🇹", "🇦🇺", "🇦🇼", "🇦🇽", "🇦🇿", "🇧🇦", "🇧🇧", "🇧🇩", "🇧🇪", "🇧🇫", "🇧🇬", "🇧🇭", "🇧🇮", "🇧🇯", "🇧🇱", "🇧🇲", "🇧🇳", "🇧🇴", "🇧🇶", "🇧🇷", "🇧🇸", "🇧🇹", "🇧🇻", "🇧🇼", "🇧🇾", "🇧🇿", "🇨🇦", "🇨🇨", "🇨🇩", "🇨🇫", "🇨🇬", "🇨🇭", "🇨🇮", "🇨🇰", "🇨🇱", "🇨🇲", "🇨🇳", "🇨🇴", "🇨🇵", "🇨🇷", "🇨🇺", "🇨🇻", "🇨🇼", "🇨🇽", "🇨🇾", "🇨🇿", "🇩🇪", "🇩🇬", "🇩🇯", "🇩🇰", "🇩🇲", "🇩🇴", "🇩🇿", "🇪🇦", "🇪🇨", "🇪🇪", "🇪🇬", "🇪🇭", "🇪🇷", "🇪🇸", "🇪🇹", "🇪🇺", "🇫🇮", "🇫🇯", "🇫🇰", "🇫🇲", "🇫🇴", "🇫🇷", "🇬🇦", "🇬🇧", "🇬🇩", "🇬🇪", "🇬🇫", "🇬🇬", "🇬🇭", "🇬🇮", "🇬🇱", "🇬🇲", "🇬🇳", "🇬🇵", "🇬🇶", "🇬🇷", "🇬🇸", "🇬🇹", "🇬🇺", "🇬🇼", "🇬🇾", "🇭🇰", "🇭🇲", "🇭🇳", "🇭🇷", "🇭🇹", "🇭🇺", "🇮🇨", "🇮🇩", "🇮🇪", "🇮🇱", "🇮🇲", "🇮🇳", "🇮🇴", "🇮🇶", "🇮🇷", "🇮🇸", "🇮🇹", "🇯🇪", "🇯🇲", "🇯🇴", "🇯🇵", "🇰🇪", "🇰🇬", "🇰🇭", "🇰🇮", "🇰🇲", "🇰🇳", "🇰🇵", "🇰🇷", "🇰🇼", "🇰🇾", "🇰🇿", "🇱🇦", "🇱🇧", "🇱🇨", "🇱🇮", "🇱🇰", "🇱🇷", "🇱🇸", "🇱🇹", "🇱🇺", "🇱🇻", "🇱🇾", "🇲🇦", "🇲🇨", "🇲🇩", "🇲🇪", "🇲🇫", "🇲🇬", "🇲🇭", "🇲🇰", "🇲🇱", "🇲🇲", "🇲🇳", "🇲🇴", "🇲🇵", "🇲🇶", "🇲🇷", "🇲🇸", "🇲🇹", "🇲🇺", "🇲🇻", "🇲🇼", "🇲🇽", "🇲🇾", "🇲🇿", "🇳🇦", "🇳🇨", "🇳🇪", "🇳🇫", "🇳🇬", "🇳🇮", "🇳🇱", "🇳🇴", "🇳🇵", "🇳🇷", "🇳🇺", "🇳🇿", "🇴🇲", "🇵🇦", "🇵🇪", "🇵🇫", "🇵🇬", "🇵🇭", "🇵🇰", "🇵🇱", "🇵🇲", "🇵🇳", "🇵🇷", "🇵🇸", "🇵🇹", "🇵🇼", "🇵🇾", "🇶🇦", "🇷🇪", "🇷🇴", "🇷🇸", "🇷🇺", "🇷🇼", "🇸🇦", "🇸🇧", "🇸🇨", "🇸🇩", "🇸🇪", "🇸🇬", "🇸🇭", "🇸🇮", "🇸🇯", "🇸🇰", "🇸🇱", "🇸🇲", "🇸🇳", "🇸🇴", "🇸🇷", "🇸🇸", "🇸🇹", "🇸🇻", "🇸🇽", "🇸🇾", "🇸🇿", "🇹🇦", "🇹🇨", "🇹🇩", "🇹🇫", "🇹🇬", "🇹🇭", "🇹🇯", "🇹🇰", "🇹🇱", "🇹🇲", "🇹🇳", "🇹🇴", "🇹🇷", "🇹🇹", "🇹🇻", "🇹🇼", "🇹🇿", "🇺🇦", "🇺🇬", "🇺🇲", "🇺🇳", "🇺🇸", "🇺🇾", "🇺🇿", "🇻🇦", "🇻🇨", "🇻🇪", "🇻🇬", "🇻🇮", "🇻🇳", "🇻🇺", "🇼🇫", "🇼🇸", "🇽🇰", "🇾🇪", "🇾🇹", "🇿🇦", "🇿🇲", "🇿🇼"], 3: ["🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🏴󠁧󠁢󠁳󠁣󠁴󠁿", "🏴󠁧󠁢󠁷󠁬󠁳󠁿"]]]
  //Isolation
  
  let emojiGroupNames: [Int: LocalizedStringResource] = [1: LocalizedStringResource("Emoji.group.1", table: "Cepheus"), 2: LocalizedStringResource("Emoji.group.2", table: "Cepheus"), 3: LocalizedStringResource("Emoji.group.3", table: "Cepheus"), 4: LocalizedStringResource("Emoji.group.4", table: "Cepheus"), 5: LocalizedStringResource("Emoji.group.5", table: "Cepheus"), 6: LocalizedStringResource("Emoji.group.6", table: "Cepheus"), 7: LocalizedStringResource("Emoji.group.7", table: "Cepheus"), 8: LocalizedStringResource("Emoji.group.8", table: "Cepheus"), 9: LocalizedStringResource("Emoji.group.9", table: "Cepheus"), 10: LocalizedStringResource("Emoji.group.10", table: "Cepheus")]
  let emojiGroupNamesShortened: [Int: LocalizedStringResource] = [1: LocalizedStringResource("Emoji.group.1.shortened", table: "Cepheus"), 2: LocalizedStringResource("Emoji.group.2.shortened", table: "Cepheus"), 3: LocalizedStringResource("Emoji.group.3.shortened", table: "Cepheus"), 4: LocalizedStringResource("Emoji.group.4.shortened", table: "Cepheus"), 5: LocalizedStringResource("Emoji.group.5.shortened", table: "Cepheus"), 6: LocalizedStringResource("Emoji.group.6.shortened", table: "Cepheus"), 7: LocalizedStringResource("Emoji.group.7.shortened", table: "Cepheus"), 8: LocalizedStringResource("Emoji.group.8.shortened", table: "Cepheus"), 9: LocalizedStringResource("Emoji.group.9.shortened", table: "Cepheus"), 10: LocalizedStringResource("Emoji.group.10.shortened", table: "Cepheus")]
  let emojiGroupExamples: [Int: String] = [0: "🕗", 1: "😀", 2: "👋", 4: "🌳", 5: "🍔", 6: "🏖️", 7: "🎉", 8: "📒", 9: "🔢", 10: "🏁"]
  let emojiSubgroupNames: [Int: [LocalizedStringResource]] = [
    1: [LocalizedStringResource("Emoji.subgroup.1.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.2", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.3", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.4", table: "Cepheus"),  LocalizedStringResource("Emoji.subgroup.1.5", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.6", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.7", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.8", table: "Cepheus"),  LocalizedStringResource("Emoji.subgroup.1.9", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.10", table: "Cepheus"),  LocalizedStringResource("Emoji.subgroup.1.11", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.12", table: "Cepheus"),  LocalizedStringResource("Emoji.subgroup.1.13", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.14", table: "Cepheus"),  LocalizedStringResource("Emoji.subgroup.1.15", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.1.16", table: "Cepheus")],
    2: [LocalizedStringResource("Emoji.subgroup.2.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.2", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.3", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.4", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.5", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.6", table: "Cepheus"),  LocalizedStringResource("Emoji.subgroup.2.7", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.8", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.9", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.10", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.11", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.12", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.13", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.14", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.15", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.2.16", table: "Cepheus")],
    3: [LocalizedStringResource("Emoji.subgroup.3.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.3.2", table: "Cepheus")],
    4: [LocalizedStringResource("Emoji.subgroup.4.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.4.2", table: "Cepheus"),LocalizedStringResource("Emoji.subgroup.4.3", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.4.4", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.4.5", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.4.6", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.4.7", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.4.8", table: "Cepheus")],
    5: [LocalizedStringResource("Emoji.subgroup.5.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.5.2", table: "Cepheus"),LocalizedStringResource("Emoji.subgroup.5.3", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.5.4", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.5.5", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.5.6", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.5.7", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.5.8", table: "Cepheus")],
    6: [LocalizedStringResource("Emoji.subgroup.6.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.2", table: "Cepheus"),LocalizedStringResource("Emoji.subgroup.6.3", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.4", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.5", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.6", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.7", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.8", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.9", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.10", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.6.11", table: "Cepheus")],
    7: [LocalizedStringResource("Emoji.subgroup.7.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.7.2", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.7.3", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.7.4", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.7.5", table: "Cepheus")],
    8: [LocalizedStringResource("Emoji.subgroup.8.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.2", table: "Cepheus"),LocalizedStringResource("Emoji.subgroup.8.3", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.4", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.5", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.6", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.7", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.8", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.9", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.10", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.11", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.12", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.13", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.14", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.15", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.16", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.17", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.8.18", table: "Cepheus")],
    9: [LocalizedStringResource("Emoji.subgroup.9.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.2", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.3", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.4", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.5", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.6", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.7", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.8", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.9", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.10", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.11", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.12", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.13", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.9.14", table: "Cepheus")],
    10: [LocalizedStringResource("Emoji.subgroup.10.1", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.10.2", table: "Cepheus"), LocalizedStringResource("Emoji.subgroup.10.3", table: "Cepheus")]]
  let groupExamplesAreDisplayed = true
  @Binding var textField: String
  @Binding var cursor: Int
  @Environment(\.dismiss) var dismiss
  @State var recentUsedEmojis: [Any] = []
  @State var pinyinLocation = -1
  @State var inputPinyin = ""
  @State var language = "en-qwerty"
  var body: some View {
    if #available(watchOS 10.0, *) {
      NavigationStack {
        TabView {
          ForEach(1...10, id: \.self) { group in
            if group != 3 {
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
                  .navigationTitle(Text(emojiGroupNamesShortened[group] ?? LocalizedStringResource("Emoji.group.unknown", table: "Cepheus")))
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
                    .navigationTitle(Text("Emoji.group.recents", bundle: .module))
                  }, label: {
                    HStack {
                      Text(emojiGroupExamples[0] ?? "🕙")
                      Text("Emoji.group.recents", bundle: .module)
                    }
                  })
                }
                ForEach(1...10, id: \.self) { group in
                  if group != 3 {
                    NavigationLink(destination: {
                      List {
                        ForEach(0..<(emojiSubgroupNames[group]?.count ?? 1), id: \.self) { subgroup in
                          NavigationLink(destination: {
                            ScrollView {
                              LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                                ForEach(0...(cepheusEmojiDictionary[group]?[subgroup+1]?.count ?? 1), id: \.self) { emoji in
                                  if (emoji-1)%4 == 0 {
                                    Button(action: {
                                      textField = CepheusKeyboardAddLetter(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji-1) as? String ?? "", textField: textField, cursor: cursor)
                                      recentUsedEmojis = addEmojiToRecents(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji-1) as? String ?? "")
                                      cursor += 1
                                    }, label: {
                                      Text(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji-1) as? String ?? "")
                                        .font(.system(size: screenWidth/6))
                                    }).buttonStyle(.plain)
                                    Button(action: {
                                      textField = CepheusKeyboardAddLetter(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+0) as? String ?? "", textField: textField, cursor: cursor)
                                      recentUsedEmojis = addEmojiToRecents(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+0) as? String ?? "")
                                      cursor += 1
                                    }, label: {
                                      Text(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+0) as? String ?? "")
                                        .font(.system(size: screenWidth/6))
                                    }).buttonStyle(.plain)
                                    Button(action: {
                                      textField = CepheusKeyboardAddLetter(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+1) as? String ?? "", textField: textField, cursor: cursor)
                                      recentUsedEmojis = addEmojiToRecents(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+1) as? String ?? "")
                                      cursor += 1
                                    }, label: {
                                      Text(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+1) as? String ?? "")
                                        .font(.system(size: screenWidth/6))
                                    }).buttonStyle(.plain)
                                    Button(action: {
                                      textField = CepheusKeyboardAddLetter(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+2) as? String ?? "", textField: textField, cursor: cursor)
                                      recentUsedEmojis = addEmojiToRecents(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+2) as? String ?? "")
                                      cursor += 1
                                    }, label: {
                                      Text(arraySafeAccess(cepheusEmojiDictionary[group]?[subgroup+1] ?? [], element: emoji+2) as? String ?? "")
                                        .font(.system(size: screenWidth/6))
                                    }).buttonStyle(.plain)
                                  }
                                }
                              }
                            }
                            .navigationTitle(Text(arraySafeAccess(emojiSubgroupNames[group] ?? [], element: subgroup) as? LocalizedStringResource ?? LocalizedStringResource("Emoji.subgroup.unknown", table: "Cepheus")))
                          }, label: {
                            Text(arraySafeAccess(emojiSubgroupNames[group] ?? [], element: subgroup) as? LocalizedStringResource ?? LocalizedStringResource("Emoji.subgroup.unknown", table: "Cepheus"))
                          })
                        }
                      }
                      .navigationTitle(Text(emojiGroupNames[group] ?? LocalizedStringResource("Emoji.group.unknown", table: "Cepheus")))
                    }, label: {
                      HStack {
                        Text(emojiGroupExamples[group] ?? "❓")
                        Text(emojiGroupNames[group] ?? LocalizedStringResource("Emoji.group.unknown", table: "Cepheus"))
                      }
                    })
                  }
                }
              }
              .navigationTitle(Text("Emoji.list.title", bundle: .module))
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
  }
}

func wholeGroup(_ dictionary: [Int: [String]]) -> [String] {
  var output: [String] = []
  for subgroup in 1...20 {
    output += dictionary[subgroup] ?? []
  }
  return output
}
