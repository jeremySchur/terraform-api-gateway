import jwt from 'jsonwebtoken';

const JWT_ACCESS_SECRET = process.env.JWT_ACCESS_SECRET;

export const generateAccessToken = (username) => {
    try {
        return jwt.sign({username: username}, JWT_ACCESS_SECRET, { expiresIn: '1d' });
    }
    catch (error) {
        console.log("Error generating access token: ", error);
        throw error;
    }
};

export const validateAccessToken = (username, authToken) => {
    try {
        const decoded = jwt.verify(authToken, JWT_ACCESS_SECRET);
        return decoded.username === username ? true : false;
    }
    catch (error) {
        console.log("Error validating access token: ", error);
        throw error;
    }
};