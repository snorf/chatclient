ChatClient

===========================================================================
DESCRIPTION:

This is a mockup of a chat client for iOS.
It has no backend, the client will just respond with a standard answer after 3 seconds.

To start chatting, hit the +-button and choose a contact (in the simulator you have to add a contact).
A chat window will appear and you can enter text.
Text is sent with the send button or by pressing Done on the keyboard.

Some comments about the choices I have made.

I use CoreData for storage with a very simple data model, ChatSession and ChatMessage.
A ChatSession can have multiple ChatMessages (one to many).

The root controller uses a NSFetchedResultsController to fetch all ChatSessions.
When a row is clicked a ChatController is pushed which will use it's own NSFetchedResultsController to fetch all ChatMessages for the corresponding ChatSession.

I looked at using KVO or CoreData notifications instead of a NSFetchedResultsController but I thought the code became messy and with KVO on a relation I got an old list and a new list and I had to compute the difference (maybe there is a better way but I didn't find it). I didn't really think that that would work if you have for example 1000 ChatMessages in the list and 1 new is added.

CoreData notifications looked much more promising but since I get notifications for all changes I felt it was overkill, so I went with the NSFetchedResultsController.

I have tried my best to keep the code clean but as soon as you add TableView delegates etc there will be a lot of boiler plate code.

I have added very primitive Unit Tests, mostly because I'm really novice in unit testing in Cocoa and also I didn't really find any good documentation about unit testing in CoreData. So my unit testing skills really have room or improvements.

I have profiled the application and it should handle large amounts of data. The first view has a really good TableView cell where everything is Opaque (except the little arrow) and this makes it run really fast (50+ fps) even with 500+ items in the list.

The Chat view is not that fast since i have the ballon images and the text in them have to be non opaque. Of course this could be prevented by removing the ballons but I checked "Color blended layers" in the official Message application and it has the same problem (but they have a "load more" button at the top).

Known bugs:
Sometimes when I bounce the ChatView at the top or bottom the ballon images get cut of, I don't know why.

No search function:
Right now there is no way to search in the messages. I would really like to add this but my time is almost up and I know that there are some work to be done to do an effective free text search in CoreData.



===========================================================================
BUILD REQUIREMENTS:

Mac OS X v10.7.2, Xcode 4.2.1, iPhone OS 5.0.1


===========================================================================
RUNTIME REQUIREMENTS:

Simulator: Mac OS X v10.7.2
iPhone: iPhone OS 5.0.1


===========================================================================
PACKAGING LIST:

AppDelegate.h
AppDelegate.m

The AppDelegate class defines the application delegate object, responsible for instantiating the application's view.

================================================================================
 2011-12-04 Johan Karlsteen

