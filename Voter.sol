// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Voter {

    struct OptionPos {
        uint pos;
        bool exists;
    }
    uint256[] public votes;
    string[] public options;
    mapping(address => bool) voterRecord;
    mapping (string => OptionPos) posOfOption;

    constructor(string[] memory _options) {
        options = _options;
        votes = new uint256[](_options.length);

              
        for(uint i=0; i< options.length; i++) {
            OptionPos memory option = OptionPos(i, true);
            posOfOption[options[i]] = option;
        }
    }

    function vote(uint256 option) public {
        require(option < options.length, "Invalid Options!");
        require(!voterRecord[msg.sender], "Already Voted!!!");

        recordVote(option); 
    }

    function vote(string memory option) public {
        require(!voterRecord[msg.sender], "Already Voted!!!");
        // bool optionsFound;
        // for(uint i=0; i<options.length; i++) {
        //     string memory currOption = options[i];
        //     if(stringEqual(option, currOption)) {
        //         recordVote(i); 
        //         optionsFound = true;
        //         revert();
        //     }
        // }
        // require(optionsFound, "Invalid Options!");+
        OptionPos memory optionPos = posOfOption[option];
        require(optionPos.exists, "Invalid Option!!");

        recordVote(optionPos.pos);


    }

    // function stringEqual(string memory a, string memory b) private returns(bool) {
    //     return keccak256(bytes(a)) == keccak256(bytes(b));
    // }

    function recordVote(uint256 option) private  {
        voterRecord[msg.sender] = true;
        votes[option] = votes[option] + 1;
    }

    function getOptions() public view returns (string[] memory) {
        return options;
    }

    function getVotes() public view returns (uint256[] memory) {
        return votes;
    }

    // function getVoterRecord() public view returns(uint256) {
    //     return voterRecord[msg.sender];
    // }
}
