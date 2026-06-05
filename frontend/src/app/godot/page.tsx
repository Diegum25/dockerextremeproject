import { checkForGame } from "./checkGame";

export default async function page(){

    const gameExists = await checkForGame()

    if (gameExists){
        return(<>
            <iframe src="/godot-game/index.html" title="godot game" allow="autoplay; fullscreen; xr-spatial-tracking" className="h-screen w-screen"></iframe>
        </>)
    }else{
        return(<>
            <p>There was no game</p>
        </>)
    }    
}