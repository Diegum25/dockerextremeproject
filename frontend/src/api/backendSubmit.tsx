"use server"

import { InferHost } from "./host";


export async function submitCodeToBackend(formData : FormData) {
    const code = formData.get("code");

    const host = await InferHost()
    
    const backend = `http://${host}:${process.env.EXTREME_BACKEND_PORT}`;

    console.log(backend)

    const response = await fetch(backend,{method:'POST',body:code})

    //const responseData = await response.json() // It is not a json yet

    const responseText = await response.text()

    return responseText
}