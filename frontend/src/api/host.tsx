"use server"

export async function InferHost(){ // dumb
    if (process.env.EXTREME_HOST_DOCKER == '1'){
        return "backend"
    }else{
        return "localhost"
    }
}