const eventModel = require('../modules/event_model');
const calendarModel = require("../models/calendar_model")
const express = require('express');
const router = express.Router();

//add new event to calender
router.post("/event/create/:calenderid", getEventList);

async function getEventList(req, res, next) {
    const calenderid = req.params.calenderid;
    const data = req.body;

    try {
        const calender = await calendarModel.get(calenderid);
        if (!calender) return res.sendStatus(404);

        const result = await eventModel.create(data);
        if (!result) return res.sendStatus(409);

        calender.eventList.push(result.id);
        const updateCaleder = await calendarModel.update()
    } catch (e) {
        return next(e);
    }
};

router.post("/", async (req, res, next) => {
    try {
        const result = await eventModel.create(req.body);
        if (!result) return res.sendStatus(409);
        return res.status(201).json(result);
    } catch (e) {
        return next(e);
    }
});

router.get("/event", async (req, res, next) => {
    try {
        const result = await eventModel.get();
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});

router.get("/:id", async (req, res, next) => {
    try {
        const result = await eventModel.getById(req.params.id);
        if (!result) return res.sendStatus(404);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});


router.delete("/:id", async (req, res, next) => {
    try {
        const result = await eventModel.delete(req.params.id);
        if (!result) return res.sendStatus(404);
        return res.sendStatus(200);
    } catch (e) {
        return next(e);
    }
});

router.patch("/:id", async (req, res, next) => {
    try {
        const id = req.params.id;
        const data = req.body;

        const doc = await eventModel.getById(id);
        if (!doc) return res.sendStatus(404);

        // Merge existing fields with the ones to be updated
        Object.keys(data).forEach((key) => (doc[key] = data[key]));

        const updateResult = await eventModel.update(id, doc);
        if (!updateResult) return res.sendStatus(404);

        return res.json(doc);
    } catch (e) {
        return next(e);
    }
});

router.put("/:id", async (req, res, next) => {
    try {
        const updateResult = await eventModel.update(req.params.id, req.body);
        if (!updateResult) return res.sendStatus(404);

        const result = await eventModel.getById(req.params.id);
        return res.json(result);
    } catch (e) {
        return next(e);
    }
});

module.exports = router;