"use server"

import { InferHost } from "./host";


export async function submitCodeToBackend(formData : FormData) {
    const code = formData.get("code");

    const host = await InferHost()
    
    const backend = `http://${host}:${process.env.EXTREME_BACKEND_PORT}`;

    const response = await fetch(backend+"/code",{method:'POST',body:code,headers:[['content-type','text/plain']]})

    const responseData = await response.json() // It is not a json yet

    return responseData
}