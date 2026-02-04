import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  allowedDevOrigins: [
    "tba.tully-dev.com"
  ],
  devIndicators: false,
  reactCompiler: true,
};

export default nextConfig;
