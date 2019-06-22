pragma solidity ^0.5.0;

contract Election {
	//Model a Candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;

	}
	//store accounts that have vouted
	mapping(address => bool) public voters;
	//Store Candidates
	//Fetch Candidate
	mapping(uint => Candidate) public candidates;
	//Store Candidates Count
	uint public candidatesCount;
	//voted event
	event votedEvent(
		uint indexed _candidateId
		);

	constructor () public {
		addCandidate("الطالب الأول");
		addCandidate("الطالب الثاني");
	}
	function addCandidate (string memory hisName) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, hisName, 0);
	}
	function vote(uint _candidateId) public {
		//require that they haven't voted before
		require(!voters[msg.sender]);
		//require a valid candidate
		require(_candidateId > 0 && _candidateId <=candidatesCount);
		//record that voter has voted
		voters[msg.sender] = true;
		//ubdate candidate vote count
		candidates[_candidateId].voteCount++;

		// trigger voted event
        emit votedEvent( _candidateId );
	}
}	
