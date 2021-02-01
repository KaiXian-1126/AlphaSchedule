const userModel = require("../models/user_model")
const express = require("express");
const router = express.Router();

//For add new user
router.post("/create", createUser);
//For get user list
router.get('/', getUserList);
//dekete user by id
router.delete("/delete/:id", deleteUser);
//update user by id
router.patch("/:id", updateUser);
//get user by id
router.get("/:id", getUser);

async function createUser(req, res, next) {
    const data = req.body;
    try {
        const result = await userModel.create(data);
        if (!result) return res.sendStatus(409);
        return res.status(201).json(result);
    } catch (e) {
        return next(e);
    }
}
async function getUserList(req, res, next) {
    try {
        const result = await userModel.getList();
        return res.json(result);
    } catch (e) {
        return next(e);
    }
}
// Get one user
async function getUser(req, res, next) {
    try {
        const result = await userModel.getById(req.params.id);
        if (!result) return res.sendStatus(404);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
};

// Delete a user
async function deleteUser(req, res, next) {
    try {
        const result = await userModel.delete(req.params.id);
        if (!result) return res.sendStatus(404);
        return res.sendStatus(200);
    } catch (e) {
        return next(e);
    }
}

// Update a user
async function updateUser(req, res, next) {
    try {
        const id = req.params.id;
        const data = req.body;

        const doc = await userModel.getById(id);
        if (!doc) return res.sendStatus(404);

        // Merge existing fields with the ones to be updated
        Object.keys(data).forEach((key) => (doc[key] = data[key]));

        const updateResult = await userModel.update(id, doc);
        if (!updateResult) return res.sendStatus(404);

        return res.json(doc);
    } catch (e) {
        return next(e);
    }
};

module.exports = router;