const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class EventModel {
    constructor() {
        if (this.instance) return this.instance;
        TodoModel.instance = this;
    }

    get() {
        return database.getList("event");
    }

    getById(id) {
        return database.get("event", id);
    }

    create(todo) {
        return database.create("event", todo);
    }

    delete(id) {
        return database.delete("event", id);
    }

    update(id, todo) {
        return database.set("event", id, todo);
    }
}

module.exports = new EventModel();