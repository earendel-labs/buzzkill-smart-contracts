// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../contracts/helper/BuzzkillAddressProvider.sol";
import "../contracts/helper/GameConfig.sol";
import "../contracts/helper/HoneyDistribution.sol";

import "../contracts/Honey.sol";
import "../contracts/BuzzkillNFT.sol";
import "../contracts/Hive.sol";
import "../contracts/HiveFactory.sol";
import "../contracts/WorldMap.sol";

contract NormalFlowTest is Test {
    uint256 public constant MINT_FEE = 1 ether;
    address owner = address(1234);
    address user = address(5678);

    BuzzkillAddressProvider buzzkillAddressProvider;
    GameConfig gameConfig;
    Honey honey;
    BuzzkillNFT buzzkillNFT;
    HiveFactory hiveFactory;
    HoneyDistribution honeyDistribution;
    WorldMap worldMap;

    Hive hive;

    function setUp() public {
        vm.deal(owner, 100 ether);
        vm.deal(user, 10 ether);
        vm.startPrank(owner);

        // Deploy and initilize buzzkill address provider
        buzzkillAddressProvider = new BuzzkillAddressProvider();
        buzzkillAddressProvider.initialize();

        // Deploy and initilize game config contract
        gameConfig = new GameConfig();
        gameConfig.initialize();

        // Deploy honey contract
        honey = new Honey();

        // Deploy honey distribution contract
        honeyDistribution = new HoneyDistribution(
            address(buzzkillAddressProvider)
        );

        // Deploy hive factory contract
        hiveFactory = new HiveFactory(address(buzzkillAddressProvider));

        // Deploy buzzkill NFT contract
        buzzkillNFT = new BuzzkillNFT(
            MINT_FEE,
            address(hiveFactory),
            address(buzzkillAddressProvider)
        );

        // Deploy world map contract
        worldMap = new WorldMap(address(buzzkillAddressProvider));

        // Setting address
        buzzkillAddressProvider.setHoneyAddress(address(honey));
        buzzkillAddressProvider.setHiveFactoryAddress(address(hiveFactory));
        buzzkillAddressProvider.setWorldMapAddress(address(worldMap));
        buzzkillAddressProvider.setBuzzkillNFTAddress(address(buzzkillNFT));
        buzzkillAddressProvider.setHoneyDistributionAddress(
            address(honeyDistribution)
        );
        buzzkillAddressProvider.setGameConfigAddress(address(gameConfig));

        // Setting controller
        honey.setController(address(honeyDistribution), true);

        // Create a habitat
        worldMap.addHabitat(50, 30, 20, 2, 100);

        // Add a hive
        address newHiveAddress = hiveFactory.createHive(0);
        hive = Hive(newHiveAddress);

        vm.stopPrank();
        vm.startPrank(user);
        // Mint NFTs
        buzzkillNFT.mintTo{value: MINT_FEE}(user, 0); // Mint a worker bee, type of worker bee = 0, NFT has id = 0
        buzzkillNFT.mintTo{value: MINT_FEE}(user, 1); // Mint a queen bee, type of queen bee = 1, NFT has id = 1
        assertEq(address(buzzkillNFT).balance, MINT_FEE * 2);
        vm.stopPrank();
    }

    // Stake
    function stake() public {
        vm.startPrank(user);
        // Approve hive to transfer NFT
        buzzkillNFT.setApprovalForAll(address(hive), true);
        hive.stakeBee(0);
        hive.stakeBee(1);

        uint256 numQueens = hive.numQueens();
        uint256 numWorkers = hive.numWorkers();

        assertEq(numQueens, 1);
        assertEq(numWorkers, 1);

        vm.stopPrank();
    }

    // Honey test
    function testMint() public {
        vm.prank(owner);
        honey.mintTo(owner, 100);
    }

    function test_MintFail() public {
        vm.expectRevert("Controller: Caller is not the controller");
        honey.mintTo(owner, 100);
    }

    // Forage test
    function testForage() public {
        stake();
        vm.prank(user);
        hive.forage(0, 0); // Send the worker bee to forage at habitat id 0

        // Check the bee resources gathered from the habitat after foraging
        (, , , , , , uint256 nectar, uint256 pollen, uint256 sap) = buzzkillNFT
            .tokenIdToTraits(0);
        assertGe(nectar, 19);
        assertGe(pollen, 19);
        assertGe(sap, 19);

        console.log("Bee Nectar: ", nectar);
        console.log("Bee Pollen: ", pollen);
        console.log("Bee Sap: ", sap);

        // Check the hive resources after foraging
        (uint256 hiveNectar, uint256 hivePollen, uint256 hiveSap) = hive
            .getHiveResources();
        assertGe(hiveNectar, 1);
        assertGe(hivePollen, 1);
        assertGe(hiveSap, 1);

        console.log("Hive Nectar: ", hiveNectar);
        console.log("Hive Pollen: ", hivePollen);
        console.log("Hive Sap: ", hiveSap);
    }

    // Raid test
    function testRaid() public {
        vm.startPrank(owner);
        uint256 NFTIdForRaid = 1;
        // Init data for raiding
        address newHiveAddress = hiveFactory.createHive(0);
        Hive hive2 = Hive(newHiveAddress);
        buzzkillNFT.mintTo{value: MINT_FEE}(owner, 0); // Mint 1 worker bee to owner address, NFT has id = 2
        buzzkillNFT.approve(address(hive2), 2);
        hive2.stakeBee(2);
        hive2.forage(2, 0); // forage to increase productivity
        uint256 numberOfBlocks = 1800; // Roll 2 epoch
        vm.roll(block.number + numberOfBlocks);
        uint256 currentHoneyInHive = hive2.getAvailableHoneyInHive();
        assertGt(currentHoneyInHive, 2 ether); // amount honey in hive should be greater than 2 $HONEY, base yield is 1 $HONEY per epoch
        console.log("Current honey in hive: ", currentHoneyInHive);
        gameConfig.setRaidSapFee(2); // Set the required sap to raid to 1 to ensure the raid can happen
        gameConfig.setRaidHoneyFee(10); // Set the raid fee to 10 $HONEY
        honey.mintTo(user, 10 ether); // Mint 10 $HONEY to user address to use as raid fee
        vm.stopPrank();

        // Init raiding
        stake();
        vm.startPrank(user);
        hive.forage(NFTIdForRaid, 0); // Send queen bee to forage to get enough resources to raid (sap required)
        uint256 beeSapBeforeRaid = buzzkillNFT.getBeeTraits(NFTIdForRaid).sap;

        hive.startRaid(NFTIdForRaid, address(hive2)); // Send the queen bee to raid at other hive
        vm.stopPrank();
        console.log("Bee Sap Before Raid: ", beeSapBeforeRaid);
        uint256 beeSapAfterRaid = buzzkillNFT.getBeeTraits(NFTIdForRaid).sap;
        console.log("Bee Sap After Raid: ", beeSapAfterRaid);
        assertEq(beeSapAfterRaid, beeSapBeforeRaid - 2); // Check the sap of the bee after raiding
    }

    // Collect honey
    function testCollect() public {
        stake();
        uint256 NFTIdForCollect = 0;
        vm.prank(owner);
        gameConfig.setNectarRequiredToClaim(10); // Set the required nectar to claim to 10 to ensure the bee can claim

        vm.startPrank(user);
        hive.forage(NFTIdForCollect, 0); // Send the worker bee to forage at habitat id 0
        uint256 numberOfBlocks = 1800; // Roll 2 epoch
        vm.roll(block.number + numberOfBlocks);

        uint256 currentHoneyInHive = hive.getAvailableHoneyInHive();
        uint256 claimAbleHoney = hive.getUserClaimableHoney(NFTIdForCollect);
        assertEq(currentHoneyInHive, claimAbleHoney); // Since there is only 1 bee in the hive has productivity, the claimable honey of that bee should be equal to the current honey in the hive
        uint256 amountNectarBeforeCollect = buzzkillNFT
            .getBeeTraits(NFTIdForCollect)
            .nectar;

        hive.collectHoney(NFTIdForCollect); // Collect honey from the hive

        uint256 honeyBalance = honey.balanceOf(address(user));
        assertEq(honeyBalance, claimAbleHoney); // Check the honey balance of the user after collecting
        uint256 amountNectarAfterCollect = buzzkillNFT
            .getBeeTraits(NFTIdForCollect)
            .nectar;
        assertEq(amountNectarAfterCollect, amountNectarBeforeCollect - 10); // Check the nectar of the bee after collecting
        console.log("Honey balance: ", honeyBalance);
    }

    // Unstake
    function testUnstake() public {
        stake();
        vm.prank(user);
        hive.unstakeBee(0);
        vm.prank(user);
        hive.unstakeBee(1);

        uint256 numQueens = hive.numQueens();
        uint256 numWorkers = hive.numWorkers();

        assertEq(numQueens, 0);
        assertEq(numWorkers, 0);
    }

    function testUnstakeWithPendingHoney() public {
        stake();
        vm.prank(owner);
        gameConfig.setNectarRequiredToClaim(10); // Set the required nectar to claim to 10 to ensure the bee can claim
        vm.startPrank(user);
        hive.unstakeBee(0); // Unstake the worker first
        uint256 numWorkers = hive.numWorkers();
        assertEq(numWorkers, 0);

        // Leave the queen inside the hive
        hive.forage(1, 0); // Send the queen bee to forage at habitat id 0
        uint256 numberOfBlocks = 1800; // Roll 2 epoch
        vm.roll(block.number + numberOfBlocks);
        uint256 userClaimableHoney = hive.getUserClaimableHoney(1);
        hive.unstakeBee(1); // Unstake the queen bee

        vm.stopPrank();

        uint256 numQueens = hive.numQueens();
        assertEq(numQueens, 0);
        uint256 honeyBalance = honey.balanceOf(address(user));
        assertEq(honeyBalance, userClaimableHoney); // Check the honey balance of the user after unstaking
    }

    function testUnstakeWithPendingHoneyButInsufficentNectar() public {
        stake();
        vm.prank(owner);
        gameConfig.setNectarRequiredToClaim(10_000); // Set the required nectar to claim to 10_000 to ensure the bee can not claim
        vm.startPrank(user);
        hive.unstakeBee(0); // Unstake the worker first

        // Leave the queen inside the hive
        hive.forage(1, 0); // Send the queen bee to forage at habitat id 0
        uint256 numberOfBlocks = 1800; // Roll 2 epoch
        vm.roll(block.number + numberOfBlocks);
        uint256 userClaimableHoney = hive.getUserClaimableHoney(1);
        assertGt(userClaimableHoney, 0); // Check the claimable honey of the user before unstaking
        hive.unstakeBee(1); // Unstake the queen bee

        vm.stopPrank();

        uint256 honeyBalance = honey.balanceOf(address(user));
        assertEq(honeyBalance, 0); // Check the honey balance of the user after unstaking
    }
}
