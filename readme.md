App design and architecture considerations:
- Protocols for services - allows dependency injection and easily switch between real and mock for testing


Design issues I faced:
- Ran into a few errors with trying to use @Environment in a parent view, then passing that to the child view which owns the view model and then injecting that into the view model. This is not allowed since the environment object is available when the body of the view is called

- Sharing an instance of location manager between two view models. Used a Singleton design as a result and then injected it into the view model. Could be a bad design 
