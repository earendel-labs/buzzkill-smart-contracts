-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil deployBuzzkill

DEFAULT_ANVIL_KEY := 0x0

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.0.11 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network tomochain,$(ARGS)),--network tomochain)
	NETWORK_ARGS := --rpc-url $(TOMO_RPC_URL) --private-key $(PRIVATE_KEY) --legacy --broadcast --verify --etherscan-api-key $(VICTION_API_KEY) -vvvv
endif

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deployBuzzkill:
	@forge script script/DeployBuzzkill.s.sol:DeployBuzzkill $(NETWORK_ARGS)

deployHoney:
	@forge script script/DeployHoney.s.sol:DeployHoney $(NETWORK_ARGS)

deployHiveVault:
	@forge script script/DeployHiveVault.s.sol:DeployHiveVaultV1 $(NETWORK_ARGS)

deployBeeSkills:
	@forge script script/DeployBeeSkills.s.sol:DeployBeeSkills $(NETWORK_ARGS)

mint:
	@forge script script/interactions.s.sol:MintNFT $(NETWORK_ARGS)

# These two commands are the exact same:
# $ forge script script/DeployBuzzkill.s.sol:DeployBuzzkill --rpc-url $TOMO_RPC_URL --private-key $PRIVATE_KEY --legacy --broadcast --verify --etherscan-api-key $(VICTION_API_KEY) -vvvv
# $ make deployBuzzkill ARGS="--network tomochain"

# Minting
# cast send 0x1a8987e126B572c3De795180A86fCAb643543f92 "mintTo(address)" <To address> --private-key 0xac361b57907c5f34bfaef8dc2edb52d0cc68a0388e0d3afe0336db761dea26ec --rpc-url https://rpc.testnet.tomochain.com --value 1ether --legacy

# Cast call example
# cast call <CALLING CONTRACT ADDRESS> <FUNCTION SIG> <ARGUMENTS> <RPC URL> --legacy
# cast call 0x1a8987e126B572c3De795180A86fCAb643543f92 "ownerOf(uint256)" 2 --rpc-url https://rpc.testnet.tomochain.com --legacy
# Cast send example
# cast send <CALLING CONTRACT ADDRESS> <FUNCTION SIG> <ARGUMENTS> <RPC URL> <PRIVATE KEY> --legacy
# cast send 0x9f2ae804Ae4A496A4F71ae16a509A67a151Ab787 "setControllers(address, bool)" 0x637D7Ea1f3271cC58DBBbC5585F24D26a9010931 true --rpc-url $TOMO_RPC_URL --private-key $PRIVATE_KEY --legacy