# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

simpleKlassData = {
  name:"Generic Class",
  names:[
    {
      name: "Elf",
      options: ["Astrafel", "Daelwyn", "Feliana", "Damarra", "Sistranalle", "Pendrell", "Melliandre", "Dagoliir"]
    },
    {
      name: "Human",
      options: ["Baldric", "Leena", "Dunwick", "Willem", "Edwyn", "Florian", "Seraphine", "Quorra", "Charlotte", "Lily", "Ramonde", "Cassandra"]
    }
  ],
  looks: [
    {
      name: "eyes",
      options:[
        "Knowing Eyes", "Fiery Eyes", "Joyous Eyes"
      ]
    },
    {
      name: "hair",
      options: [
        "Fancy Hair", "Wild Hair", "Stylish Cap"
      ]
    },
    {
      name: "clothing",
      options:[
        "Finery", "Traveling Clothes", "Poor Clothes"
      ]
    },
    {
      name: "etc",
      options:[
        "Fit Body", "Well-fed Body", "Thin Body"
      ]
    }
  ],
  baseHP:6,
  baseDMG:6,
  baseLoad:9,
  races: [
    {
      name: "Elf",
      text:"A fancy pants elf."
    },
    {
      name: "Human",
      text:"Boring human."
    }
  ],
  alignment: [
    {
      name:"Good",
      text:"Aid someone else."
    },
    {
      name:"Neutral",
      text:"Avoid a conflict."
    },
    {
      name:"Chaotic",
      text:"Do something crazy."
    }
  ],
  bonds: [
    "The last time I saw _______________ did not end well.",
    "I think _______________ is super cool.",
    "_______________ and I go way back.",
    "I don't like _______________ one bit."
  ],
}
Klass.create(name: "Generic Class", klass_data:simpleKlassData)
moreKlassData = {
  name:"Another Class",
  names:[
    {
      name: "Dwarf",
      options: ["Barry", "Daelwyn", "Feliana", "Damarra", "Sistranalle", "Pendrell", "Melliandre", "Dagoliir"]
    },
    {
      name: "Human",
      options: ["Baldric", "Leena", "Dunwick", "Willem", "Edwyn", "Florian", "Seraphine", "Quorra", "Charlotte", "Lily", "Ramonde", "Cassandra"]
    }
  ],
  looks: [
    {
      name: "eyes",
      options:[
        "Knowing Eyes", "Fiery Eyes", "Joyous Eyes"
      ]
    },
    {
      name: "hair",
      options: [
        "Bald", "Wild Hair", "Pointy Hat"
      ]
    },
    {
      name: "clothing",
      options:[
        "Finery", "Traveling Clothes", "Poor Clothes"
      ]
    },
    {
      name: "etc",
      options:[
        "Fit Body", "Well-fed Body", "Thin Body"
      ]
    }
  ],
  baseHP:6,
  baseDMG:6,
  baseLoad:9,
  races: [
    {
      name: "Dwarf",
      text:"Gruff dwarf."
    },
    {
      name: "Human",
      text:"Boring human."
    }
  ],
  alignment: [
    {
      name:"Good",
      text:"Aid someone else."
    },
    {
      name:"Neutral",
      text:"Avoid a conflict."
    },
    {
      name:"Lawful",
      text:"Obey the code."
    }
  ],
  bonds: [
    "The last time I saw _______________ did not end well.",
    "I think _______________ is super cool.",
    "_______________ and I go way back.",
    "I don't like _______________ one bit."
  ],
}
Klass.create(name: "Another Class", klass_data:moreKlassData)
