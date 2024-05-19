App design, architecture, and design considerations:
- MVVM architecture 
- CoreLocation to configure user location permissions and user location coordinates along with georeversing
- MapKit to allow viewing different air qualities across the world 
- Protocol oriented programming - allows dependency injection and easily switch between real and mock for testing
- Extensions in model with mock data for testing
- Generics - used generics for working through @Bindable and in protocols
- Charts for viewing historical data by day, week, and months


Design issues I faced:
- Ran into a few errors with trying to use @Environment in a parent view, then passing that to the child view which owns the view model and then injecting that into the view model. This is not allowed since the environment object is available when the body of the view is called
- Sharing an instance of location manager between two view models. Used a Singleton design as a result and then injected it into the view model via the initializer. See notes below for stack overflow article on this as well
- Associating Colors - wanted to avoid associating colors with my view model / models, so I used Strings, then let the views themselves associate it with a computed property
- Bindable and Protocols - faced some strange issues using @Observable - referred to this stack overflow post: https://stackoverflow.com/questions/59503399/how-to-define-a-protocol-as-a-type-for-a-observedobject-property 
- Also https://tanaschita.com/20230807-migrating-to-observation/ was great to use to reference @Observable and SwiftUI data flow. Using @Observable, we go from @StateObject->@State and @ObservedObject->@Bindable

Notes :
- Date formatter - .formatted() is incredibly useful for formatting dates. iOS 15+ introduced a new Formatter API via Date.FormatStyle (.dateTime) which makes working with Dates much easier than creating a new DateFormatter.
- Swift charts for modeling historical air quality
- Singleton + Dependency injection - https://stackoverflow.com/questions/55483541/how-to-use-the-singleton-pattern-in-conjunction-with-dependency-injection
- Generics in protocol (associatedtype/type alias), and using either generics or existential types (protocol as type. required to use "any" keyword in future Swift), and difference in performance
- Read about "some", "any", generics, and static/dynamic dispatch
- MapReader allows MapKit to read user taps and convert it to coordinates in iOS 17
- CoreLocationUI has an interesting new LocationButton feature
- https://stackoverflow.com/questions/14214741/xcode-environment-variables-not-present-during-archive/74254208#74254208 - tip on storing API key for acess outside of Xcode (test flight / appstore ex)

