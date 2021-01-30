class Database {
    constructor() {
        if (this.instance) return this.instance;
        Database.instance = this;

        const admin = require("firebase-admin");
        admin.initializeApp({ credential: admin.credential.applicationDefault() });
        this.firestore = admin.firestore();
    }

    //Create
    async create(collection, document) {
        const result = await this.firestore.collection(collection).add(document);
        document.id = result.id;
        return document;
    }
    //Read
    async getList(collection) {
        const result = await this.firestore.collection(collection).get()

        const list = []
        result.forEach((doc) => {
            const data = doc.data()
            data.id = doc.id
            list.push(data)
        })
        return list.length ? list : null
    }

    async get(collection, id) {
        const result = await this.firestore.collection(collection).doc(id).get()
        if (!result.exists) return null  // Record not found

        const doc = result.data()
        doc.id = result.id
        return doc
    }
    //Update
    async set(collection, id, document) {
        const doc = this.firestore.collection(collection).doc(id)
        const result = await doc.get()

        if (!result.exists) return null  // Record not found

        await doc.set(document)

        document.id = id
        return document
    }
    //Delete
    async delete(collection, id) {
        const doc = this.firestore.collection(collection).doc(id)
        const result = await doc.get()

        if (!result.exists) return null // Record not found

        await doc.delete()

        return { id }
    }
}

module.exports = new Database();