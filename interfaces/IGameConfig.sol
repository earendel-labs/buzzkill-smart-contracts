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
    function baseEnergyDeductionAfterUpgrade() external view returns (uint256);
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
    function baseNectarUsePerUpgrade() external view returns (uint256);
    function basePollenUsePerUpgrade() external view returns (uint256);
    function baseSapUsePerUpgrade() external view returns (uint256);
    function Cs() external view returns (uint256);
    function Cn() external view returns (uint256);
    function Cp() external view returns (uint256);
}
