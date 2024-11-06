db.students.insertMany([
    {
        "name": "Alice",
        "age": 21,
        "subjects": ["Math", "Science", "English"],
        "address": { "street": "123 Elm Street", "city": "Wonderland", "zip": "12345" },
        "grades": [
            { "subject": "Science", "score": 95 },
            { "subject": "English", "score": 93 }
        ]
    },
    {
        "name": "Charlie",
        "age": 22,
        "subjects": ["Physics", "Chemistry", "Math"],
        "address": { "street": "789 Maple Road", "city": "Funland", "zip": "11223" },
        "grades": [
            { "subject": "Physics", "score": 91 },
            { "subject": "Chemistry", "score": 89 },
            { "subject": "Math", "score": 84 }
        ]
    },
    {
        "name": "Bob",
        "age": 23,
        "subjects": ["History", "Math", "Art"],
        "address": { "street": "456 Oak Avenue", "city": "Dreamland", "zip": "67890" },
        "grades": [
            { "subject": "History", "score": 92 },
            { "subject": "Math", "score": 78 },
            { "subject": "Art", "score": 95 }
        ]
    }
])


db.students.aggregate([{$unwind:"$grades"},{$group:{_id: "$grades.subject", avgScore: { $avg: "$grades.score" }}}])

db.students.aggregate([{$project:{name:1,age:1,subjects:1,_id:0}}])

db.students.aggregate([{$match:{"address.city":"Wonderland"}}])

db.students.aggregate([{$sort:{age:-1}}])

db.students.aggregate([{$sort:{age:-1}},{$skip:1},{$limit:1}])

db.students.aggregate([{$unwind:"$grades"},{$group:{_id:"$grades.subject",totalScore:{$sum:"$grades.score"}}}])

db.students.aggregate([{ $unwind: "$grades" },{ $group: { _id: "$name", minScore: { $min: "$grades.score" } } }])

db.students.aggregate([{ $group: { _id: "$name", allSubjects: { $push: "$subjects" } } }])  


db.students.createIndex({ age: 1 })
db.students.createIndex({ name: 1, age: 1 })
db.students.createIndex({ name: 1 }, { unique: true })
db.students.find({ age: { $gt: 21 } }).explain("executionStats")
db.students.getIndexes()