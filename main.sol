// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SubwaySurfers {
    struct Player {
        uint256 score;
        bool isRunning;
    }

    mapping(address => Player) public players;

    event RunStarted(address indexed player);
    event StepTaken(address indexed player, uint256 score);
    event GameOver(address indexed player, uint256 finalScore);

    function startRun() external {
        require(!players[msg.sender].isRunning, "Game already running");
        players[msg.sender] = Player(0, true);
        emit RunStarted(msg.sender);
    }

    function step(bool dodgeLeft, bool dodgeRight) external {
        Player storage player = players[msg.sender];
        require(player.isRunning, "Start the game first");

        // Random obstacle: 0 = left, 1 = right, 2 = center (no obstacle)
        uint256 random = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, player.score))) % 3;

        if (
            (random == 0 && dodgeLeft) ||
            (random == 1 && dodgeRight) ||
            (random == 2 && !dodgeLeft && !dodgeRight)
        ) {
            // Successful dodge or no obstacle
            player.score += 1;
            emit StepTaken(msg.sender, player.score);
        } else {
            // Hit obstacle
            emit GameOver(msg.sender, player.score);
            delete players[msg.sender];
        }
    }

    function getScore(address player) external view returns (uint256) {
        return players[player].score;
    }

    function isPlaying(address player) external view returns (bool) {
        return players[player].isRunning;
    }
}
