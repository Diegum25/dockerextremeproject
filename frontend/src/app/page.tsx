import Image from "next/image";
import Link from "next/link";

export default function Home() { 
  return (
    <>
      <main className="flex justify-center items-center min-h-screen w-full">
        <div className="animate-spin [animation-duration:3s] duration-1000 text-4xl select-none text-black/0 hover:text-black/65 transition-colors ease-in-out font-mono **:text-center">
          hi
        </div>
      </main>
    </>
  );
}
