#   ECE564_HW 
This is the project you will use for all of your ECE564 homework assignments. You need to download to your computer, add your code, and then add a repo under your own ID with this name ("ECE564_HW"). It is important that you use the same project name.  
This should work fine for HW1 - HW4.  If you decide to use SwiftUI for your user interface, you can recreate with a new project (keep the name) or follow something like this - https://stackoverflow.com/questions/56529488/is-there-any-way-to-use-storyboard-and-swiftui-in-same-ios-xcode-project

Any notes, additional functions, comments you want to share with the TA and I before grading please put in this file in the correspondiing section below.  Part of the grading is anything you did above and beyond the requirements, so make sure that is included here in the README.

## HW1
In order to accommodate HW2, my code used "netID" to match person in both "Add/Update" and "Find". In other words, to tell whether a person exists, "netID" is used instead of first name and last name.

### Extra features I implemented:

- I added 2 additional fields. Apart from the required 7, I added "netID" and one more from ECE564 protocol.

- My database is larger. I added two more classmates' information.

- After doing "Find", my code can display the information of the person found in each textfield.

- My code is not case-sensitive. For example, "RT113" is saved as "rt113". Also, "riCHarD TELLford" is saved as "Richard Telford", while "LIKE traVELLinG" is saved as "like travelling".

- I used Duke Blue and changed font. I also added a clear button to each text field.

## HW2
### Extra features:
- I added some avatars in the database, and it can be shown on the interface. If a person is found or updated, the avatar remains. Otherwise, it changes to a default one.

- I made input validation. When doing adding or updating, all fields except Email need to be filled in, and all UISegmentedControls should be selected. Otherwise, a warning will be posted in the description area.

- If no email is typed when adding or updating, a default one in the form of netid@duke.edu will be automatically saved to the database.

## HW3
About JSON, I defined a new class called JSONPerson that stores all the JSON information. When encoding (saving), my code converts DukePerson objects to JSONPerson objects, and the whole dictionary that stores (key netid : value JSONPerson) is encoded directly to JSON.

### Extra features:
- I added sound to buttons. If "Add/Update", "Find", or the picture button is clicked, the app will let out a beep.

- I designed an icon for the app. I put a blue devil and a notebook icon together to represent my iPhone app.

- I included the Clear function. If having entered something, a crossing symbol is displayed at that field, and once clicked, that field will be emptied. Also, once the "Add/Update" button clicked, all the field will be emptied, and the picture will be set to the default one.

- My code supports advanced data validation. When doing finding, if more than 3 hobbies, or languages, or numbers in the name field are entered, a message will be presented at the description area suggesting re-enter.

## HW4
- For Requirement 1, if my own information is updated, a POST will be made and the encoded JSON will be uploaded to the server. At the same time, the runtime database and the disk will also be updated.

- For Requirement 2, when doing download, a GET will be made. While downloading, a progress indicator will be shown at the top. Every time the app is launched, it will ask you whether you want to sync from the server. You can choose from replace, update and not to sync. After the download is down, the data will be stored to the runtime database as well as the disk.

- For Requirement 3, I added "Unknown" to enums to prevent from bad data retrived from the server.

- Clean code: Apart from InformationViewController, I put HTTP related operations in Communications.swift, put util functions in Utilities.swift, and put all enums, classes and protocols in DataModel.swift. I also keep good comments.

### Extra features:
I implemented both "Replace" and "Update" for HTTP get. The alert will give you three options: Replace, Update, or do nothins. Replace will empty all local data and replace with the server one. Update will keep those record that their NetIDs are not on the server, and update those record that their NetIDs are already on the server.

## HW5
I used show to go to the informationViewController after clicking one cell, and used present modally to go to the informationViewController after clikcing the plus sign in the tableViewController.

### Extra features:

- In the search field, whenever you type in a letter or delete a letter, the program will filter and show the search results. The search is based on NetID, and it is case-insensitive. Moreover, those people whose NetIDs contain the typed letters and numbers will be filtered out. So, I used contain not start with, and this is more reasonable when searching.

- In the tableViewController, I sorted the sections and the cells. Thus, every time when the view is shown, the sequence sections and cells are shown remains the same. Besides, they are sorted in alphabetical order.

## HW6
- I added the "Flip" transition. On the back of the Information view, I added a Duke Blue "Welcome!" in an interesting font.

- When swiping a cell, two options "Edit" and "Delete" are offered.

### Extra Features:
- The "Edit" and "Delete" buttons' icons are shown using a pencil and a trash bin.

## HW7
I added a new view controller called DrawingViewController. At the information view, if the pofile is not about me, the BackView from last week will be shown. Otherwise, the newly created DrawingView will be shown. In the DrawingViewController, the following functions are implemented.

- I added Attributed Text to show my hobby which is watching movies in special font and color.

- I added some continuous pictures showing a clapperboard and put them in a Animated UIImage.

- I drawed a rectangle as frame with vector graphic drawing orders.

- I defined two UIView subclasses: a movie projector and a dial that revolve the moview film.

- I used UIView animation, the two dials on the projector will revolve.
