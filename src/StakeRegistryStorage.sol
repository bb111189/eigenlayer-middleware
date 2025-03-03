// SPDX-License-Identifier: BUSL-1.1
pragma solidity =0.8.12;

import {IStrategyManager} from "eigenlayer-contracts/src/contracts/interfaces/IStrategyManager.sol";
import {IServiceManager} from "src/interfaces/IServiceManager.sol";
import {IStakeRegistry} from  "src/interfaces/IStakeRegistry.sol";
import {IRegistryCoordinator} from "src/interfaces/IRegistryCoordinator.sol";

/**
 * @title Storage variables for the `StakeRegistry` contract.
 * @author Layr Labs, Inc.
 * @notice This storage contract is separate from the logic to simplify the upgrade process.
 */
abstract contract StakeRegistryStorage is IStakeRegistry {
    /// @notice the coordinator contract that this registry is associated with
    IRegistryCoordinator public immutable registryCoordinator;

    /// @notice In order to register for a quorum i, an operator must have at least `minimumStakeForQuorum[i]`
    /// evaluated by this contract's 'VoteWeigher' logic.
    uint96[256] public minimumStakeForQuorum;

    /// @notice array of the history of the total stakes for each quorum -- marked as internal since getTotalStakeFromIndex is a getter for this
    OperatorStakeUpdate[][256] internal _totalStakeHistory;

    /// @notice mapping from operator's operatorId to the history of their stake updates
    mapping(bytes32 => mapping(uint8 => OperatorStakeUpdate[])) internal operatorIdToStakeHistory;

    constructor(IRegistryCoordinator _registryCoordinator) {
        registryCoordinator = _registryCoordinator;
    }

    // storage gap for upgradeability
    // slither-disable-next-line shadowing-state
    uint256[65] private __GAP;
}
