# Recipe Assiment
An app that helps users search a Recipe.

### Unit Tests included For SearchRecipes (View\Presenter\Interactor)

## Deployment

To run this project please make sure to update swift packages

```bash
  File -> Swift Packages -> Update to Latest Package Versions
```
Then run the tests

## Technology stack

### Programming Languages
Swift

### Tools
Xcode

### Frameworks
UIKit

## Design Pattern
VIP (Clean Code): VIP is improvement of VIPER architecture pattern.

## Packages
AlamoFire : Made a NetworkService layer wrapping Alamofire

KingFisher : 
Leverging the power of KingFisher i Made an ImageService to Efficiently load and cache images to be easily displayed in the table cells,
build it with the mind to cancel the loading of the image if the cell is preparing to be used to ensure a healty smooth scrolling of the table view
and limiting the cache capacity to not slow the phone and immediately clearing it when the cache isn't needed any more (when the user change the recipes he is searching for)

Lottie : 
To Create an awasome Splash Screen

SnapKit : 
One of the Best and easy ways to work with UIKit Programmatically used it to create the cells
## Roadmap to improve the app

- UnitTests: Have a more indepth UnitTests for SearchRecipes Modules + Writing Tests For RecipeDetails Modules

- Having a cell presenter/viewModel to handel the responspility of downloading the image and handling the data of the viewModel

- Handling more fail cases to better improve user experiance

- Converting all the UI from Storyboards to Programmatically


## Screenshots

<img src="https://i2.paste.pics/c4a222456f6ff8169556172239941608.png" width="200"> <img src="https://i2.paste.pics/75bb61c87361724a2be6ab5e27b3134d.png" width="200"/>  <img src="https://i2.paste.pics/0857082c9a0ca1812f7873accb60348c.png" width="200"/> <img src="https://i2.paste.pics/0c5c2f3d2026c94d91b3a8eb5c9c1a69.png" width="200"> 

## š About Me
 š Hi, Iām Morsy Mohamed Morsy

š I'm an iOS Developer, I have ( 6 years + ) total experience in software development, with ( 1 year 6 months + ) in iOS Development

šÆ I'm always interested in learning new technologies and have a passion for development.

š« LinkedIn: https://www.linkedin.com/in/morsysoker/

š« Email: Morsysoker@gmail.com
