// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract GameConfig is Initializable, OwnableUpgradeable {
    /* -------------------------------------------------------------------------- */
    /*  State variables                                                           */
    /* -------------------------------------------------------------------------- */
    uint256 public beeEnergyRefreshInterval; // Time interval to refresh bee energy
    uint256 public beeHealthRefreshInterval; // Time interval to refresh bee health
    uint256 public amountToLevelUp; // 100 points per level
    uint256 public maxQueen; // Maximum 3 queens in a hive
    uint256 public maxWorker; // Maximum 55 workers in a hive
    uint256 public foragePercentage; // 5% of the gathered resources are added to the hive
    uint256 public claimTimeInterval; // 1 week interval between honey claim
    uint256 public honeyYieldConstant; // Contanst to caculate honey yield
    uint256 public nectarRequiredToClaim; // Required at least 10_000 nectar to claim honey
    uint256 public experienceEarnedAfterForage; // 10 experience points earned after foraging
    uint256 public experienceEarnedAfterRaidFailed; // 20 experience points earned after a failed raid
    uint256 public experienceEarnedAfterRaidSuccess; // 20 experience points earned after a successful raid
    uint256 public experienceEarnedAfterUpgrade; // 30 experience points earned after an upgrade
    uint256 public baseHealthDeductionAfterRaid; // 5 HP deducted after a raid
    uint256 public baseEnergyDeductionAfterRaid; // 20 energy deducted after a raid
    uint256 public baseEnergyDeductionAfterUpgrade; // 20 energy deducted after an upgrade
    uint256 public raidHoneyFee; // 10 $HONEY paid for one raid
    uint256 public raidSapFee; // 500 sap for one raid
    uint256 public baseHoneyRaidReward; // base honey earn for one raid success is 10 $HONEY
    uint256 public incentiveEarnAfterRaid; // 200 incentive points earned after a raid
    uint256 public maxResourcesValue; // The maximum density or availability of nectar, pollen, and sap in the environment is 100
    uint256 public minResourcesValue; // The minimum density or availability of nectar, pollen, and sap in the environment is 1
    uint256 public resourcesRefreshInterval; // Resources refresh every 24 hours
    uint256 public baseHoneyYield; // Base amount of honey yield each epoch
    uint256 public baseIncentivePerEpoch; // Base amount of incentive per epoch
    uint256 public differenceBetweenLevels; // Difference between levels, currently 200
    uint256 public amountAttackIncreaseOnLevelUp; // Amount of attack increase on level up, currently 1
    uint256 public amountDefenseIncreaseOnLevelUp; // Amount of defense increase on level up, currently 2
    uint256 public amountForageIncreaseOnLevelUp; // Amount of forage increase on level up, currently 2
    uint256 public amountEnergyIncreaseOnLevelUp; // Amount of energy increase on level up, currently 2
    uint256 public amountHealthIncreaseOnLevelUp; // Amount of health increase on level up, currently 1
    uint256 public amountBaseProductivityIncreaseOnLevelUp; // Amount of base productivity increase on level up, currently 2
    uint256 public amountMaxProductivityIncreaseOnLevelUp; // Amount of max productivity increase on level up, currently 1
    uint256 public baseNumberOfForagingQuest; // Base number of foraging quest, currently 4
    uint256 public baseNumberOfRaidQuest; // Base number of raid quest, currently 2
    uint256 public baseNumberOfRaidSuccessQuest; // Base number of raid success quest, currently 1
    uint256 public baseNumberOfUpgradeQuest; // Base number of upgrade quest, currently 1
    uint256 public baseNectarUsePerUpgrade; // Base number of nectar use for upgrade skill, currently 3000
    uint256 public basePollenUsePerUpgrade; // Base number of pollen use for upgrade skill, currently 3000
    uint256 public baseSapUsePerUpgrade; // Base number of sap use for upgrade skill, currently 3000

    /**
     * Cn ,Cp ,Cs are constants that adjust the scale of resources gathered to fit the game's economy and balance.
     * These constants can be used to fine-tune how rewarding foraging feels in the game
     * Make sure to adjust these constants carefully to ensure the game is not too easy or too hard
     */
    uint256 public Cs;
    uint256 public Cn;
    uint256 public Cp;

    /* -------------------------------------------------------------------------- */
    /*  Events                                                                    */
    /* -------------------------------------------------------------------------- */
    event BeeEnergyRefreshIntervalChanged(uint256 newBeeEnergyRefreshInterval);
    event BeeHealthRefreshIntervalChanged(uint256 newBeeHealthRefreshInterval);
    event AmountToLevelUpChanged(uint256 newAmountToLevelUp);
    event MaxQueenChanged(uint256 newMaxQueen);
    event MaxWorkerChanged(uint256 newMaxWorker);
    event ForagePercentageChanged(uint256 newForagePercentage);
    event ClaimTimeIntervalChanged(uint256 newClaimTimeInterval);
    event HoneyYieldConstantChanged(uint256 newHoneyYieldConstant);
    event NectarRequiredToClaimChanged(uint256 newNectarRequiredToClaim);
    event ExperienceEarnedAfterForageChanged(
        uint256 newExperienceEarnedAfterForage
    );
    event ExperienceEarnedAfterRaidFailedChanged(
        uint256 newExperienceEarnedAfterRaidFailed
    );
    event ExperienceEarnedAfterRaidSuccessChanged(
        uint256 newExperienceEarnedAfterRaidSuccess
    );
    event ExperienceEarnedAfterUpgradeChanged(
        uint256 newExperienceEarnedAfterUpgrade
    );
    event BaseHealthDeductionAfterRaidChanged(
        uint256 newBaseHealthDeductionAfterRaid
    );
    event BaseEnergyDeductionAfterRaidChanged(
        uint256 newBaseEnergyDeductionAfterRaid
    );
    event BaseEnergyDeductionAfterUpgradeChanged(
        uint256 newBaseEnergyDeductionAfterUpgrade
    );
    event RaidHoneyFeeChanged(uint256 newRaidHoneyFee);
    event RaidSapFeeChanged(uint256 newRaidSapFee);
    event BaseHoneyRaidRewardChanged(uint256 newBaseHoneyRaidReward);
    event IncentiveEarnAfterRaidChanged(uint256 newIncentiveEarnAfterRaid);
    event MaxResourcesValueChanged(uint256 newMaxResourcesValue);
    event MinResourcesValueChanged(uint256 newMinResourcesValue);
    event MaxEnergyDeductionValueChanged(uint256 newMaxEnergyDeductionValue);
    event MinEnergyDeductionValueChanged(uint256 newMinEnergyDeductionValue);
    event ResourcesRefreshIntervalChanged(uint256 newResourcesRefreshInterval);
    event BaseHoneyYieldChanged(uint256 newBaseHoneyYield);
    event BaseIncentivePerEpochChanged(uint256 newBaseIncentivePerEpoch);
    event DifferenceBetweenLevelsChanged(uint256 newDifferenceBetweenLevels);
    event AmountAttackIncreaseOnLevelUpChanged(
        uint256 newAmountAttackIncreaseOnLevelUp
    );
    event AmountDefenseIncreaseOnLevelUpChanged(
        uint256 newAmountDefenseIncreaseOnLevelUp
    );
    event AmountForageIncreaseOnLevelUpChanged(
        uint256 newAmountForageIncreaseOnLevelUp
    );
    event AmountEnergyIncreaseOnLevelUpChanged(
        uint256 newAmountEnergyIncreaseOnLevelUp
    );
    event AmountHealthIncreaseOnLevelUpChanged(
        uint256 newAmountHealthIncreaseOnLevelUp
    );
    event AmountBaseProductivityIncreaseOnLevelUpChanged(
        uint256 newAmountBaseProductivityIncreaseOnLevelUp
    );
    event AmountMaxProductivityIncreaseOnLevelUpChanged(
        uint256 newAmountMaxProductivityIncreaseOnLevelUp
    );
    event BaseNumberOfForagingQuestChanged(
        uint256 newBaseNumberOfForagingQuest
    );
    event BaseNumberOfRaidQuestChanged(uint256 newBaseNumberOfRaidQuest);
    event BaseNumberOfRaidSuccessQuestChanged(
        uint256 newBaseNumberOfRaidSuccessQuest
    );
    event BaseNumberOfUpgradeQuestChanged(uint256 newBaseNumberOfUpgradeQuest);
    event BaseNectarUsePerUpgradeChanged(uint256 newBaseNectarPerUpgrade);
    event BasePollenUsePerUpgradeChanged(uint256 newBasePollenPerUpgrade);
    event BaseSapUsePerUpgradeChanged(uint256 newBaseSapPerUpgrade);
    event CsChanged(uint256 newCs);
    event CnChanged(uint256 newCn);
    event CpChanged(uint256 newCp);

    /* -------------------------------------------------------------------------- */
    /*  Initilize contract                                                        */
    /* -------------------------------------------------------------------------- */
    function initialize() public initializer {
        __Ownable_init(msg.sender);

        beeEnergyRefreshInterval = 1 days;
        beeHealthRefreshInterval = 1 days;
        amountToLevelUp = 100;
        maxQueen = 3;
        maxWorker = 55;
        foragePercentage = 500;
        claimTimeInterval = 1 weeks;
        honeyYieldConstant = 10_0000;
        nectarRequiredToClaim = 10_000;
        experienceEarnedAfterForage = 10;
        experienceEarnedAfterRaidFailed = 20;
        experienceEarnedAfterRaidSuccess = 20;
        experienceEarnedAfterUpgrade = 30;
        baseHealthDeductionAfterRaid = 5;
        baseEnergyDeductionAfterRaid = 20;
        baseEnergyDeductionAfterUpgrade = 20;
        raidHoneyFee = 10 ether;
        raidSapFee = 500;
        baseHoneyRaidReward = 10 ether;
        incentiveEarnAfterRaid = 10;
        maxResourcesValue = 100;
        minResourcesValue = 1;
        resourcesRefreshInterval = 1 days;
        baseHoneyYield = 1 ether;
        baseIncentivePerEpoch = 20;
        differenceBetweenLevels = 200;
        amountAttackIncreaseOnLevelUp = 1;
        amountDefenseIncreaseOnLevelUp = 2;
        amountForageIncreaseOnLevelUp = 2;
        amountEnergyIncreaseOnLevelUp = 2;
        amountHealthIncreaseOnLevelUp = 1;
        amountBaseProductivityIncreaseOnLevelUp = 2;
        amountMaxProductivityIncreaseOnLevelUp = 1;
        baseNumberOfForagingQuest = 4;
        baseNumberOfRaidQuest = 2;
        baseNumberOfRaidSuccessQuest = 1;
        baseNumberOfUpgradeQuest = 1;
        baseNectarUsePerUpgrade = 3_000;
        basePollenUsePerUpgrade = 3_000;
        baseSapUsePerUpgrade = 3_000;
        Cs = 250_000;
        Cn = 250_000;
        Cp = 250_000;
    }

    /* -------------------------------------------------------------------------- */
    /*  Owner setter function                                                     */
    /* -------------------------------------------------------------------------- */

    /**
     * @dev Sets the interval at which bee energy is refreshed.
     * @param _beeEnergyRefreshInterval The new interval for bee energy refresh.
     */
    function setBeeEnergyRefreshInterval(
        uint256 _beeEnergyRefreshInterval
    ) external onlyOwner {
        beeEnergyRefreshInterval = _beeEnergyRefreshInterval;
        emit BeeEnergyRefreshIntervalChanged(_beeEnergyRefreshInterval);
    }

    /**
     * @dev Sets the interval at which bee health is refreshed.
     * @param _beeHealthRefreshInterval The new interval for bee health refresh.
     */
    function setBeeHealthRefreshInterval(
        uint256 _beeHealthRefreshInterval
    ) external onlyOwner {
        beeHealthRefreshInterval = _beeHealthRefreshInterval;
        emit BeeHealthRefreshIntervalChanged(_beeHealthRefreshInterval);
    }

    /**
     * @dev Sets the amount required to level up.
     * @param _amountToLevelUp The new amount required to level up.
     */
    function setAmountToLevelUp(uint256 _amountToLevelUp) external onlyOwner {
        amountToLevelUp = _amountToLevelUp;
        emit AmountToLevelUpChanged(_amountToLevelUp);
    }

    /**
     * @dev Sets the maximum number of queens allowed.
     * @param _maxQueen The new maximum number of queens.
     */
    function setMaxQueen(uint256 _maxQueen) external onlyOwner {
        maxQueen = _maxQueen;
        emit MaxQueenChanged(_maxQueen);
    }

    /**
     * @dev Sets the maximum number of workers allowed.
     * @param _maxWorker The new maximum number of workers.
     */
    function setMaxWorker(uint256 _maxWorker) external onlyOwner {
        maxWorker = _maxWorker;
        emit MaxWorkerChanged(_maxWorker);
    }

    /**
     * @dev Sets the forage percentage.
     * @param _foragePercentage The new forage percentage.
     */
    function setForagePercentage(uint256 _foragePercentage) external onlyOwner {
        foragePercentage = _foragePercentage;
        emit ForagePercentageChanged(_foragePercentage);
    }

    /**
     * @dev Sets the interval at which claims can be made.
     * @param _claimTimeInterval The new claim time interval.
     */
    function setClaimTimeInterval(
        uint256 _claimTimeInterval
    ) external onlyOwner {
        claimTimeInterval = _claimTimeInterval;
        emit ClaimTimeIntervalChanged(_claimTimeInterval);
    }

    /**
     * @dev Sets the constant for honey yield.
     * @param _honeyYieldConstant The new honey yield constant.
     */
    function setHoneyYieldConstant(
        uint256 _honeyYieldConstant
    ) external onlyOwner {
        honeyYieldConstant = _honeyYieldConstant;
        emit HoneyYieldConstantChanged(_honeyYieldConstant);
    }

    /**
     * @dev Sets the amount of nectar required to claim rewards.
     * @param _nectarRequiredToClaim The new amount of nectar required to claim.
     */
    function setNectarRequiredToClaim(
        uint256 _nectarRequiredToClaim
    ) external onlyOwner {
        nectarRequiredToClaim = _nectarRequiredToClaim;
        emit NectarRequiredToClaimChanged(_nectarRequiredToClaim);
    }

    /**
     * @dev Sets the experience earned after foraging.
     * @param _experienceEarnedAfterForage The new experience earned after foraging.
     */
    function setExperienceEarnedAfterForage(
        uint256 _experienceEarnedAfterForage
    ) external onlyOwner {
        experienceEarnedAfterForage = _experienceEarnedAfterForage;
        emit ExperienceEarnedAfterForageChanged(_experienceEarnedAfterForage);
    }

    /**
     * @dev Sets the experience earned after a failed raid.
     * @param _experienceEarnedAfterRaidFailed The new experience earned after a failed raid.
     */
    function setExperienceEarnedAfterRaidFailed(
        uint256 _experienceEarnedAfterRaidFailed
    ) external onlyOwner {
        experienceEarnedAfterRaidFailed = _experienceEarnedAfterRaidFailed;
        emit ExperienceEarnedAfterRaidFailedChanged(
            _experienceEarnedAfterRaidFailed
        );
    }

    /**
     * @dev Sets the experience earned after a successful raid.
     * @param _experienceEarnedAfterRaidSuccess The new experience earned after a successful raid.
     */
    function setExperienceEarnedAfterRaidSuccess(
        uint256 _experienceEarnedAfterRaidSuccess
    ) external onlyOwner {
        experienceEarnedAfterRaidSuccess = _experienceEarnedAfterRaidSuccess;
        emit ExperienceEarnedAfterRaidSuccessChanged(
            _experienceEarnedAfterRaidSuccess
        );
    }

    /**
     * @dev Sets the experience earned after an upgrade.
     * @param _experienceEarnedAfterUpgrade The new experience earned after an upgrade.
     */
    function setExperienceEarnedAfterUpgrade(
        uint256 _experienceEarnedAfterUpgrade
    ) external onlyOwner {
        experienceEarnedAfterUpgrade = _experienceEarnedAfterUpgrade;
        emit ExperienceEarnedAfterUpgradeChanged(_experienceEarnedAfterUpgrade);
    }

    /**
     * @dev Sets the base health deduction after a raid.
     * @param _baseHealthDeductionAfterRaid The new base health deduction after a raid.
     */
    function setBaseHealthDeductionAfterRaid(
        uint256 _baseHealthDeductionAfterRaid
    ) external onlyOwner {
        baseHealthDeductionAfterRaid = _baseHealthDeductionAfterRaid;
        emit BaseHealthDeductionAfterRaidChanged(_baseHealthDeductionAfterRaid);
    }

    /**
     * @dev Sets the base energy deduction after a raid.
     * @param _baseEnergyDeductionAfterRaid The new base energy deduction after a raid.
     */
    function setBaseEnergyDeductionAfterRaid(
        uint256 _baseEnergyDeductionAfterRaid
    ) external onlyOwner {
        baseEnergyDeductionAfterRaid = _baseEnergyDeductionAfterRaid;
        emit BaseEnergyDeductionAfterRaidChanged(_baseEnergyDeductionAfterRaid);
    }

    /**
     * @dev Sets the base energy deduction after an upgrade.
     * @param _baseEnergyDeductionAfterUpgrade The new base energy deduction after an upgrade.
     */
    function setBaseEnergyDeductionAfterUpgrade(
        uint256 _baseEnergyDeductionAfterUpgrade
    ) external onlyOwner {
        baseEnergyDeductionAfterUpgrade = _baseEnergyDeductionAfterUpgrade;
        emit BaseEnergyDeductionAfterUpgradeChanged(
            _baseEnergyDeductionAfterUpgrade
        );
    }

    /**
     * @dev Sets the honey fee for a raid.
     * @param _raidHoneyFee The new honey fee for a raid.
     */
    function setRaidHoneyFee(uint256 _raidHoneyFee) external onlyOwner {
        raidHoneyFee = _raidHoneyFee;
        emit RaidHoneyFeeChanged(_raidHoneyFee);
    }

    /**
     * @dev Sets the sap fee for a raid.
     * @param _raidSapFee The new sap fee for a raid.
     */
    function setRaidSapFee(uint256 _raidSapFee) external onlyOwner {
        raidSapFee = _raidSapFee;
        emit RaidSapFeeChanged(_raidSapFee);
    }

    /**
     * @dev Sets the base honey reward for a raid.
     * @param _baseHoneyRaidReward The new base honey raid reward.
     */
    function setBaseHoneyRaidReward(
        uint256 _baseHoneyRaidReward
    ) external onlyOwner {
        baseHoneyRaidReward = _baseHoneyRaidReward;
        emit BaseHoneyRaidRewardChanged(_baseHoneyRaidReward);
    }

    /**
     * @dev Sets the incentive earned after a raid.
     * @param _incentiveEarnAfterRaid The new incentive earned after a raid.
     */
    function setIncentiveEarnAfterRaid(
        uint256 _incentiveEarnAfterRaid
    ) external onlyOwner {
        incentiveEarnAfterRaid = _incentiveEarnAfterRaid;
        emit IncentiveEarnAfterRaidChanged(_incentiveEarnAfterRaid);
    }

    /**
     * @dev Sets the maximum value of resources.
     * @param _maxResourcesValue The new maximum value of resources.
     */
    function setMaxResourcesValue(
        uint256 _maxResourcesValue
    ) external onlyOwner {
        maxResourcesValue = _maxResourcesValue;
        emit MaxResourcesValueChanged(_maxResourcesValue);
    }

    /**
     * @dev Sets the minimum value of resources.
     * @param _minResourcesValue The new minimum value of resources.
     */
    function setMinResourcesValue(
        uint256 _minResourcesValue
    ) external onlyOwner {
        minResourcesValue = _minResourcesValue;
        emit MinResourcesValueChanged(_minResourcesValue);
    }

    /**
     * @dev Set the resources refresh interval.
     * @param _resourcesRefreshInterval The resources refresh interval.
     */
    function setResourcesRefreshInterval(
        uint256 _resourcesRefreshInterval
    ) external onlyOwner {
        resourcesRefreshInterval = _resourcesRefreshInterval;
        emit ResourcesRefreshIntervalChanged(_resourcesRefreshInterval);
    }

    /**
     * @dev Set the base honey yield.
     * This function updates the base yield of honey that the hive produces.
     * @param _baseHoneyYield The base honey yield.
     */
    function setBaseHoneyYield(uint256 _baseHoneyYield) external onlyOwner {
        baseHoneyYield = _baseHoneyYield;
        emit BaseHoneyYieldChanged(_baseHoneyYield);
    }

    /**
     * @dev Set the base incentive per epoch.
     * This function updates the base incentive that the hive produces.
     * @param _baseIncentivePerEpoch The base incentive per epoch.
     */
    function setBaseIncentivePerEpoch(
        uint256 _baseIncentivePerEpoch
    ) external onlyOwner {
        baseIncentivePerEpoch = _baseIncentivePerEpoch;
        emit BaseIncentivePerEpochChanged(_baseIncentivePerEpoch);
    }

    /**
     * @dev Set the difference between levels.
     * This function updates the difference between levels.
     * @param _differenceBetweenLevels The difference between levels.
     */
    function setDifferenceBetweenLevels(
        uint256 _differenceBetweenLevels
    ) external onlyOwner {
        differenceBetweenLevels = _differenceBetweenLevels;
        emit DifferenceBetweenLevelsChanged(_differenceBetweenLevels);
    }

    /**
     * @dev Set the amount of attack increase on level up.
     * This function updates the amount of attack increase on level up.
     * @param _amountAttackIncreaseOnLevelUp The amount of attack increase on level up.
     */
    function setAmountAttackIncreaseOnLevelUp(
        uint256 _amountAttackIncreaseOnLevelUp
    ) external onlyOwner {
        amountAttackIncreaseOnLevelUp = _amountAttackIncreaseOnLevelUp;
        emit AmountAttackIncreaseOnLevelUpChanged(
            _amountAttackIncreaseOnLevelUp
        );
    }

    /**
     * @dev Set the amount of defense increase on level up.
     * This function updates the amount of defense increase on level up.
     * @param _amountDefenseIncreaseOnLevelUp The amount of defense increase on level up.
     */
    function setAmountDefenseIncreaseOnLevelUp(
        uint256 _amountDefenseIncreaseOnLevelUp
    ) external onlyOwner {
        amountDefenseIncreaseOnLevelUp = _amountDefenseIncreaseOnLevelUp;
        emit AmountDefenseIncreaseOnLevelUpChanged(
            _amountDefenseIncreaseOnLevelUp
        );
    }

    /**
     * @dev Set the amount of forage increase on level up.
     * This function updates the amount of forage increase on level up.
     * @param _amountForageIncreaseOnLevelUp The amount of forage increase on level up.
     */
    function setAmountForageIncreaseOnLevelUp(
        uint256 _amountForageIncreaseOnLevelUp
    ) external onlyOwner {
        amountForageIncreaseOnLevelUp = _amountForageIncreaseOnLevelUp;
        emit AmountForageIncreaseOnLevelUpChanged(
            _amountForageIncreaseOnLevelUp
        );
    }

    /**
     * @dev Set the amount of energy increase on level up.
     * This function updates the amount of energy increase on level up.
     * @param _amountEnergyIncreaseOnLevelUp The amount of energy increase on level up.
     */
    function setAmountEnergyIncreaseOnLevelUp(
        uint256 _amountEnergyIncreaseOnLevelUp
    ) external onlyOwner {
        amountEnergyIncreaseOnLevelUp = _amountEnergyIncreaseOnLevelUp;
        emit AmountEnergyIncreaseOnLevelUpChanged(
            _amountEnergyIncreaseOnLevelUp
        );
    }

    /**
     * @dev Set the amount of health increase on level up.
     * This function updates the amount of health increase on level up.
     * @param _amountHealthIncreaseOnLevelUp The amount of health increase on level up.
     */
    function setAmountHealthIncreaseOnLevelUp(
        uint256 _amountHealthIncreaseOnLevelUp
    ) external onlyOwner {
        amountHealthIncreaseOnLevelUp = _amountHealthIncreaseOnLevelUp;
        emit AmountHealthIncreaseOnLevelUpChanged(
            _amountHealthIncreaseOnLevelUp
        );
    }

    /**
     * @dev Set the amount of base productivity increase on level up.
     * This function updates the amount of base productivity increase on level up.
     * @param _amountBaseProductivityIncreaseOnLevelUp The amount of base productivity increase on level up.
     */
    function setAmountBaseProductivityIncreaseOnLevelUp(
        uint256 _amountBaseProductivityIncreaseOnLevelUp
    ) external onlyOwner {
        amountBaseProductivityIncreaseOnLevelUp = _amountBaseProductivityIncreaseOnLevelUp;
        emit AmountBaseProductivityIncreaseOnLevelUpChanged(
            _amountBaseProductivityIncreaseOnLevelUp
        );
    }

    /**
     * @dev Set the amount of max productivity increase on level up.
     * This function updates the amount of max productivity increase on level up.
     * @param _amountMaxProductivityIncreaseOnLevelUp The amount of max productivity increase on level up.
     */
    function setAmountMaxProductivityIncreaseOnLevelUp(
        uint256 _amountMaxProductivityIncreaseOnLevelUp
    ) external onlyOwner {
        amountMaxProductivityIncreaseOnLevelUp = _amountMaxProductivityIncreaseOnLevelUp;
        emit AmountMaxProductivityIncreaseOnLevelUpChanged(
            _amountMaxProductivityIncreaseOnLevelUp
        );
    }

    /**
     * @dev Set the base number of foraging quest.
     * @param _baseNumberOfForagingQuest The base number of foraging quest.
     */
    function setBaseNumberOfForagingQuest(
        uint256 _baseNumberOfForagingQuest
    ) external onlyOwner {
        baseNumberOfForagingQuest = _baseNumberOfForagingQuest;
        emit BaseNumberOfForagingQuestChanged(_baseNumberOfForagingQuest);
    }

    /**
     * @dev Set the base number of raid quest.
     * @param _baseNumberOfRaidQuest The base number of raid quest.
     */
    function setBaseNumberOfRaidQuest(
        uint256 _baseNumberOfRaidQuest
    ) external onlyOwner {
        baseNumberOfRaidQuest = _baseNumberOfRaidQuest;
        emit BaseNumberOfRaidQuestChanged(_baseNumberOfRaidQuest);
    }

    /**
     * @dev Set the base number of raid success quest.
     * @param _baseNumberOfRaidSuccessQuest The base number of raid success quest.
     */
    function setBaseNumberOfRaidSuccessQuest(
        uint256 _baseNumberOfRaidSuccessQuest
    ) external onlyOwner {
        baseNumberOfRaidSuccessQuest = _baseNumberOfRaidSuccessQuest;
        emit BaseNumberOfRaidSuccessQuestChanged(_baseNumberOfRaidSuccessQuest);
    }

    /**
     * @dev Set the base number of upgrade quest.
     * @param _baseNumberOfUpgradeQuest The base number of upgrade quest.
     */
    function setBaseNumberOfUpgradeQuest(
        uint256 _baseNumberOfUpgradeQuest
    ) external onlyOwner {
        baseNumberOfUpgradeQuest = _baseNumberOfUpgradeQuest;
        emit BaseNumberOfUpgradeQuestChanged(_baseNumberOfUpgradeQuest);
    }

    /**
     * @dev Set the base number of nectar use for upgrade.
     * @param _baseNectarUsePerUpgrade The base number of nectar.
     */
    function setBaseNectarUsePerUpgrade(
        uint256 _baseNectarUsePerUpgrade
    ) external onlyOwner {
        baseNectarUsePerUpgrade = _baseNectarUsePerUpgrade;
        emit BaseNectarUsePerUpgradeChanged(_baseNectarUsePerUpgrade);
    }

    /**
     * @dev Set the base number of pollen use for upgrade.
     * @param _basePollenUsePerUpgrade The base number of pollen.
     */
    function setBasePollenUsePerUpgrade(
        uint256 _basePollenUsePerUpgrade
    ) external onlyOwner {
        basePollenUsePerUpgrade = _basePollenUsePerUpgrade;
        emit BasePollenUsePerUpgradeChanged(_basePollenUsePerUpgrade);
    }

    /**
     * @dev Set the base number of sap use for upgrade.
     * @param _baseSapUsePerUpgrade The base number of sap.
     */
    function setBaseSapUsePerUpgrade(
        uint256 _baseSapUsePerUpgrade
    ) external onlyOwner {
        baseSapUsePerUpgrade = _baseSapUsePerUpgrade;
        emit BaseSapUsePerUpgradeChanged(_baseSapUsePerUpgrade);
    }

    /**
     * @dev Set the Cs constant.
     * @param _Cs The Cs constant.
     */
    function setCs(uint256 _Cs) external onlyOwner {
        Cs = _Cs;
        emit CsChanged(_Cs);
    }

    /**
     * @dev Set the Cn constant.
     * @param _Cn The Cn constant.
     */
    function setCn(uint256 _Cn) external onlyOwner {
        Cn = _Cn;
        emit CnChanged(_Cn);
    }

    /**
     * @dev Set the Cp constant.
     * @param _Cp The Cp constant.
     */
    function setCp(uint256 _Cp) external onlyOwner {
        Cp = _Cp;
        emit CpChanged(_Cp);
    }
}
