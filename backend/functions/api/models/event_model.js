const database = require("../database");

class EventModel {
    constructor() {
        if (this.instance) return this.instance;
        EventModel.instance = this;
    }

    get() {
        return database.getList("event");
    }

    getById(id) {
        return database.get("event", id);
    }

    create(document) {
        return database.create("event", document);
    }

    delete(id) {
        return database.delete("event", id);
    }

    update(id, document) {
        return database.set("event", id, document);
    }
}

module.exports = new EventModel();