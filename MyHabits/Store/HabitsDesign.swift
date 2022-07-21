//
//  HabitsDesign.swift
//  MyHabits
//
//  Created by Алексей Моторин on 21.07.2022.
//

import UIKit

enum TextFontStyle {
    case title, headline, body, footnoteBlack, footnoteStatus, footnoteGray, caption
    
    var textFont: UIFont {
        switch self {
        case .title:
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .headline:
            return UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .body:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .footnoteBlack:
            return UIFont.systemFont(ofSize: 13, weight: .semibold)
        case .footnoteStatus:
            return UIFont.systemFont(ofSize: 13, weight: .semibold)
        case .footnoteGray:
            return UIFont.systemFont(ofSize: 13, weight: .regular)
        case .caption:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .title, .body, .footnoteBlack:
            return UIColor.black
        case .headline:
            return UIColor.systemBlue
        case .footnoteStatus:
            return UIColor.systemGray
        case .footnoteGray:
            return UIColor.systemGray2
        case .caption:
            return UIColor.lightGray
        }
    }
}

enum ColorStyle {
    case systemGray, systemGray2, white, purple, blue, green, darkBlue, orange
    
    var colorSetings: UIColor {
        switch self {
        case .systemGray:
            return .systemGray
        case .systemGray2:
            return .systemGray2
        case .white:
            return #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        case .purple:
            return #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        case .blue:
            return #colorLiteral(red: 0.1607843137, green: 0.4274509804, blue: 1, alpha: 1)
        case .green:
            return #colorLiteral(red: 0.1137254902, green: 0.7019607843, blue: 0.1333333333, alpha: 1)
        case .darkBlue:
            return #colorLiteral(red: 0.3843137255, green: 0.2117647059, blue: 1, alpha: 1)
        case .orange:
            return #colorLiteral(red: 1, green: 0.6235294118, blue: 0.3098039216, alpha: 1)
        }
    }
}
