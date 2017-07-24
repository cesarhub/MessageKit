/*
 MIT License
 
 Copyright (c) 2017 MessageKit
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Foundation

class MessageContainerSizeCalculator {

    func messageContainerSizeFor(messageType: MessageType, with layout: MessagesCollectionViewFlowLayout) -> CGSize {
        
        let avatarWidth = layout.avatarSizeCalculator.avatarSizeFor(messageType: messageType, with: layout).width
        let horizontalOffsets = layout.avatarToContainerPadding + layout.messageLeftRightPadding
        let messageContainerWidthMax = layout.itemWidth - avatarWidth - horizontalOffsets
        
        switch messageType.data {
        case .text(let text):
            let messageContainerHeight = text.height(considering: messageContainerWidthMax, font: layout.messageFont)
            let messageContainerEstWidth = text.width(considering: messageContainerHeight, font: layout.messageFont)
            if messageContainerEstWidth > messageContainerWidthMax {
                return CGSize(width: messageContainerWidthMax, height: messageContainerHeight)
            } else {
                return CGSize(width: messageContainerEstWidth, height: messageContainerHeight)
            }

//        default:
//            // TODO: Heights for other types of message data
//            fatalError("Currently .text(String) is the only supported message type")
        }
    }

}

fileprivate extension String {
    
    func height(considering width: CGFloat, font: UIFont) -> CGFloat {
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundRect = self.boundingRect(with: constraintBox, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundRect.height
    }
    
    func width(considering height: CGFloat, font: UIFont) -> CGFloat {
        let constraintBox = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundRect = self.boundingRect(with: constraintBox, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundRect.width
    }
    
}
