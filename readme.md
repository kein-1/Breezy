App design and architecture considerations:
- Protocols for services - allows dependency injection and easily switch between real and mock for testing
- Singleton - singleton design for the location manager since two view models needed to access the same data. Trade off is that we are using a singleton design, so there is a tight coupling and shared state amongst the two view models. During initialization of each view model, I am passing in the shared state
 
