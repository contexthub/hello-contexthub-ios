# Hello World

The hello world sample app.

## Getting Started

1. fork the repository
1. clone the repository
1. Add your app id In the HelloContextHubAppDelegate
1. build the project
1. run the project in the simulator


## Xcode Console

1. keep an eye on the console output
1. you'll see that the app has detected a locaiton change event
1. Take a look at the app delegate
1. you'll see the Event Manager Delegate and Data Source protocols have been implemented.  <Link to Docs about these>

    
## ContextHub.com

1. on app.contexthub.com click on the hello world app
1. notice that you have a context named <CONTXTNAMEHERE>
1. you should see events


## Context Rules

1. change the rule
1. save the event to the vault
1. stop and start the app in the simulator.
1. check out the vault


## Creating a New Rule

1. create a geofence_in context on the server
1. tap the Create Geofence button
1. check out the geofences on the server
1. simulate a location change
1. go back to previous location
1. you have a new event, no code needed :)


## Use the vault object in the context rule

1. edit the location_changed context
1. notice that you have a few objects that you can use inside the rule
1. add vault.create("sampe-event", event)
1. launch the application
1. click on the vault tab
1. now you see that all of your locatin_changed events are being persisted in the vault in a container.


Trouble with the simulator
- make sure you have a location set in the simulator  debug--> location
- use the custom location to test fence in and out
- use freeway drive to test locaiton change
