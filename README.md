# CookIt
Simple app with recipes that you can easily search, you can filter your recipes with "what's in your fridge" option


there are two sections one to search and the other to view the recipes.

In the first section the user will choose the cousine type and the dish type,
after that the user will see a list of recipes with name, image and time that will take to make it.

The user can choose any from the list and then the app will show detail information about the recipe. metadata, image, title, ingredients with image name and quantity.

The user can choose wether to save the recipe or not by clicking save button on top of the screen.

The second section will display the recipes in a collection view, if the user taps in any recipe the recipe will automatically erase from the coredata.

In order to run the app and consume the services, the developer must add the mashape key as String in CookItAPI.swift file:

		networkController.headers = [
            "Accept": "application/json",
            "X-Mashape-Key": ADD_YOUR_KEY_HERE
        ]
