import { getUser } from '../db/users.js';
import { buildResponse } from '../utils/util.js';
import bcrypt  from 'bcryptjs';
import { generateAccessToken } from '../utils/auth.js';

export const login = async (userInfo) => {
    try {
        const { username, password } = userInfo;

        if (!username || !password) {
            return buildResponse(401, { message: 'All fields are required.' });
        }

        const userExists = await getUser(username);
        if (!userExists) {
            return buildResponse(401, { message: 'User does not exist.' });
        }

        if (!bcrypt.compareSync(password, userExists.password)) {
            return buildResponse(401, { message: 'Password is incorrect.' });
        }

        const authToken = generateAccessToken(userExists.username);

        return buildResponse(200, {
            name: userExists.name,
            email: userExists.email,
            username: userExists.username,
            authToken: authToken
        });
    }
    catch (error) {
        console.error("Error during user login:", error);
        return buildResponse(500, { message: 'Server Error. Please try again later.' });
    }
};