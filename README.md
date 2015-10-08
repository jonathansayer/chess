##Chess Game on Rails

This repo contains the skeleton backend logic in order to produce an online
chess application. The aim is to turn this logic into a Rails Api and build
a javascript application to work in tandem with the API.

The application was built using ruby 2.2.2.

####How to Run the Application

Once the Repo has been cloned, the relevant gems need to downloaded. If you have
bundler install, you can do this by using the bundle command in terminal:

```
$ bundle
```



The database then needs to created, migrated and seeded. To do this use the following commands
in terminal:

```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

The database should now be setup and ready for use.

Firstly a player should be created:

```
player1=Player.create(name:'name',colour:'white',status:'playing')
```

Always create a player with the status 'playing' and with an associated colour.
To move a piece you first have to find the peice in the database. For example if you
wanted to move the pawn at A2 to A3, you should first querie the database to look
for a pawn at A3.

```
$ pawn = Pawn.find_by(position:'A2')
```
To move simply instruct the player to move the piece and where to.

```
$ player.move pawn, 'A3'
```

Piece's will be taken off the board when another piece occupies the cell they are in.
To check the status if a player is in check or check mate, the board has to be queried first.

```
$ board = Board.first
$ board.in_check? 'white' # to check if white is in check, 'black' can also be entered as an argument.
$ board.check_mate? 'black' # to check if black is in check mate.
```
