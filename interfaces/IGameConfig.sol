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
    function baseHealthDeductionAfterRaid() external view returns (uint256);
    function raidHoneyFee() external view returns (uint256);
    function raidSapFee() external view returns (uint256);
    function baseHoneyRaidReward() external view returns (uint256);
    function productivityEarnAfterRaid() external view returns (uint256);
    function maxResourcesValue() external view returns (uint256);
    function minResourcesValue() external view returns (uint256);
    function maxEnergyDeductionValue() external view returns (uint256);
    function minEnergyDeductionValue() external view returns (uint256);
    function resourcesRefreshInterval() external view returns (uint256);
    function baseHoneyYield() external view returns (uint256);
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
    function setBaseHealthDeductionAfterRaid(
        uint256 _baseHealthDeductionAfterRaid
    ) external;
    function setRaidHoneyFee(uint256 _raidHoneyFee) external;
    function setRaidSapFee(uint256 _raidSapFee) external;
    function setBaseHoneyRaidReward(uint256 _baseHoneyRaidReward) external;
    function setProductivityEarnAfterRaid(
        uint256 _productivityEarnAfterRaid
    ) external;
    function setMaxResourcesValue(uint256 _maxResourcesValue) external;
    function setMinResourcesValue(uint256 _minResourcesValue) external;
    function setMaxEnergyDeductionValue(
        uint256 _maxEnergyDeductionValue
    ) external;
    function setMinEnergyDeductionValue(
        uint256 _minEnergyDeductionValue
    ) external;
    function setResourcesRefreshInterval(
        uint256 _resourcesRefreshInterval
    ) external;
    function setCs(uint256 _Cs) external;
    function setCn(uint256 _Cn) external;
    function setCp(uint256 _Cp) external;
}
