//#-hidden-code
import UIKit
import PlaygroundSupport
import WordSearchModule
let wordSearch = WordSearchViewController()
wordSearch.pageType = .Custom
//#-end-hidden-code
/*:
 # Our Playgrounds!
 
 
 * Callout(Kauê Sales):
 This playground is very special to me and I would love for more people to have the experience you had!
 I'll leave you with Tim Cookie to help you transform my Playground into our Playground!
 */

/*:
 
 * Callout(Tim Cookie):
 Helo! Creating an experience like the one you had is really simple!
 First let's define how many rows and columns our frame will have!
 
 - Note:
 "Macbooks are very powerful, but since we want you to have a simple and enjoyable experience, let's limit ourselves to numbers between 5 to 16, okay?"
 */
 var numberOfRowsAndColumns: Int = /*#-editable-code*/ 14 /*#-end-editable-code*/
/*:
 * Callout(Tim Cookie):
 Now, select how hard you want your word search to be!
 
 ### Remember:
 
 * .easy: Words can only be positioned from left to right and downwards.
 * .medium: Words can be positioned as above and also upwards.
 * .hard: Words follow the previous rules and can also be positioned backwards
 
 */
 let gameDifficulty: Difficulty = /*#-editable-code*/ .easy /*#-end-editable-code*/
/*:
 * Callout(Tim Cookie):
 And finally, edit the code below with your word list!
 
 There are no guarantees that they can all be positioned, so I recommend that there be a maximum of 10 words.
 
 Also keep in mind the size of the grid, words larger than the number of spaces will not enter.
 
 Don't forget to put your word between "" and separate them with a comma.

 Same words will be treated as different and empty words will be disregarded.
 
 My creator did his best to analyze several cases, but he cannot predict the creativity of all users. Be kind to the code. 🥺
 
 */
 var gameWords: [String] = /*#-editable-code*/ ["example"] /*#-end-editable-code*/
/*:
 ![Tim Cookie enjoys!](tim-cover.png "Tim Cookie enjoys being here! 🍪")
 */
//#-hidden-code

if gameWords.count != 0 {
    for index in 0..<gameWords.count {
        gameWords[index] = gameWords[index].uppercased()
    }
}

gameWords.removeAll { value in
    return value == ""
}

if numberOfRowsAndColumns < 5 {
    numberOfRowsAndColumns = 5
}

if numberOfRowsAndColumns > 16 {
    numberOfRowsAndColumns = 16
}


wordSearch.words = gameWords
wordSearch.difficulty = gameDifficulty
wordSearch.numberOfViewsPerRow = numberOfRowsAndColumns
PlaygroundPage.current.setLiveView(wordSearch)
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, .easy, .medium, .hard)
