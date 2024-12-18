import { buildResponse } from './utils/util.js';
import { register } from './services/registerService.js';
import { login } from './services/loginService.js';
import { verify } from './services/verifyService.js';

const HEALTH_PATH = '/health';
const REGISTER_PATH = '/register';
const LOGIN_PATH = '/login';
const VERIFY_PATH = '/verify';

export const handler = async (event) => {
    console.log('Request event: ', event);
    let response;
    switch (true) {
        case event.httpMethod === 'GET' && event.path === HEALTH_PATH:
            response = buildResponse(200, 'Success.');
            break;
        case event.httpMethod === 'POST' && event.path === REGISTER_PATH:
            const registerInfo = JSON.parse(event.body);
            response = await register(registerInfo);
            break;
        case event.httpMethod === 'POST' && event.path === LOGIN_PATH:
            const loginInfo = JSON.parse(event.body);
            response = await login(loginInfo);
            break;
        case event.httpMethod === 'POST' && event.path === VERIFY_PATH:
            const verifyInfo = JSON.parse(event.body);
            response = verify(verifyInfo);
            break;
        default:
            response = buildResponse(404, '404 Not Found.');
            break;
    }
    return response;
};
