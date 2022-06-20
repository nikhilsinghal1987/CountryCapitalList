# City List
The app enables the user to view a list of Cities in a tableview


App has following implementations

- Makes backend call for downloading all the City List.
- Basic call failures have been handled
- Data cleansing has not been handled

UI:
UI has been created programmatically. Auto layout has been utilised.
Image size optimisation for resizing has not been done.

Architecture: 
- The app uses MVVM and some combine features for binding

Testing:
- Major components of the app have been covered with unit testing. View models and controllers have been tested by injecting mock network manager to demonstrate decoupled testing.


Note: Although the app is universal and supports all form factors and orientations, it best works in iPhone 12 with minimum deployment target iOS13


