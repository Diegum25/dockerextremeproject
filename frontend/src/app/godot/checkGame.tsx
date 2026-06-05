"use server"

import { promises } from "node:fs"

export async function checkForGame() : Promise<boolean>{
    let exists
    try{
        await promises.access("public/godot-game/index.html");
        exists = true
    }catch{
        exists = false
    }
    return exists
}