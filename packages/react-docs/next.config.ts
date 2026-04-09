import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // The DS packages live as a workspace sibling; tell Next it's fine to
  // transpile them from source via webpack's resolve.
  transpilePackages: ["@aeros/react", "@aeros/tokens"],
  experimental: {
    // Allow loading CSS from workspace packages
    externalDir: true,
  },
};

export default nextConfig;
