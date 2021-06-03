//#-hidden-code
import PlaygroundSupport
import UIKit
import WordSearchModule

let tutorial2 = WordSearchViewController()
tutorial2.numberOfViewsPerRow = 11
tutorial2.pageType = .Tutorial2
tutorial2.words = ["BIGSUR","CATALINA","MOJAVE","HIGHSIERRA","ELCAPITAN", "LION"]
tutorial2.difficulty = .easy
PlaygroundPage.current.setLiveView(tutorial2)
//#-end-hidden-code

/*:
 # Things are getting a little more complicated
 
 * Callout(Tim Cookie):
 But don't worry, I'll explain every detail.
 ![Tim Cookie is here to help!](kawaii-cookie.png "Tim Cookie is here to help!")
 
 ## Words
 Some advanced information about the words:
 
 * The words will be placed **randomly** in multiple orientations and depending on the selected difficulty they can get more complicated.
 * The initial instruction is maintained, to capture the words you need to select all and only their letters at once in a straight line.
 * Let's keep things simple! The words do not intersect.
 * To deserve the **cookies rain** 🍪, you need to capture **all the words**.
 
 ## Hints
 If you need to, press the words button to see the remaining words!
 */
