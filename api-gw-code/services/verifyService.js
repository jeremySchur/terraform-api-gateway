import { validateAccessToken } from "../utils/auth.js";
import { buildResponse } from "../utils/util.js";

export const verify = (userInfo) => {
    try {
        const { username, authToken } = userInfo;

        if (!username || !authToken) {
            return buildResponse(401, { message: 'All fields are required.' });
        }

        const verified = validateAccessToken(username, authToken);

        if (!verified) {
            return buildResponse(403, { message: 'Forbidden.' });
        }

        return buildResponse(200, { message: 'Verified.' });
    }
    catch (error) {
        console.error("Error during access token verification:", error);
        return buildResponse(500, { message: 'Server Error. Please try again later.' });
    }
};