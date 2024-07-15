const User = require('../model/User');
var bcrypt = require('bcryptjs');
require('dotenv').config();
const jwt = require('jsonwebtoken');

const signToken = (id) => {
    return jwt.sign({ id }, process.env.SECRET_STR);
}

const signup = async (req, res) => {   //create
    try {
        const { username, email, password } = req.body;
        let user = await User.findOne({ email });
        if (user) {
            return res.status(400).json({ message: 'User already exists' });
        }
        const hashedPassword = await bcrypt.hash(password, 12)
        user = new User({
            username,
            email,
            password: hashedPassword
        });
        await user.save();
        const token = signToken(user._id);
        res.status(200).json({ user, token });
    } catch (error) {
        console.log("There is an error", error);
        res.status(500).json({ message: 'server error' })
    }
}

const login = async (req, res) => {   //create
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email }).select('+password');
        if (!user) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }
        const matchPassword = await bcrypt.compare(password, user.password);
        if (!matchPassword) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }
        const token = signToken(user._id);
        res.status(200).json({ message: 'Login Success', token });
    } catch (error) {
        console.log("There is an error", error);
        res.status(500).json({ message: 'server error' })
    }
}

const verifyUser = async (req, res, next) => {      //middleware to check whether user has loggined or not
    const userToken = req.headers.authorization;
    if (userToken) {
        const token = userToken.split(' ')[1];
        jwt.verify(token, process.env.SECRET_STR, async (err, decodedToken) => {
            if (err) {
                return res.status(403).json({ error: "Token is not valid" });
            }
            try {
                const user = await User.findById(decodedToken.id).select('-password');
                if (!user) {
                    return res.status(401).json({ message: 'User not found' });
                }
                req.user = user;
                next();
            } catch (error) {
                console.error(error);
                res.status(500).json({ message: 'Server error' });
            }
        });
    } else {
        return res.status(401).json({ message: 'No token, authorization denied' });
    }
}

module.exports = { signup, login, verifyUser };
