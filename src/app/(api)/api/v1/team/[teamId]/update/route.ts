import { NextResponse } from "next/server";


export async function GET(request: Request){
    const data = await request.json();

    console.log(data);
    
    return NextResponse.json({ status: "success" });
}