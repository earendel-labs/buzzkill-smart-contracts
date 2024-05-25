// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../../interfaces/IGameConfig.sol";

contract GameConfig is IGameConfig, Initializable, OwnableUpgradeable {
    uint256 public beeEnergyRefreshInterval; // Time interval to refresh bee energy
    uint256 public beeHealthRefreshInterval; // Time interval to refresh bee health
    uint256 public amountToLevelUp; // 100 points per level
    uint256 public maxQueen; // Maximum 3 queens in a hive
    uint256 public maxWorker; // Maximum 55 workers in a hive
    uint256 public foragePercentage; // 5% of the gathered resources are added to the hive
    uint256 public claimTimeInterval; // 1 week interval between honey claim
    uint256 public honeyYieldConstant; // Contanst to caculate honey yield
    uint256 public nectarRequiredToClaim; // Required at least 5000 nectar to claim honey
    uint256 public experienceEarnedAfterForage; // 20 experience points earned after foraging
    uint256 public experienceEarnedAfterRaidFailed; // 10 experience points earned after a failed raid
    uint256 public experienceEarnedAfterRaidSuccess; // 30 experience points earned after a successful raid
    uint256 public baseHealthDeductionAfterRaid; // 5 HP deducted after a raid
    uint256 public raidHoneyFee; // 10 $HONEY paid for one raid
    uint256 public raidSapFee; // 100 sap for one raid
    uint256 public baseHoneyRaidReward; // base honey earn for one raid success is 10 $HONEY
    uint256 public productivityEarnAfterRaid; // 10 productivity points earned after a raid
    uint256 public maxResourcesValue; // The maximum density or availability of nectar, pollen, and sap in the environment is 100
    uint256 public minResourcesValue; // The minimum density or availability of nectar, pollen, and sap in the environment is 1
    uint256 public maxEnergyDeductionValue; // The maximum energy deduction value is 5
    uint256 public minEnergyDeductionValue; // The minimum energy deduction value is 1
    uint256 public resourcesRefreshInterval; // Resources refresh every 24 hours
    /**
     * Cn ,Cp ,Cs are constants that adjust the scale of resources gathered to fit the game's economy and balance.
     * These constants can be used to fine-tune how rewarding foraging feels in the game
     * Make sure to adjust these constants carefully to ensure the game is not too easy or too hard
     */
    uint256 public Cs;
    uint256 public Cn;
    uint256 public Cp;

    // Events for logging changes
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
    event BaseHealthDeductionAfterRaidChanged(
        uint256 newBaseHealthDeductionAfterRaid
    );
    event RaidHoneyFeeChanged(uint256 newRaidHoneyFee);
    event RaidSapFeeChanged(uint256 newRaidSapFee);
    event BaseHoneyRaidRewardChanged(uint256 newBaseHoneyRaidReward);
    event ProductivityEarnAfterRaidChanged(
        uint256 newProductivityEarnAfterRaid
    );
    event MaxResourcesValueChanged(uint256 newMaxResourcesValue);
    event MinResourcesValueChanged(uint256 newMinResourcesValue);
    event MaxEnergyDeductionValueChanged(uint256 newMaxEnergyDeductionValue);
    event MinEnergyDeductionValueChanged(uint256 newMinEnergyDeductionValue);
    event ResourcesRefreshIntervalChanged(uint256 newResourcesRefreshInterval);
    event CsChanged(uint256 newCs);
    event CnChanged(uint256 newCn);
    event CpChanged(uint256 newCp);

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
        nectarRequiredToClaim = 5_000;
        experienceEarnedAfterForage = 20;
        experienceEarnedAfterRaidFailed = 10;
        experienceEarnedAfterRaidSuccess = 30;
        baseHealthDeductionAfterRaid = 5;
        raidHoneyFee = 10 ether;
        raidSapFee = 100;
        baseHoneyRaidReward = 10 ether;
        productivityEarnAfterRaid = 10;
        maxResourcesValue = 1_000_000;
        minResourcesValue = 10_000;
        maxEnergyDeductionValue = 5;
        minEnergyDeductionValue = 1;
        resourcesRefreshInterval = 1 days;
        Cs = 25_000;
        Cn = 25_000;
        Cp = 25_000;
    }

    function setBeeEnergyRefreshInterval(
        uint256 _beeEnergyRefreshInterval
    ) external onlyOwner {
        beeEnergyRefreshInterval = _beeEnergyRefreshInterval;
        emit BeeEnergyRefreshIntervalChanged(_beeEnergyRefreshInterval);
    }

    function setBeeHealthRefreshInterval(
        uint256 _beeHealthRefreshInterval
    ) external onlyOwner {
        beeHealthRefreshInterval = _beeHealthRefreshInterval;
        emit BeeHealthRefreshIntervalChanged(_beeHealthRefreshInterval);
    }

    function setAmountToLevelUp(uint256 _amountToLevelUp) external onlyOwner {
        amountToLevelUp = _amountToLevelUp;
        emit AmountToLevelUpChanged(_amountToLevelUp);
    }

    function setMaxQueen(uint256 _maxQueen) external onlyOwner {
        maxQueen = _maxQueen;
        emit MaxQueenChanged(_maxQueen);
    }

    function setMaxWorker(uint256 _maxWorker) external onlyOwner {
        maxWorker = _maxWorker;
        emit MaxWorkerChanged(_maxWorker);
    }

    function setForagePercentage(uint256 _foragePercentage) external onlyOwner {
        foragePercentage = _foragePercentage;
        emit ForagePercentageChanged(_foragePercentage);
    }

    function setClaimTimeInterval(
        uint256 _claimTimeInterval
    ) external onlyOwner {
        claimTimeInterval = _claimTimeInterval;
        emit ClaimTimeIntervalChanged(_claimTimeInterval);
    }

    function setHoneyYieldConstant(
        uint256 _honeyYieldConstant
    ) external onlyOwner {
        honeyYieldConstant = _honeyYieldConstant;
        emit HoneyYieldConstantChanged(_honeyYieldConstant);
    }

    function setNectarRequiredToClaim(
        uint256 _nectarRequiredToClaim
    ) external onlyOwner {
        nectarRequiredToClaim = _nectarRequiredToClaim;
        emit NectarRequiredToClaimChanged(_nectarRequiredToClaim);
    }

    function setExperienceEarnedAfterForage(
        uint256 _experienceEarnedAfterForage
    ) external onlyOwner {
        experienceEarnedAfterForage = _experienceEarnedAfterForage;
        emit ExperienceEarnedAfterForageChanged(_experienceEarnedAfterForage);
    }

    function setExperienceEarnedAfterRaidFailed(
        uint256 _experienceEarnedAfterRaidFailed
    ) external onlyOwner {
        experienceEarnedAfterRaidFailed = _experienceEarnedAfterRaidFailed;
        emit ExperienceEarnedAfterRaidFailedChanged(
            _experienceEarnedAfterRaidFailed
        );
    }

    function setExperienceEarnedAfterRaidSuccess(
        uint256 _experienceEarnedAfterRaidSuccess
    ) external onlyOwner {
        experienceEarnedAfterRaidSuccess = _experienceEarnedAfterRaidSuccess;
        emit ExperienceEarnedAfterRaidSuccessChanged(
            _experienceEarnedAfterRaidSuccess
        );
    }

    function setBaseHealthDeductionAfterRaid(
        uint256 _baseHealthDeductionAfterRaid
    ) external onlyOwner {
        baseHealthDeductionAfterRaid = _baseHealthDeductionAfterRaid;
        emit BaseHealthDeductionAfterRaidChanged(_baseHealthDeductionAfterRaid);
    }

    function setRaidHoneyFee(uint256 _raidHoneyFee) external onlyOwner {
        raidHoneyFee = _raidHoneyFee;
        emit RaidHoneyFeeChanged(_raidHoneyFee);
    }

    function setRaidSapFee(uint256 _raidSapFee) external onlyOwner {
        raidSapFee = _raidSapFee;
        emit RaidSapFeeChanged(_raidSapFee);
    }

    function setBaseHoneyRaidReward(
        uint256 _baseHoneyRaidReward
    ) external onlyOwner {
        baseHoneyRaidReward = _baseHoneyRaidReward;
        emit BaseHoneyRaidRewardChanged(_baseHoneyRaidReward);
    }

    function setProductivityEarnAfterRaid(
        uint256 _productivityEarnAfterRaid
    ) external onlyOwner {
        productivityEarnAfterRaid = _productivityEarnAfterRaid;
        emit ProductivityEarnAfterRaidChanged(_productivityEarnAfterRaid);
    }

    function setMaxResourcesValue(
        uint256 _maxResourcesValue
    ) external onlyOwner {
        maxResourcesValue = _maxResourcesValue;
        emit MaxResourcesValueChanged(_maxResourcesValue);
    }

    function setMinResourcesValue(
        uint256 _minResourcesValue
    ) external onlyOwner {
        minResourcesValue = _minResourcesValue;
        emit MinResourcesValueChanged(_minResourcesValue);
    }

    function setMaxEnergyDeductionValue(
        uint256 _maxEnergyDeductionValue
    ) external onlyOwner {
        maxEnergyDeductionValue = _maxEnergyDeductionValue;
        emit MaxEnergyDeductionValueChanged(_maxEnergyDeductionValue);
    }

    function setMinEnergyDeductionValue(
        uint256 _minEnergyDeductionValue
    ) external onlyOwner {
        minEnergyDeductionValue = _minEnergyDeductionValue;
        emit MinEnergyDeductionValueChanged(_minEnergyDeductionValue);
    }

    function setResourcesRefreshInterval(
        uint256 _resourcesRefreshInterval
    ) external onlyOwner {
        resourcesRefreshInterval = _resourcesRefreshInterval;
        emit ResourcesRefreshIntervalChanged(_resourcesRefreshInterval);
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
