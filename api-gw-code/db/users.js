import { DynamoDBClient, GetItemCommand, PutItemCommand } from "@aws-sdk/client-dynamodb";
import { marshall, unmarshall } from "@aws-sdk/util-dynamodb";

const dynamodb = new DynamoDBClient();
const userTable = 'learning-user-login';

export const createUser = async (user) => {
    const params = {
        TableName: userTable,
        Item: marshall(user),
    };

    try {
        const command = new PutItemCommand(params);
        const response = await dynamodb.send(command);
        return response; 
    } catch (error) {
        console.error("Error creating user:", error);
        throw error;
    }
};

export const getUser = async (username) => {
    const params = {
        TableName: userTable,
        Key: marshall({
            username: username
        }),
    };

    try {
        const command = new GetItemCommand(params);
        const response = await dynamodb.send(command);

        if (response.Item) {
            return unmarshall(response.Item);
        } else {
            return null;
        }
    } catch (error) {
        console.error("Error getting user:", error);
        throw error;
    }
};
