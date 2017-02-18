This project is a respones to http://docs.oracodechallenge.apiary.io/#reference/0/current-user/update
### Installation
```sh
$ git clone https://github.com/RGSSoftware/OraCC
$ cd OraCC
$ pod install
$ open OraCC.xcworkspace/
```
### TODO
A few things are missing because I didn’t see an API or UX spec for those features, so I simply left them out:
- Chats
- - Searching
- - Creation
- Chat Message
- - Creation

### Improvements:
- I decide to create a few classes to handle the forms Login, Register and Account instead of using an open source framework (https://github.com/xmartlabs/Eureka). I’ve make this choose because I wanted a small challenge, but I didn’t foresee how much time it would take for this mini challenge. Next time I would most likely use an open source framework in order to receive a higher level of customization, easier to use component and not reinventing the wheel.
- I’ve decide to use an OSF for the chat messages, but I had the opposite feeling of my fist “improvement”. My main problem was how hard it was customizing the framework. I believe this problem stemmed from my lack of experience with the framework, lack of documentation and age of the project. Next time I would try a few framework before deciding on one or build it myself. 
- There’s a lot of code duplication, but in time it should be refactored out.
- Test coverage
- A lot more.
