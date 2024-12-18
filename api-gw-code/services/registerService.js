import { getUser, createUser } from '../db/users.js';
import { buildResponse } from '../utils/util.js';
import bcrypt  from 'bcryptjs';

export const register = async (userInfo) => {
    try {
        const { name, email, username, password } = userInfo;

        if (!name || !email || !username || !password) {
            return buildResponse(401, { message: 'All fields are required.' });
        }

        const userExists = await getUser(username);
        if (userExists) {
            return buildResponse(409, { message: 'Username already exists.' });
        }

        const encryptedPW = bcrypt.hashSync(password, 10);
        const user = {
            name,
            email,
            username,
            password: encryptedPW,
        };

        const saveUserResponse = await createUser(user);
        if (!saveUserResponse) {
            return buildResponse(503, { message: 'Server Error. Please try again later.' });
        }

        return buildResponse(201, { message: "Registration successful." });
    } catch (error) {
        console.error("Error during user registration:", error);
        return buildResponse(500, { message: 'Server Error. Please try again later.' });
    }
};

