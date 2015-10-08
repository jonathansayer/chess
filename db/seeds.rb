# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Pawn.create(position:'A2', white?: true)
Pawn.create(position:'B2', white?: true)
Pawn.create(position:'C2', white?: true)
Pawn.create(position:'D2', white?: true)
Pawn.create(position:'E2', white?: true)
Pawn.create(position:'F2', white?: true)
Pawn.create(position:'G2', white?: true)
Pawn.create(position:'H2', white?: true)

Rook.create(position:'A1', white?:true)
Rook.create(position:'H1', white?:true)

Knight.create(position:'B1', white?:true)
Knight.create(position:'G1', white?:true)

Bishop.create(position:'C1', white?:true)
Bishop.create(position:'F1', white?:true)

Queen.create(position:'E1', white?:true)

King.create(position:'D1', white?:true)

Pawn.create(position:'A7', white?: false)
Pawn.create(position:'B7', white?: false)
Pawn.create(position:'C7', white?: false)
Pawn.create(position:'D7', white?: false)
Pawn.create(position:'E7', white?: false)
Pawn.create(position:'F7', white?: false)
Pawn.create(position:'G7', white?: false)
Pawn.create(position:'H7', white?: false)

Rook.create(position:'A8', white?:false)
Rook.create(position:'H8', white?:false)

Knight.create(position:'B8', white?:false)
Knight.create(position:'G8', white?:false)

Bishop.create(position:'C8', white?:false)
Bishop.create(position:'F8', white?:false)

Queen.create(position:'E8', white?:false)

King.create(position:'D8', white?:false)

Board.create
