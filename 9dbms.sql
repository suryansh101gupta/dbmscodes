 db.createCollection("students")

 db.students.insertMany([
 {
 name : "Alice",
 age : 20,
 subjects : ["Math","Science","English"],
 address : { street: "123 Elm Street" , city: "Wonderland" , zip: "12345" },
 grades : [{subject:"Math",score:85} , {subject:"Science",score:90} , {subject:"English",score:88}]
 },
{
 name : "Bob",
 age : 22,
 subjects : ["History","Math","Art"],
 address : { street: "456 Oak Avenue" , city: "Dreamland" , zip: "67890" },
 grades : [{subject:"History",score:92} , {subject:"Math",score:78} , {subject:"Art",score:95}]
 }
])

1. CREATE - Insert a New Document

db.students.insertOne({
    name: "Charlie",
    age: 21,
    subjects: ["Physics", "Chemistry", "Math"],
    address: {
        street: "789 Maple Road",
        city: "Funland",
        zip: "11223"
    },
    grades: [
        { subject: "Physics", score: 91 },
        { subject: "Chemistry", score: 89 },
        { subject: "Math", score: 84 }
    ]
})

db.students.find({ subjects: "Math" }).pretty()

db.students.find({"address.city" : "Wonderland", "grades" : {$elemMatch : {subject:"Science" , score:{$gte:90}}}}).pretty()

db.students.find({age:{$gt:20},$or:[{subjects:"Physics"},{subjects:"Art"}]})

db.students.find({}, { name: 1, age: 1, _id: 0 }).pretty()

db.students.find().sort({ age: -1 }).limit(2)

db.students.find({ name: { $regex: /^A/ } }).pretty()

db.students.updateOne({name:"Alice","grades.subject":"Math"},{$set:{"grades.$.score":95}})

db.students.updateOne({name: "Bob"},{$addToSet: { subjects: "Philosophy" }})

db.students.updateMany({}, { $inc: { age: 1 } })

db.students.updateOne({ name: "Alice" },{ $inc: { "grades.$[].score": 5 } })

db.students.updateMany({}, { $rename: { "address.zip": "address.zipcode" } })

db.students.remove({"grades":$elemMatch : {subject:"Math", score:{$lt:80}}})

db.students.updateOne({ name: "Alice" },{ $pull: { grades: { subject: "Math" } } })

db.students.find({subjects:"Math",$or:[{"address.city":"Wonderland"},{"address.city":"Dreamland"}]}).pretty()

db.students.find({age:{$lt:23},grades:{$elemMatch:{score:{$gt:85}}}}).pretty()

db.students.find({"address.city": { $not: { $eq: "Dreamland" } }}).pretty()