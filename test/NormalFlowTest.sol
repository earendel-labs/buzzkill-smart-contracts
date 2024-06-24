// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../contracts/helper/BuzzkillAddressProvider.sol";
import "../contracts/helper/GameConfig.sol";
import "../contracts/helper/HoneyDistribution.sol";

import "../contracts/Honey.sol";
import "../contracts/BuzzkillNFT.sol";
import "../contracts/HiveManager.sol";
import "../contracts/WorldMap.sol";

contract NormalFlowTest is Test {
    struct BeeTraits {
        uint256 energy;
        uint256 health;
        uint256 attack;
        uint256 defense;
        uint256 forage;
        uint256 baseProductivity;
        uint256 maxProductivity;
        uint256 experience;
        uint256 level;
        uint256 nectar;
        uint256 pollen;
        uint256 sap;
    }

    struct Hive {
        uint256 habitatId;
        uint256 numQueens;
        uint256 numWorkers;
        uint256 nectar;
        uint256 pollen;
        uint256 sap;
        uint256 hiveProductivity;
        uint256 hiveDefense;
        uint256 availableHoneyInHive;
        uint256 lastAvailableHoneyUpdateBlock;
        uint256 hiveTotalIncentive;
        uint256 lastBaseIncentiveUpdateBlock;
    }

    uint256 public constant MINT_FEE = 1 ether;
    address owner = address(1234);
    address user = address(5678);

    BuzzkillAddressProvider buzzkillAddressProvider;
    GameConfig gameConfig;
    Honey honey;
    BuzzkillNFT buzzkillNFT;
    HiveManager hiveManager;
    HoneyDistribution honeyDistribution;
    WorldMap worldMap;

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

        // Deploy hive manager contract
        hiveManager = new HiveManager();
        hiveManager.initialize(address(buzzkillAddressProvider));

        // Deploy buzzkill NFT contract
        buzzkillNFT = new BuzzkillNFT(
            MINT_FEE,
            address(buzzkillAddressProvider)
        );

        // Deploy world map contract
        worldMap = new WorldMap(address(buzzkillAddressProvider));

        // Setting address
        buzzkillAddressProvider.setHoneyAddress(address(honey));
        buzzkillAddressProvider.setHiveManagerAddress(address(hiveManager));
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

        // Add a hive in habitat 0
        hiveManager.createHive(0);

        vm.stopPrank();
        vm.startPrank(user);
        // Mint NFTs
        buzzkillNFT.mintTo{value: MINT_FEE}(user, 0); // Mint a worker bee, type of worker bee = 0, NFT has id = 0
        buzzkillNFT.mintTo{value: MINT_FEE}(user, 1); // Mint a queen bee, type of queen bee = 1, NFT has id = 1
        assertEq(address(buzzkillNFT).balance, MINT_FEE * 2);
        vm.stopPrank();
    }

    function getHiveInfo(uint256 hiveId) public view returns (Hive memory) {
        (
            uint256 habitatId,
            uint256 numQueens,
            uint256 numWorkers,
            uint256 nectar,
            uint256 pollen,
            uint256 sap,
            uint256 hiveProductivity,
            uint256 hiveDefense,
            uint256 availableHoneyInHive,
            uint256 lastAvailableHoneyUpdateBlock,
            uint256 hiveTotalIncentive,
            uint256 lastBaseIncentiveUpdateBlock
        ) = hiveManager.hives(hiveId);

        Hive memory hive = Hive(
            habitatId,
            numQueens,
            numWorkers,
            nectar,
            pollen,
            sap,
            hiveProductivity,
            hiveDefense,
            availableHoneyInHive,
            lastAvailableHoneyUpdateBlock,
            hiveTotalIncentive,
            lastBaseIncentiveUpdateBlock
        );
        return hive;
    }

    function getTokenTraits(
        uint256 tokenId
    ) public view returns (BeeTraits memory) {
        (
            uint256 energy,
            uint256 health,
            uint256 attack,
            uint256 defense,
            uint256 forage,
            uint256 baseProductivity,
            uint256 maxProductivity,
            uint256 experience,
            uint256 level,
            uint256 nectar,
            uint256 pollen,
            uint256 sap
        ) = buzzkillNFT.tokenIdToTraits(tokenId);

        BeeTraits memory traits = BeeTraits(
            energy,
            health,
            attack,
            defense,
            forage,
            baseProductivity,
            maxProductivity,
            experience,
            level,
            nectar,
            pollen,
            sap
        );
        return traits;
    }

    // Stake
    function stake() public {
        vm.startPrank(user);
        // Approve hive to transfer NFT
        buzzkillNFT.setApprovalForAll(address(hiveManager), true);
        // Id of the first hive
        uint256 firstHiveId = 0;
        // Stake bees with id 0 and id 1 to first hive
        hiveManager.stakeBee(firstHiveId, 0);
        hiveManager.stakeBee(firstHiveId, 1);

        Hive memory hiveInfo = getHiveInfo(firstHiveId);

        assertEq(hiveInfo.numQueens, 1);
        assertEq(hiveInfo.numWorkers, 1);

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
        uint256 firstHiveId = 0;
        uint256 forageBeeId = 0;
        uint256 forageHabitatId = 0;

        hiveManager.forage(firstHiveId, forageBeeId, forageHabitatId); // Send the worker bee with id 0 of the first hive to forage at habitat id 0

        // Check the bee resources gathered from the habitat after foraging
        BeeTraits memory beeTraits = getTokenTraits(forageBeeId);

        assertGe(beeTraits.nectar, 19);
        assertGe(beeTraits.pollen, 19);
        assertGe(beeTraits.sap, 19);

        console.log("Bee Nectar: ", beeTraits.nectar);
        console.log("Bee Pollen: ", beeTraits.pollen);
        console.log("Bee Sap: ", beeTraits.sap);

        // Check the hive resources after foraging
        (uint256 hiveNectar, uint256 hivePollen, uint256 hiveSap) = hiveManager
            .getHiveResources(firstHiveId);
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
        uint256 firstHiveId = 0;
        uint256 secondHiveId = 1;
        uint256 habitatId = 0;
        // Init data for raiding
        hiveManager.createHive(habitatId); // Create a new hive with habitat id 0
        // Mint NFTs for the new hive
        buzzkillNFT.mintTo{value: MINT_FEE}(owner, 0); // Mint 1 worker bee to owner address, NFT has id = 2
        uint256 secondHiveStakedBeeId = 2;

        buzzkillNFT.approve(address(hiveManager), secondHiveStakedBeeId);
        hiveManager.stakeBee(secondHiveId, secondHiveStakedBeeId);

        hiveManager.forage(secondHiveId, secondHiveStakedBeeId, habitatId); // forage to increase productivity
        // Roll 2 epoch
        uint256 numberOfBlocks = 1800;
        vm.roll(block.number + numberOfBlocks);
        // Amount honey in hive should be greater than 2 $HONEY, base yield is 1 $HONEY per epoch
        uint256 currentHoneyInHive = hiveManager.getAvailableHoneyInHive(
            secondHiveId
        );
        assertGt(currentHoneyInHive, 2 ether);
        console.log("Current honey in hive: ", currentHoneyInHive);
        // Setup for the raid
        gameConfig.setRaidSapFee(2); // Set the required sap to raid to 1 to ensure the raid can happen
        gameConfig.setRaidHoneyFee(10); // Set the raid fee to 10 $HONEY
        honey.mintTo(user, 10 ether); // Mint 10 $HONEY to user address to use as raid fee
        vm.stopPrank();

        // Init raiding
        stake();
        vm.startPrank(user);
        hiveManager.forage(firstHiveId, NFTIdForRaid, 0); // Send the bee with pre-defined id from first hive to forage to get enough resources to raid (sap required)
        uint256 beeSapBeforeRaid = buzzkillNFT.getBeeTraits(NFTIdForRaid).sap;

        hiveManager.startRaid(firstHiveId, NFTIdForRaid, secondHiveId); // Send the bee from first hive to raid at second hive
        vm.stopPrank();
        console.log("Bee Sap Before Raid: ", beeSapBeforeRaid);
        uint256 beeSapAfterRaid = buzzkillNFT.getBeeTraits(NFTIdForRaid).sap;
        console.log("Bee Sap After Raid: ", beeSapAfterRaid);
        assertEq(beeSapAfterRaid, beeSapBeforeRaid - 2); // Check the sap of the bee after raiding
        // Result of the raid (add later)
    }

    // Collect honey
    function testCollect() public {
        stake();
        uint256 NFTIdForCollect = 0;
        uint256 firstHiveId = 0;
        vm.prank(owner);
        gameConfig.setNectarRequiredToClaim(10); // Set the required nectar to claim to 10 to ensure the bee can claim

        vm.startPrank(user);
        hiveManager.forage(firstHiveId, NFTIdForCollect, 0); // Send the worker bee to forage at habitat id 0
        uint256 numberOfBlocks = 1800; // Roll 2 epoch
        vm.roll(block.number + numberOfBlocks);

        uint256 currentHoneyInHive = hiveManager.getAvailableHoneyInHive(
            firstHiveId
        );
        uint256 claimAbleHoneyFirstBee = hiveManager.getUserClaimableHoney(
            firstHiveId,
            NFTIdForCollect
        );
        uint256 claimAbleHoneySecondBee = hiveManager.getUserClaimableHoney(
            firstHiveId,
            1
        );
        assertLt(claimAbleHoneyFirstBee, currentHoneyInHive); // Since there is 2 bee in the hive , the claimable honey of that bee should be less than the current honey in the hive
        assertGe(
            currentHoneyInHive,
            claimAbleHoneyFirstBee + claimAbleHoneySecondBee
        ); // The sum of the claimable honey of all bees in the hive should be equal to the current honey in the hive (Using greater than or equal because rounding)
        uint256 amountNectarBeforeCollect = buzzkillNFT
            .getBeeTraits(NFTIdForCollect)
            .nectar;

        hiveManager.collectHoney(firstHiveId, NFTIdForCollect); // Collect honey from the hive

        uint256 honeyBalance = honey.balanceOf(address(user));
        assertEq(honeyBalance, claimAbleHoneyFirstBee); // Check the honey balance of the user after collecting
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
        hiveManager.unstakeBee(0, 0);
        vm.prank(user);
        hiveManager.unstakeBee(0, 1);

        Hive memory hiveInfo = getHiveInfo(0);

        assertEq(hiveInfo.numQueens, 0);
        assertEq(hiveInfo.numWorkers, 0);
    }

    function testUnstakeWithPendingHoney() public {
        stake();
        vm.prank(owner);
        gameConfig.setNectarRequiredToClaim(10); // Set the required nectar to claim to 10 to ensure the bee can claim
        vm.startPrank(user);
        hiveManager.unstakeBee(0, 0); // Unstake the worker first
        Hive memory hiveInfo = getHiveInfo(0);
        assertEq(hiveInfo.numWorkers, 0);

        // Leave the queen inside the hive
        hiveManager.forage(0, 1, 0); // Send the queen bee to forage at habitat id 0
        uint256 numberOfBlocks = 1800; // Roll 2 epoch
        vm.roll(block.number + numberOfBlocks);
        uint256 userClaimableHoney = hiveManager.getUserClaimableHoney(0, 1);
        hiveManager.unstakeBee(0, 1); // Unstake the queen bee

        vm.stopPrank();

        hiveInfo = getHiveInfo(0);
        assertEq(hiveInfo.numQueens, 0);
        uint256 honeyBalance = honey.balanceOf(address(user));
        assertEq(honeyBalance, userClaimableHoney); // Check the honey balance of the user after unstaking
    }

    function testUnstakeWithPendingHoneyButInsufficentNectar() public {
        stake();
        vm.prank(owner);
        gameConfig.setNectarRequiredToClaim(10_000); // Set the required nectar to claim to 10_000 to ensure the bee can not claim
        vm.startPrank(user);
        hiveManager.unstakeBee(0, 0); // Unstake the worker first

        // Leave the queen inside the hive
        hiveManager.forage(0, 1, 0); // Send the queen bee to forage at habitat id 0
        uint256 numberOfBlocks = 1800; // Roll 2 epoch
        vm.roll(block.number + numberOfBlocks);
        uint256 userClaimableHoney = hiveManager.getUserClaimableHoney(0, 1);
        assertGt(userClaimableHoney, 0); // Check the claimable honey of the user before unstaking
        hiveManager.unstakeBee(0, 1); // Unstake the queen bee

        vm.stopPrank();

        uint256 honeyBalance = honey.balanceOf(address(user));
        assertEq(honeyBalance, 0); // Check the honey balance of the user after unstaking
    }

    function testUpgradeBee() public {
        stake();
        uint256 NFTIdForUpgrade = 0;
        uint256 firstHiveId = 0;

        vm.startPrank(owner);
        gameConfig.setBaseNectarUsePerUpgrade(1); // Set the required nectar to 1 to ensure the upgrade can happen
        gameConfig.setBasePollenUsePerUpgrade(1); // Set the required pollen to upgrade to 1 to ensure the upgrade can happen
        gameConfig.setBaseSapUsePerUpgrade(1); // Set the required sap to upgrade to 1 to ensure the upgrade can happen
        vm.stopPrank();

        vm.prank(user);
        // Forage to get enough resources to upgrade
        hiveManager.forage(firstHiveId, NFTIdForUpgrade, 0);

        BeeTraits memory beeTraitsBeforeUpgrade = getTokenTraits(
            NFTIdForUpgrade
        );

        vm.prank(user);
        hiveManager.updradeBeeSkills(
            firstHiveId,
            NFTIdForUpgrade,
            HiveManager.BeeSkills.ATTACK,
            1
        ); // Upgrade the bee attack skill by 1

        BeeTraits memory beeTraitsAfterUpgrade = getTokenTraits(
            NFTIdForUpgrade
        );

        assertEq(
            beeTraitsAfterUpgrade.attack,
            beeTraitsBeforeUpgrade.attack + 1
        ); // Check the attack of the bee after upgrading
        assertLt(beeTraitsAfterUpgrade.nectar, beeTraitsBeforeUpgrade.nectar); // Check the nectar of the bee after upgrading
        assertLt(beeTraitsAfterUpgrade.pollen, beeTraitsBeforeUpgrade.pollen); // Check the pollen of the bee after upgrading
        assertLt(beeTraitsAfterUpgrade.sap, beeTraitsBeforeUpgrade.sap); // Check the sap of the bee after upgrading

        console.log(
            "Bee Attack Before Upgrade: ",
            beeTraitsBeforeUpgrade.attack
        );
        console.log("Bee Attack After Upgrade: ", beeTraitsAfterUpgrade.attack);
        console.log(
            "Bee Nectar Before Upgrade: ",
            beeTraitsBeforeUpgrade.nectar
        );

        console.log("Bee Nectar After Upgrade: ", beeTraitsAfterUpgrade.nectar);
        console.log(
            "Bee Pollen Before Upgrade: ",
            beeTraitsBeforeUpgrade.pollen
        );
        console.log("Bee Sap After Upgrade: ", beeTraitsAfterUpgrade.sap);
    }

    function testQuestForage() public {
        stake();
        uint256 NFTIdForQuest = 0;
        uint256 firstHiveId = 0;

        vm.startPrank(user);
        // Current game config, at lv1, forage 4 times will complete the quest
        // Each time forage earn 10 XP
        // 4 times forage will earn 40 XP + quest completion reward 4 * 10 XP
        // Total 80 XP
        hiveManager.forage(firstHiveId, NFTIdForQuest, 0);
        hiveManager.forage(firstHiveId, NFTIdForQuest, 0);
        hiveManager.forage(firstHiveId, NFTIdForQuest, 0);
        hiveManager.forage(firstHiveId, NFTIdForQuest, 0);

        BeeTraits memory beeTraitsAfterDoneQuest = getTokenTraits(
            NFTIdForQuest
        );

        assertEq(beeTraitsAfterDoneQuest.experience, 80); // Check the experience of the bee after completing the quest
    }
}
