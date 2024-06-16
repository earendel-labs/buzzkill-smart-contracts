// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IGameConfig {
    // Getter functions
    function beeEnergyRefreshInterval() external view returns (uint256);
    function beeHealthRefreshInterval() external view returns (uint256);
    function amountToLevelUp() external view returns (uint256);
    function maxQueen() external view returns (uint256);
    function maxWorker() external view returns (uint256);
    function foragePercentage() external view returns (uint256);
    function claimTimeInterval() external view returns (uint256);
    function honeyYieldConstant() external view returns (uint256);
    function nectarRequiredToClaim() external view returns (uint256);
    function experienceEarnedAfterForage() external view returns (uint256);
    function experienceEarnedAfterRaidFailed() external view returns (uint256);
    function experienceEarnedAfterRaidSuccess() external view returns (uint256);
    function experienceEarnedAfterUpgrade() external view returns (uint256);
    function baseHealthDeductionAfterRaid() external view returns (uint256);
    function baseEnergyDeductionAfterRaid() external view returns (uint256);
    function raidHoneyFee() external view returns (uint256);
    function raidSapFee() external view returns (uint256);
    function baseHoneyRaidReward() external view returns (uint256);
    function incentiveEarnAfterRaid() external view returns (uint256);
    function maxResourcesValue() external view returns (uint256);
    function minResourcesValue() external view returns (uint256);
    function resourcesRefreshInterval() external view returns (uint256);
    function baseHoneyYield() external view returns (uint256);
    function baseIncentivePerEpoch() external view returns (uint256);
    function differenceBetweenLevels() external view returns (uint256);
    function amountAttackIncreaseOnLevelUp() external view returns (uint256);
    function amountDefenseIncreaseOnLevelUp() external view returns (uint256);
    function amountForageIncreaseOnLevelUp() external view returns (uint256);
    function amountEnergyIncreaseOnLevelUp() external view returns (uint256);
    function amountHealthIncreaseOnLevelUp() external view returns (uint256);
    function amountBaseProductivityIncreaseOnLevelUp()
        external
        view
        returns (uint256);
    function amountMaxProductivityIncreaseOnLevelUp()
        external
        view
        returns (uint256);
    function baseNumberOfForagingQuest() external view returns (uint256);
    function baseNumberOfRaidQuest() external view returns (uint256);
    function baseNumberOfRaidSuccessQuest() external view returns (uint256);
    function baseNumberOfUpgradeQuest() external view returns (uint256);
    function Cs() external view returns (uint256);
    function Cn() external view returns (uint256);
    function Cp() external view returns (uint256);

    // Setter functions
    function setBeeEnergyRefreshInterval(
        uint256 _beeEnergyRefreshInterval
    ) external;
    function setBeeHealthRefreshInterval(
        uint256 _beeHealthRefreshInterval
    ) external;
    function setAmountToLevelUp(uint256 _amountToLevelUp) external;
    function setMaxQueen(uint256 _maxQueen) external;
    function setMaxWorker(uint256 _maxWorker) external;
    function setForagePercentage(uint256 _foragePercentage) external;
    function setClaimTimeInterval(uint256 _claimTimeInterval) external;
    function setHoneyYieldConstant(uint256 _honeyYieldConstant) external;
    function setNectarRequiredToClaim(uint256 _nectarRequiredToClaim) external;
    function setExperienceEarnedAfterForage(
        uint256 _experienceEarnedAfterForage
    ) external;
    function setExperienceEarnedAfterRaidFailed(
        uint256 _experienceEarnedAfterRaidFailed
    ) external;
    function setExperienceEarnedAfterRaidSuccess(
        uint256 _experienceEarnedAfterRaidSuccess
    ) external;
    function setExperienceEarnedAfterUpgrade(
        uint256 _experienceEarnedAfterUpgrade
    ) external;
    function setBaseHealthDeductionAfterRaid(
        uint256 _baseHealthDeductionAfterRaid
    ) external;
    function setBaseEnergyDeductionAfterRaid(
        uint256 _baseEnergyDeductionAfterRaid
    ) external;
    function setRaidHoneyFee(uint256 _raidHoneyFee) external;
    function setRaidSapFee(uint256 _raidSapFee) external;
    function setBaseHoneyRaidReward(uint256 _baseHoneyRaidReward) external;
    function setIncentiveEarnAfterRaid(
        uint256 _IncentiveEarnAfterRaid
    ) external;
    function setMaxResourcesValue(uint256 _maxResourcesValue) external;
    function setMinResourcesValue(uint256 _minResourcesValue) external;
    function setResourcesRefreshInterval(
        uint256 _resourcesRefreshInterval
    ) external;
    function setBaseHoneyYield(uint256 _baseHoneyYield) external;
    function setBaseIncentivePerEpoch(uint256 _baseIncentivePerEpoch) external;
    function setDifferenceBetweenLevels(
        uint256 _differenceBetweenLevels
    ) external;
    function setAmountAttackIncreaseOnLevelUp(
        uint256 _amountAttackIncreaseOnLevelUp
    ) external;
    function setAmountDefenseIncreaseOnLevelUp(
        uint256 _amountDefenseIncreaseOnLevelUp
    ) external;
    function setAmountForageIncreaseOnLevelUp(
        uint256 _amountForageIncreaseOnLevelUp
    ) external;
    function setAmountEnergyIncreaseOnLevelUp(
        uint256 _amountEnergyIncreaseOnLevelUp
    ) external;
    function setAmountHealthIncreaseOnLevelUp(
        uint256 _amountHealthIncreaseOnLevelUp
    ) external;
    function setAmountBaseProductivityIncreaseOnLevelUp(
        uint256 _amountBaseProductivityIncreaseOnLevelUp
    ) external;
    function setAmountMaxProductivityIncreaseOnLevelUp(
        uint256 _amountMaxProductivityIncreaseOnLevelUp
    ) external;
    function setBaseNumberOfForagingQuest(
        uint256 _baseNumberOfForagingQuest
    ) external;
    function setBaseNumberOfRaidQuest(uint256 _baseNumberOfRaidQuest) external;
    function setBaseNumberOfRaidSuccessQuest(
        uint256 _baseNumberOfRaidSuccessQuest
    ) external;
    function setBaseNumberOfUpgradeQuest(
        uint256 _baseNumberOfUpgradeQuest
    ) external;
    function setCs(uint256 _Cs) external;
    function setCn(uint256 _Cn) external;
    function setCp(uint256 _Cp) external;
}
