// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;

contract Twitter{
    struct Tweet{
        uint id; // identifying the tweet with the help of id
        address author;
        uint createdAt;
        string content;
    }

    struct Message{
        uint id;
        address from;
        address to;
        string content;
        uint createdAt;
    }

    mapping(uint => Tweet) public tweets;
    mapping(address=>uint[]) public tweetsOf; // storing the tweets id's 
    mapping(address => Message[]) conversation;
    mapping(address=>address[]) followers;
    mapping(address=>mapping(address=>bool)) public operators;

    uint nextId;
    uint nextMessageId;

    function tweet(address _from,string memory _content) public{
        require(msg.sender == _from,"you are not authorised");
        tweets[nextId] = Tweet(nextId,_from,block.timestamp,_content);
        tweetsOf[_from].push(nextId);
        nextId++;
    }

    function _sendMessage(string memory _content,address _from,address _to) public{
        require(msg.sender == _from,"you are not authorised");
        conversation[_from].push(Message(nextMessageId,_from,_to,_content,block.timestamp));
        nextMessageId++;
    }


}
