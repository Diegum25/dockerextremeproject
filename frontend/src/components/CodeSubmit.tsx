"use client"

import { submitCodeToBackend } from "@/api/backendSubmit";
import { useState } from "react";

export default function CodeSubmit(){

    const defaultText = `#include <stdio.h>\nint main(){\n\tprintf("yo wasup\\n")\n}`
    const text = ""
    const [currentText, textSetter] = useState(text)

    async function handleSubmit(event : React.SubmitEvent<HTMLFormElement>){
        event.preventDefault();

        const formData = new FormData(event.currentTarget);

        const response = await submitCodeToBackend(formData);

        const stdout = response.output.stdout
        const stderr = response.output.stderr

        if (response.status != "compiled"){
            textSetter(stderr)
        }else{
            textSetter(stdout)
        }
    }

    return(
        <>
            <h1>{currentText}</h1>
            <form method="post" onSubmit={handleSubmit}>
                <textarea className=" resize-none " name="code" defaultValue={defaultText}></textarea>
                <br />
                <button type="submit" className="">submit</button>
            </form>
        </>
    )
}