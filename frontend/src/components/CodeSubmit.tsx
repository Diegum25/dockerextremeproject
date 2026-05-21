"use client"

import { submitCodeToBackend } from "@/api/backendSubmit";
import { useState } from "react";

export default function CodeSubmit(){

    const defaultText = `#include <stdio.h>\nint main(){\n\tprintf("yo wasup\\n");\n}`
    const text = ""
    const [currentText, textSetter] = useState(text)

    async function handleSubmit(event : React.SubmitEvent<HTMLFormElement>){
        event.preventDefault();
        textSetter("...")

        const formData = new FormData(event.currentTarget);

        const response = await submitCodeToBackend(formData);

        const stdout = response.output.stdout
        const stderr = response.output.stderr

        textSetter(`${response.status}, {${stdout}${stderr}}`)
    }

    return (
    <div className="max-w-3xl mx-auto mt-10 p-8 bg-white rounded-xl shadow-lg border border-gray-200">
        
        <h1 className="text-3xl font-extrabold text-gray-800 mb-6 tracking-tight">
            {currentText || "Submit Your Code"}
        </h1>
        
        <form method="post" onSubmit={handleSubmit} className="flex flex-col gap-6">
            
            {/* Textarea disguised as a code editor */}
            <textarea 
                name="code" 
                defaultValue={defaultText}
                spellCheck="false"
                className="w-full h-80 p-5 font-mono text-sm text-gray-100 bg-gray-900 border border-gray-700 rounded-lg shadow-inner focus:ring-2 focus:ring-blue-500 focus:border-transparent focus:outline-none resize-y"
            ></textarea>
            
            {/* Call to action button aligned to the right */}
            <button 
                type="submit" 
                className="self-end px-8 py-3 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg shadow-md transition-all duration-200 active:transform active:scale-95"
            >
                Submit Code
            </button>
            
        </form>
    </div>
)
}