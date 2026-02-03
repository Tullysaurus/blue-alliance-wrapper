import { NextResponse } from "next/server";
import { createHmac, timingSafeEqual } from "crypto";
import { ApiClient } from "tba-api-v3client";

function validateHMAC(payload: string, hmac: string | null): boolean {
    const secret = process.env.WEBHOOK_SECRET;

    if (!secret) {
        console.error("WEBHOOK_SECRET is not defined in environment variables.");
        return false;
    }
    if (!hmac) {
        return false;
    }

    console.log("Received HMAC:", hmac);

    const calculated = createHmac("sha256", secret).update(payload, "utf8").digest("hex");
    console.log("Calculated HMAC:", calculated);

    try {
        const a = Buffer.from(calculated, "hex");
        const b = Buffer.from(hmac, "hex");

        // Prevent timing attacks; lengths must match for timingSafeEqual

        if (a.length !== b.length) return false;
        return timingSafeEqual(a, b);
    } catch (err) {

        // If header isn't valid hex or other error, fallback to simple compare
        return calculated === hmac;
    }
}

function validateData(data: any): boolean {
    // Implement data validation logic here
    return true;
}

function processWebhookData(data: any) {
    // Implement webhook data processing logic here
}


export async function POST(request: Request) {
    // Read raw payload so HMAC is computed identical to sender's payload bytes
    const payload = await request.text();
    const X_TBA_HMAC = request.headers.get("X-TBA-HMAC");

    if (!validateHMAC(payload, X_TBA_HMAC)) {
        return NextResponse.json({ status: "invalid HMAC" }, { status: 400 });
    }

    let data: any;
    try {
        data = JSON.parse(payload);
    } catch (err) {
        return NextResponse.json({ status: "invalid JSON" }, { status: 400 });
    }

    if (!validateData(data)) {
        return NextResponse.json({ status: "invalid data" }, { status: 400 });
    }

    processWebhookData(data);

    return NextResponse.json({ status: "success" });
}
