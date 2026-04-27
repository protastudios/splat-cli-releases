# Splat CLI Command Catalog

This file is generated from `splat --json commands`.

Regenerate it from `splat-trading-backend` with:

```bash
bun run skill:sync-commands
```

Generated command count: 85.

## api

### splat api get <path>

Call a backend GET route directly

Auth required: no.

Examples:

```bash
splat api get /health
```

### splat api post <path> [jsonBody]

Call a backend POST route directly

Auth required: no.

Examples:

```bash
splat api post /order/create-perp-position '{"assetIndex":0,"assetName":"BTC","price":50000.5,"size":"1.5","vaultAddress":"0xabc","isLong":true}'
```

### splat api patch <path> [jsonBody]

Call a backend PATCH route directly

Auth required: no.

Examples:

```bash
splat api patch /order/update-tpsl '{"coin":"BTC","isBuy":true,"position":"1","takeProfitPrice":60000,"stopLossPrice":48000}'
```

### splat api delete <path> [jsonBody]

Call a backend DELETE route directly

Auth required: no.

Examples:

```bash
splat api delete /platform/api-tokens '{"apiTokenId":"api_token_123"}'
```

## account

### splat account open-orders [userAddress]

Fetch open orders for the authenticated Hyperliquid wallet or an override

Auth required: yes.

Examples:

```bash
splat account open-orders
splat account open-orders 0xuser
```

### splat account spot-balances [userAddress]

Fetch spot balances for the authenticated Hyperliquid wallet or an override

Auth required: yes.

Examples:

```bash
splat account spot-balances
splat account spot-balances 0xuser
```

### splat account perp-balance [userAddress]

Fetch current perp account value for the authenticated Hyperliquid wallet or an override

Auth required: yes.

Examples:

```bash
splat account perp-balance
splat account perp-balance 0xuser
```

### splat account portfolio [userAddress]

Fetch Hyperliquid portfolio history for the authenticated wallet or an override

Auth required: yes.

Examples:

```bash
splat account portfolio
splat account portfolio 0xuser
```

## transfers

### splat transfers spot-perp <amount> <toPerp>

Create a spot-perp transfer instruction

Auth required: no.

Examples:

```bash
splat transfers spot-perp 1000 true
```

### splat transfers usdc <amount> <destination>

Create a USDC transfer instruction

Auth required: no.

Examples:

```bash
splat transfers usdc 1000 0xrecipient
```

### splat transfers spot-asset <ticker> <amount> <destination>

Create a spot asset transfer instruction

Auth required: no.

Examples:

```bash
splat transfers spot-asset UBTC 10 0xrecipient
```

## orders

### splat orders perp open <assetIndex> <assetName> <price> <size> <isLong> [--market] [--vault <address>]

Create a perpetual order with explicit CLI arguments

Auth required: no.

Examples:

```bash
splat orders perp open 0 BTC 50000.5 1.5 true --market --vault 0xabc
```

### splat orders perp execute <assetIndex> <assetName> <price> <size> <isLong> [--market] [--vault <address>]

Stage a perpetual order for explicit CLI confirmation and backend submission

Auth required: no.

Examples:

```bash
splat orders perp execute 0 BTC 50000.5 1.5 true --market
```

### splat orders perp close <assetIndex> <assetName> <price> <size> <userAddress> <isLong> [--market] [--vault <address>] [--leverage <n>]

Close a perpetual position with explicit CLI arguments

Auth required: no.

Examples:

```bash
splat orders perp close 0 BTC 51000.25 1.5 0xuser true --market
```

### splat orders spot create <assetName> <buy|sell> <usdAmount> <price> [--market] [--vault <address>]

Create a spot order with explicit CLI arguments

Auth required: no.

Examples:

```bash
splat orders spot create UBTC buy 1000 1000 --market
```

### splat orders spot execute <assetName> <buy|sell> <usdAmount> <price> [--market] [--vault <address>]

Stage a spot order for explicit CLI confirmation and backend submission

Auth required: no.

Examples:

```bash
splat orders spot execute UBTC buy 5 1000 --market
```

### splat orders cancel <assetTicker> <orderId> <perp|spot> [--vault <address>]

Cancel an existing perp or spot order

Auth required: no.

Examples:

```bash
splat orders cancel BTC 1234 perp
```

### splat orders pending|show|confirm

Inspect and confirm staged Hyperliquid executions

Auth required: no.

Examples:

```bash
splat orders pending
splat orders show splat_exec_123
splat orders confirm splat_exec_123
```

### splat orders builder-fee check [userAddress] [builderAddress]

Check the Hyperliquid builder fee approval for a wallet

Auth required: yes.

Examples:

```bash
splat orders builder-fee check
```

### splat orders builder-fee approve|execute

Create or stage a Hyperliquid builder fee approval

Auth required: no.

Examples:

```bash
splat orders builder-fee execute
```

### splat orders tpsl create|execute <assetId> <isLong> <currentPositionSize> [--tp <price>] [--sl <price>] [--tp-size <size>] [--sl-size <size>] [--vault <address>]

Create or stage take-profit and stop-loss orders

Auth required: no.

Examples:

```bash
splat orders tpsl execute 0 true 1.5 --tp 60000 --sl 48000
```

### splat orders tpsl cancel|cancel-execute <assetId> <orderId1,orderId2,...> [--vault <address>]

Create or stage TP/SL cancellation orders

Auth required: no.

Examples:

```bash
splat orders tpsl cancel-execute 0 123,456
```

## rewards

### splat rewards unclaimed <userId>

Fetch unclaimed reward totals for a backend user

Auth required: no.

Examples:

```bash
splat rewards unclaimed user_123
```

### splat rewards claimed <userId>

Fetch claimed reward totals for a backend user

Auth required: no.

Examples:

```bash
splat rewards claimed user_123
```

### splat rewards total <userId>

Fetch total reward totals for a backend user

Auth required: no.

Examples:

```bash
splat rewards total user_123
```

### splat rewards summary <userId>

Fetch claimed, unclaimed, and total reward summaries together

Auth required: no.

Examples:

```bash
splat rewards summary user_123
```

### splat rewards staking-vault

Fetch staking vault APY data

Auth required: no.

Examples:

```bash
splat rewards staking-vault
```

### splat rewards staking-earnings <userAddress> [timeWindow]

Fetch staking earnings for a wallet, optionally filtered by a window like 30d

Auth required: no.

Examples:

```bash
splat rewards staking-earnings wallet_123 30d
```

### splat rewards claim-solana [userId]

Claim unclaimed SOL rewards by signing a claim message with the CLI trading credential

Auth required: yes.

Examples:

```bash
splat rewards claim-solana
```

### splat rewards claim-hyperliquid [userId]

Claim unclaimed Hyperliquid USDC rewards by signing a claim message with the CLI trading credential

Auth required: yes.

Examples:

```bash
splat rewards claim-hyperliquid
```

## bridge

### splat bridge create <amount> <recipient> <sender>

Create a Solana-to-Arbitrum bridge transaction and return the payload token

Auth required: no.

Examples:

```bash
splat bridge create 100 0xrecipient SolanaSender
```

### splat bridge send <transaction> <userEvmAddress> <deadline> <signature> <balance> --payload-token <token>

Send a prepared bridge transaction using the payload token from bridge create

Auth required: no.

Examples:

```bash
splat bridge send BASE64_TX 0xuser 1712345678 0xsig 1000000 --payload-token bridge_token
```

### splat bridge arbitrum-to-hyperliquid <userEvmAddress> <deadline> <signature> <balance>

Create an Arbitrum-to-Hyperliquid bridge transaction

Auth required: no.

Examples:

```bash
splat bridge arbitrum-to-hyperliquid 0xuser 1712345678 0xsig 1000000
```

### splat bridge withdraw-arbitrum <amount> <userAddress> <signedMessage> <signature>

Create a Hyperliquid-to-Arbitrum withdrawal transaction

Auth required: no.

Examples:

```bash
splat bridge withdraw-arbitrum 100 wallet_123 message sig
```

### splat bridge create-quote <userAddress> <userSolAddress> <amount> <signedMessage> <signature>

Create a withdraw quote for Arbitrum-to-Solana withdrawal

Auth required: no.

Examples:

```bash
splat bridge create-quote wallet_123 SolanaWallet 100 message sig
```

### splat bridge withdraw-solana <quoteJson> <userAddress> <signedMessage> <signature>

Send an Arbitrum-to-Solana withdrawal using a serialized quote payload

Auth required: no.

Examples:

```bash
splat bridge withdraw-solana '{"quote":true}' wallet_123 message sig
```

### splat bridge poll <userAddress>

Poll withdrawal state for a user address

Auth required: no.

Examples:

```bash
splat bridge poll wallet_123
```

## user

### splat user get <id|email|evmAddress|solAddress> <identifier>

Fetch a user by id, email, EVM address, or Solana address

Auth required: no.

Examples:

```bash
splat user get id user_123
```

### splat user get-or-create <emailOrDash> <nameOrDash> <photoUrlOrDash> <connectedEvmOrDash> <connectedSolOrDash> <turnkeyEvm> <turnkeySol> <turnkeySolMeme> [referredByCodeOrDash]

Get or create a user using the backend user identity flow

Auth required: no.

Examples:

```bash
splat user get-or-create joe@example.com Joe - 0xwallet SolWallet 0xturnkey TurnkeySol TurnkeySolMeme
```

### splat user update-name <userId> <name>

Update a user's display name

Auth required: no.

Examples:

```bash
splat user update-name user_123 Joe
```

### splat user update-image <userId> <imageUrl>

Update a user's profile image URL

Auth required: no.

Examples:

```bash
splat user update-image user_123 https://example.com/avatar.png
```

### splat user update-referral <userId> <newReferralCode>

Update a user's referral code

Auth required: no.

Examples:

```bash
splat user update-referral user_123 SPLATCODE
```

### splat user upload-url

Create a one-time user profile upload URL

Auth required: no.

Examples:

```bash
splat user upload-url
```

### splat user leverage <assetTicker> <leverage>

Create a leverage update instruction

Auth required: no.

Examples:

```bash
splat user leverage ETH 5
```

## solana

### splat solana swap quote <inputMint> <outputMint> <amount>

Fetch a Solana swap quote

Auth required: no.

Examples:

```bash
splat solana swap quote EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v So11111111111111111111111111111111111111112 100000
```

### splat solana swap market <inputMint> <outputMint> <amount> <userAddress>

Build a market swap transaction for a Solana wallet

Auth required: no.

Examples:

```bash
splat solana swap market EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v So11111111111111111111111111111111111111112 100000 wallet_123
```

### splat solana swap execute <inputMint> <outputMint> <amount> <userAddress>

Build, sign, and submit a market swap with the delegated Turnkey CLI credential

Auth required: yes.

Examples:

```bash
splat solana swap execute So11111111111111111111111111111111111111112 SPLAT_MINT 10000 wallet_123
```

### splat solana swap submit <transaction> <userAddress>

Sign and submit a prepared Solana swap transaction with the delegated Turnkey CLI credential

Auth required: yes.

Examples:

```bash
splat solana swap submit <base58Transaction> wallet_123
```

### splat solana swap limit <inputMint> <outputMint> <makingAmount> <takingAmount> <userAddress>

Build a limit swap transaction for a Solana wallet

Auth required: no.

Examples:

```bash
splat solana swap limit EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v So11111111111111111111111111111111111111112 100000 98000 wallet_123
```

### splat solana swap limit-execute <inputMint> <outputMint> <makingAmount> <takingAmount> <userAddress>

Build, sign, and submit a Solana limit swap with the delegated Turnkey CLI credential

Auth required: yes.

Examples:

```bash
splat solana swap limit-execute EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v So11111111111111111111111111111111111111112 100000 98000 wallet_123
```

### splat solana swap limit-orders list <userAddress>

List active Solana limit orders for a wallet

Auth required: no.

Examples:

```bash
splat solana swap limit-orders list wallet_123
```

### splat solana swap limit-orders cancel <userAddress> <orderId1,orderId2,...>

Build, sign, and submit Solana limit order cancellation transactions

Auth required: yes.

Examples:

```bash
splat solana swap limit-orders cancel wallet_123 order_1,order_2
```

### splat solana tokens <userAddress>

List user token accounts for a Solana wallet

Auth required: no.

Examples:

```bash
splat solana tokens wallet_123
```

### splat solana pnl <walletAddress> [day|week|month|all]

Fetch Solana PnL data from the trading backend

Auth required: no.

Examples:

```bash
splat solana pnl wallet_123 week
```

### splat solana trading-history <userId>

Fetch Solana trading history by backend user id

Auth required: no.

Examples:

```bash
splat solana trading-history user_123
```

## commands

### splat commands

Show a structured catalog of CLI commands

Auth required: no.

Examples:

```bash
splat commands
splat --json commands
```

## doctor

### splat doctor

Check CLI config, API reachability, and scope endpoint availability

Auth required: no.

Examples:

```bash
splat doctor
splat --json doctor
```

## auth

### splat auth

Start first-party CLI login against the production platform by default

Auth required: no.

Examples:

```bash
splat auth
splat auth login --dev
```

### splat auth login [--prod|--dev|--staging] [--api-url <url>] [--web-url <url>] [--no-open] [--enable-trading]

Start first-party CLI login with production defaults, dev defaults, or explicit staging URLs

Auth required: no.

Examples:

```bash
splat auth login
splat auth login --dev
splat auth login --dev --enable-trading
splat auth login --staging --api-url https://api.staging.asksplat.com --web-url https://terminal.staging.asksplate.com
```

### splat auth firebase-login <idToken> <turnkeyEvmAddress> <turnkeySolanaAddress> <turnkeySolanaMemeAddress> [connectedEvmAddress] [connectedSolanaAddress]

Developer-only Firebase token exchange flow for local backend testing

Auth required: no.

Examples:

```bash
splat auth firebase-login FIREBASE_ID_TOKEN 0xTURNKEY_EVM TURNKEY_SOLANA TURNKEY_SOLANA_MEME
```

### splat auth save <token> [apiUrl]

Save an existing personal API token for CLI use

Auth required: no.

Examples:

```bash
splat auth save splat_pat_value https://api.asksplat.com
```

### splat auth status

Show whether local CLI auth is configured

Auth required: no.

Examples:

```bash
splat auth status
```

### splat auth logout

Clear saved local CLI auth

Auth required: no.

Examples:

```bash
splat auth logout
```

### splat auth token list

List personal API tokens using the saved or env-provided platform token

Auth required: yes.

Examples:

```bash
splat auth token list
```

### splat auth token create <label> <scope1,scope2,...>

Create a new personal API token

Auth required: yes.

Examples:

```bash
splat auth token create "Local Agent" profile:read,market-data:read
```

### splat auth token revoke <apiTokenId>

Revoke an existing personal API token

Auth required: yes.

Examples:

```bash
splat auth token revoke api_token_123
```

## me

### splat me

Show the current authenticated platform user

Auth required: yes.

Examples:

```bash
splat me
```

## market

### splat market tokens search <query> [skipHistoricalPrices]

Search market tokens through the platform API

Auth required: yes.

Examples:

```bash
splat market search SOL
splat market tokens search SOL
```

### splat market tokens get <address> [skipHistoricalPrices]

Fetch one market token by address

Auth required: yes.

Examples:

```bash
splat market tokens get SOLANA:So11111111111111111111111111111111111111112 true
```

### splat market candles get <address> [timeframe|timeframe1,timeframe2,...]

Fetch candle data for a market token

Auth required: yes.

Examples:

```bash
splat market candles get SOLANA:So11111111111111111111111111111111111111112 1m,5m
```

### splat market transactions list [key=value ...]

List market transactions with optional filters

Auth required: yes.

Examples:

```bash
splat market transactions list userAddress=wallet_123 limit=10
```

### splat market transactions get <hash>

Fetch one market transaction by hash

Auth required: yes.

Examples:

```bash
splat market transactions get tx_123
```

## portfolio

### splat portfolio solana-pnl [walletAddress]

Fetch Solana PnL graph data for the current or specified wallet

Auth required: yes.

Examples:

```bash
splat portfolio solana-pnl
```

## oauth

### splat oauth clients list

List the current user's OAuth clients

Auth required: yes.

Examples:

```bash
splat oauth clients list
```

### splat oauth clients create <name> <redirectUri1,redirectUri2,...> <scope1,scope2,...> <public|confidential>

Create a new OAuth client

Auth required: yes.

Examples:

```bash
splat oauth clients create "Local CLI Client" http://localhost:3333/callback profile:read,market-data:read confidential
```

### splat oauth authorize <clientId> <clientSecret|-> <redirectUri> <scope1,scope2,...> [state]

Create an authorization code for an OAuth client

Auth required: yes.

Examples:

```bash
splat oauth authorize CLIENT_ID - http://localhost:3333/callback profile:read
```

### splat oauth token client <clientId> <clientSecret|-> <scope1,scope2,...>

Exchange client credentials for an OAuth access token

Auth required: no.

Examples:

```bash
splat oauth token client CLIENT_ID CLIENT_SECRET profile:read
```

### splat oauth token code <clientId> <clientSecret|-> <code> <redirectUri>

Exchange an authorization code for access and refresh tokens

Auth required: no.

Examples:

```bash
splat oauth token code CLIENT_ID CLIENT_SECRET CODE http://localhost:3333/callback
```

### splat oauth token refresh <clientId> <clientSecret|-> <refreshToken>

Exchange a refresh token for a new access token

Auth required: no.

Examples:

```bash
splat oauth token refresh CLIENT_ID CLIENT_SECRET REFRESH_TOKEN
```

### splat oauth introspect <clientId> <clientSecret|-> <token>

Introspect an OAuth access token

Auth required: no.

Examples:

```bash
splat oauth introspect CLIENT_ID CLIENT_SECRET TOKEN
```

### splat oauth revoke <token>

Revoke an OAuth access or refresh token

Auth required: no.

Examples:

```bash
splat oauth revoke TOKEN
```

## agent

### splat agent signer init [label]

Create local agent signer key material and start browser pairing

Auth required: yes.

Examples:

```bash
splat agent signer init "Local Agent"
```

### splat agent grants list|revoke|update

Manage delegated agent signing grants

Auth required: yes.

Examples:

```bash
splat agent grants list
```

### splat agent trades prepare|list|approve|reject|payload|submit

Prepare, approve, inspect, and submit delegated agent trades

Auth required: yes.

Examples:

```bash
splat agent trades approve request_123
```

### splat agent run

Poll approved delegated trades and print signing payloads for the local signer

Auth required: yes.

Examples:

```bash
splat agent run
```
