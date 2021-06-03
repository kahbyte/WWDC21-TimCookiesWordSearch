//#-hidden-code
import UIKit
import PlaygroundSupport
import WordSearchModule

let wordSearch = WordSearchViewController()
wordSearch.numberOfViewsPerRow = 14
wordSearch.pageType = .Challenge
//#-end-hidden-code

/*:
 # The Challenge
 
 Now that you've learned the art of capturing words, it's time for the real challenge.
 
 This grid contains names of revolutionary Apple's creations.
 
 To be the one who deserves the cookie rain the most you **gotta catch 'em all**!
 
 # Difficulty
 
 You can select the difficulty by modifying the code below.
 If this is your first time, I recommend leaving it as is.
 
 * .easy: Words can only be positioned from left to right and downwards.
 * .medium: Words can be positioned as above and also upwards.
 * .hard: You are brave! Words follow the previous rules and can be positioned backwards!
 
 ## Enjoy ❤️
 
 */

var gameDifficulty: Difficulty = /*#-editable-code*/ .easy /*#-end-editable-code*/

/*:
 ![Tim Cookie enjoys!](tim-cookie.png "Tim Cookie enjoys being here! 🍪")
 */
//#-hidden-code
//wordSearch.difficulty = gameDifficulty
wordSearch.words = ["IPHONE", "IPOD", "IPAD", "WATCH", "MACBOOK", "HOMEPOD", "APPLETV", "AIRPODS", "ICLOUD", "SIRI"]
wordSearch.difficulty = gameDifficulty
PlaygroundPage.current.setLiveView(wordSearch)
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, .easy, .medium, .hard)

