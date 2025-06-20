// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleLottery {
    address public manager;
    address[] public players;

    event PlayerEntered(address indexed player);
    event WinnerPicked(address indexed winner);

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value >= 0.01 ether, "Minimum 0.01 ETH required to enter");
        players.push(msg.sender);
        emit PlayerEntered(msg.sender);
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function pickWinner() public {
        require(msg.sender == manager, "Only manager can pick winner");
        require(players.length > 0, "No players in the lottery");

        uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players))) % players.length;
        address winner = players[randomIndex];

        payable(winner).transfer(address(this).balance);
        emit WinnerPicked(winner);

        delete players;
    }
}
