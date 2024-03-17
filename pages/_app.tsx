import type { AppProps } from "next/app";
import { RainbowKitProvider } from "@rainbow-me/rainbowkit";
import { configureChains, createConfig, WagmiConfig } from "wagmi";
import celoGroups from "@celo/rainbowkit-celo/lists";
import Layout from "../components/Layout";
import "../styles/globals.css";
import "@rainbow-me/rainbowkit/styles.css";
import { publicProvider } from "wagmi/providers/public";
import { Alfajores, Celo } from "@celo/rainbowkit-celo/chains";


const projectId = 'dea8737a71e42ffa0374baa5e0b2b0d8' as string; // get one at https://cloud.walletconnect.com/app

const { chains, publicClient } = configureChains(
    [Celo, Alfajores],
    [publicProvider()]
);

const connectors = celoGroups({
    chains,
    projectId,
    appName:
        (typeof document === "object" && document.title) || "Your App Name",
});

const appInfo = {
    appName: "Celo Composer",
};

const wagmiConfig = createConfig({
    autoConnect: true,
    connectors,
    publicClient: publicClient,
});

function App({ Component, pageProps }: AppProps) {
    return (
        <WagmiConfig config={wagmiConfig}>
            <RainbowKitProvider
                chains={chains}
                appInfo={appInfo}
                coolMode={true}
            >
                <Layout>
                    <Component {...pageProps} />
                </Layout>
            </RainbowKitProvider>
        </WagmiConfig >
    );
}

export default App;
