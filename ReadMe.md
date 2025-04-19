README

List of Patterns used
- Update Method: i used this in my main.lua file with love2D to render the screen. 
- State: I used this to keep track of the status of my cards for each frame. 
- Singleton: I defined one global instance of my grabber function in my love.load function. This lets my entire program have access to this instance. I believe that this is an example of the singleton pattern. 

What I would do differently and what I did well
- I think I did well on encapsulating the logic for the piles. I wanted to use a stack data structure for the piles within my card class but I opted out of that because it wouldn't be a good design choice. One thing I would like to improve is the movement of the cards at the moment is weird because if the mouse is hovering over two cards at once, when you grab a card it sets both cards' status to grabbed and this causes the second card to be stuck in its position and the player can't move that card again. I'm planning to fix this by implementing a notion of top card logic whitn my pile class and the playr can only interact with the top card. With this logic even if the mouse is hovering over multiple cards at once it's only going to grab the top card and our bug is going to be fixed. 

Assets
- I haven't added assets yet. I wanted to get the functionality working first. 