db.students,insertMany([
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

db.students.mapReduce(
	function(){emit(this.name,this.subjects.length);},
	function(key,values){return Array.sum(values);},
	{out : "sub_cnt_per_stud"}
)

db.students.mapReduce(
	function(){this.grades.forEach(grade => emit(this.name, grade.score));},
	function(key,values){return Array.avg(values);},
	{out : "avg_score_per_stud"}
)

db.students.mapReduce(
	function(){emit(this.address.city,1);},
	function(key,values){return Array.sum(values);},
	{out : stud_cnt_per_city}
)

db.students.mapReduce(
    function() { 
        this.grades.forEach(grade => emit(grade.subject, { name: this.name, score: grade.score }));
    },
    function(key, values) {
        return values.reduce((max, current) => current.score > max.score ? current : max);
    },
    {
        out: "top_students_per_subject",
        -- sort: { "grades.score": -1 },
        -- limit: 10
    }
)
db.top_students_per_subject.find().sort({ "value.score": -1 }).limit(10);