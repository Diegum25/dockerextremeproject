import type { NextConfig } from "next";


const nextConfig: NextConfig = {
  async headers() {
    return [
      {
        // Apply these headers ONLY to the Godot static assets
        source: '/godot-game/:path*',
        headers: [
          {
            key: 'Cross-Origin-Opener-Policy',
            value: 'same-origin',
          },
          {
            key: 'Cross-Origin-Embedder-Policy',
            value: 'require-corp',
          },
        ],
      },
      {
        // Apply them to the specific Next.js page route as well
        source: '/godot',
        headers: [
          {
            key: 'Cross-Origin-Opener-Policy',
            value: 'same-origin',
          },
          {
            key: 'Cross-Origin-Embedder-Policy',
            value: 'require-corp',
          },
        ],
      },
    ];
  },
};

export default nextConfig;