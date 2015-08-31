//
//  StringExtensions.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/18.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//
import UIKit
extension String {
    func size(font:UIFont,maxSize:CGSize)->CGSize {
        return   self.boundingRectWithSize(
            maxSize,
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [ NSFontAttributeName : font ],
            context: nil).size
    }
    func sha1() -> String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.alloc(digestLen)

        CC_SHA1(str!, strLen, result)

        var hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }

        result.destroy()
        return String(hash)
    }
    
}
