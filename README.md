## ELM webapp with Vipps Login

This webapp was made by Carl Valdemar Ebbesen and Kristoffer Nyvoll

### Run local server and test request

Run this inside the `elm-vipps-webapp` to test with a local server:

```bash
$ npm install http-server -g
$ http-server httpserver -a localhost -p 5016 --cors

```

The request should be sent from index.html in your browser, which can be generated with `elm make HttpServer.elm`
