# Rails API Base

This is a simple base for a Rails API server. It uses [versionist](https://github.com/bploetz/versionist) to version the API, and includes a simple User model with authentication.

## How does authentication work?

The user model `has_many` authentication tokens that have (or don't have) expiration dates. Each time a client wants an authentication token, they have to POST to /v1/authenticate:

    $ curl -X POST -d '{"email": "email@example.org", "password": "123"}' -H "Content-Type: application/json" http://localhost:3000/v1/authenticate
    
    {"token":"bfe6e14b-5bac-4cb9-8f92-436b475221e9","expires_at":"2014-06-13T02:25:28.753Z"}

In order to access protected resources, clients have to send a header with a valid token:

    $ curl -X GET -H "Authorization: bfe6e14b-5bac-4cb9-8f92-436b475221e9" -H "Content-Type: application/json" -i http://localhost:3000/v1/protected/path

That's it!

## Want to contribute?

  1. Fork
  2. Create a branch
  3. Create a pull request
