const Room = require('../model/Room');

const bookRoom = async (req, res) => {   //create
    try {
        const { roomNumber, purpose, clubName } = req.body;
        const userId = req.user.id;
        let room = await Room.findOne({ roomNumber });
        if (room) {
            return res.status(400).json({ message: 'Room already booked with this room number' });
        }
        room = new Room({
            roomNumber,
            purpose,
            clubName,
            userId
        });
        await room.save();
        res.status(200).json(room);
    } catch (error) {
        console.log("There is an error", error);
        res.status(500).json({ message: 'server error' })
    }
}

const viewBookings = async (req, res) => {   //read
    try {
        const query = req.user.role === 'admin' ? {} : { userId: req.user.id };
        const rooms = await Room.find(query).populate('userId', ['username', 'email']);
        res.status(200).json(rooms);
    } catch (error) {
        console.log("There is an error", error);
        res.status(500).json({ message: 'server error' })
    }
}

module.exports = { bookRoom, viewBookings };