const _NETWORK_ID = 80001;
let SELECT_CONTRACT = {};

SELECT_CONTRACT[_NETWORK_ID] = {
    network_name: "Polygon Mumbai",
    explorer_url: "https://mumbai.polygonscan.com/",
    STACKING: {
        //
        sevenDays: { 
            address: "0x3233F5468B6c18679244fcaFd0705f3247C9A9Ec", //new address deployed
        },
        tenDays: { 
            address: "0x052272f56bccB87ec338B1CF1031CbFd43Bb187e",
        },
        thirtyTwoDays: {
            address: "0xB7c574682B9084E4146294312dafB41516556A5E",
        },
        ninetyDays: {
            address: "0xEffB8e5c3D6C618B0CfCF4a7F3Fc3aAc233c48f6",
        },
        abi: [
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "internalType": "address",
                "name": "user",
                "type": "address"
              },
              {
                "indexed": false,
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "ClaimReward",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "internalType": "address",
                "name": "user",
                "type": "address"
              },
              {
                "indexed": false,
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "EarlyUnStakeFee",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": false,
                "internalType": "uint8",
                "name": "version",
                "type": "uint8"
              }
            ],
            "name": "Initialized",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "internalType": "address",
                "name": "previousOwner",
                "type": "address"
              },
              {
                "indexed": true,
                "internalType": "address",
                "name": "newOwner",
                "type": "address"
              }
            ],
            "name": "OwnershipTransferred",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "internalType": "address",
                "name": "user",
                "type": "address"
              },
              {
                "indexed": false,
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "Stake",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "internalType": "address",
                "name": "user",
                "type": "address"
              },
              {
                "indexed": false,
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "UnStake",
            "type": "event"
          },
          {
            "inputs": [],
            "name": "APY_RATE_CHANGE_THRESHOLD",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "PERCENTAGE_DENOMINATOR",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "claimReward",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getAPY",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getEarlyUnstakeFeePercentage",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getMaxStakingTokenLimit",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getMinimumStakingAmount",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getStakeDays",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getStakeEndDate",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getStakeStartDate",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getStakingStatus",
            "outputs": [
              {
                "internalType": "bool",
                "name": "",
                "type": "bool"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getTotalStakedTokens",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getTotalUsers",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "userAddress",
                "type": "address"
              }
            ],
            "name": "getUser",
            "outputs": [
              {
                "components": [
                  {
                    "internalType": "uint256",
                    "name": "stakeAmount",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "rewardAmount",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "lastStakeTime",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "lastRewardCalculationTime",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "rewardsClaimedSoFar",
                    "type": "uint256"
                  }
                ],
                "internalType": "struct TokenStaking.User",
                "name": "",
                "type": "tuple"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getUserEstimatedRewards",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getWithdrawableAmount",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "owner_",
                "type": "address"
              },
              {
                "internalType": "address",
                "name": "tokenAddress_",
                "type": "address"
              },
              {
                "internalType": "uint256",
                "name": "apyRate_",
                "type": "uint256"
              },
              {
                "internalType": "uint256",
                "name": "minimumStakingAmount_",
                "type": "uint256"
              },
              {
                "internalType": "uint256",
                "name": "maxStakeTokenLimit_",
                "type": "uint256"
              },
              {
                "internalType": "uint256",
                "name": "stakeStartDate_",
                "type": "uint256"
              },
              {
                "internalType": "uint256",
                "name": "stakeEndDate_",
                "type": "uint256"
              },
              {
                "internalType": "uint256",
                "name": "stakeDays_",
                "type": "uint256"
              },
              {
                "internalType": "uint256",
                "name": "earlyUnstakeFeePercentage_",
                "type": "uint256"
              }
            ],
            "name": "initialize",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "_user",
                "type": "address"
              }
            ],
            "name": "isStakeHolder",
            "outputs": [
              {
                "internalType": "bool",
                "name": "",
                "type": "bool"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "owner",
            "outputs": [
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "renounceOwnership",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "_amount",
                "type": "uint256"
              }
            ],
            "name": "stake",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
              },
              {
                "internalType": "address",
                "name": "user",
                "type": "address"
              }
            ],
            "name": "stakeForUser",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "toggleStakingStatus",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "newOwner",
                "type": "address"
              }
            ],
            "name": "transferOwnership",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "_amount",
                "type": "uint256"
              }
            ],
            "name": "unstake",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "newPercentage",
                "type": "uint256"
              }
            ],
            "name": "updateEarlyUnstakePercentage",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "newAmount",
                "type": "uint256"
              }
            ],
            "name": "updateMaximumStakingAmount",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "newAmount",
                "type": "uint256"
              }
            ],
            "name": "updateMinimumStakingAmount",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "newDate",
                "type": "uint256"
              }
            ],
            "name": "updateStakingEndDate",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "withdraw",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
          }
        ],
    },

    TOKEN: {
        symbol: "TBC",
        address: "0xcDdc7D159Bc2c9b1eB073384a6926d37da782918", //new deployed address
        abi: [
          {
            "inputs": [],
            "stateMutability": "nonpayable",
            "type": "constructor"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "internalType": "address",
                "name": "_owner",
                "type": "address"
              },
              {
                "indexed": true,
                "internalType": "address",
                "name": "_spender",
                "type": "address"
              },
              {
                "indexed": false,
                "internalType": "uint256",
                "name": "_value",
                "type": "uint256"
              }
            ],
            "name": "Approval",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "internalType": "address",
                "name": "_from",
                "type": "address"
              },
              {
                "indexed": true,
                "internalType": "address",
                "name": "_to",
                "type": "address"
              },
              {
                "indexed": false,
                "internalType": "uint256",
                "name": "_value",
                "type": "uint256"
              }
            ],
            "name": "Transfer",
            "type": "event"
          },
          {
            "inputs": [],
            "name": "_userId",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              },
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              }
            ],
            "name": "allowance",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "_spender",
                "type": "address"
              },
              {
                "internalType": "uint256",
                "name": "_value",
                "type": "uint256"
              }
            ],
            "name": "approve",
            "outputs": [
              {
                "internalType": "bool",
                "name": "success",
                "type": "bool"
              }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              }
            ],
            "name": "balanceOf",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "getTokenHolder",
            "outputs": [
              {
                "internalType": "address[]",
                "name": "",
                "type": "address[]"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "_address",
                "type": "address"
              }
            ],
            "name": "getTokenHolderData",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              },
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              },
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              },
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              },
              {
                "internalType": "bool",
                "name": "",
                "type": "bool"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "name": "holderToken",
            "outputs": [
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "name",
            "outputs": [
              {
                "internalType": "string",
                "name": "",
                "type": "string"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "ownerOfContract",
            "outputs": [
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "standard",
            "outputs": [
              {
                "internalType": "string",
                "name": "",
                "type": "string"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "symbol",
            "outputs": [
              {
                "internalType": "string",
                "name": "",
                "type": "string"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "",
                "type": "address"
              }
            ],
            "name": "tokenHolderInfos",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "_tokenId",
                "type": "uint256"
              },
              {
                "internalType": "address",
                "name": "_from",
                "type": "address"
              },
              {
                "internalType": "address",
                "name": "_to",
                "type": "address"
              },
              {
                "internalType": "uint256",
                "name": "_totalToken",
                "type": "uint256"
              },
              {
                "internalType": "bool",
                "name": "_tokenHolder",
                "type": "bool"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [],
            "name": "totalSupply",
            "outputs": [
              {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "_to",
                "type": "address"
              },
              {
                "internalType": "uint256",
                "name": "_value",
                "type": "uint256"
              }
            ],
            "name": "transfer",
            "outputs": [
              {
                "internalType": "bool",
                "name": "success",
                "type": "bool"
              }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "internalType": "address",
                "name": "_from",
                "type": "address"
              },
              {
                "internalType": "address",
                "name": "_to",
                "type": "address"
              },
              {
                "internalType": "uint256",
                "name": "_value",
                "type": "uint256"
              }
            ],
            "name": "transferFrom",
            "outputs": [
              {
                "internalType": "bool",
                "name": "success",
                "type": "bool"
              }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
          }
        ],
    },
};

/* countdown global */
let countDownGlobal;

/* wallet connection*/

let web3;

let oContractToken;

let contractCall = "sevenDays";

let currentAddress;

let web3Main = new Web3("https://rpc.ankr.com/polygon_mumbai");


//create an instance of Notyf
var notyf = new Notyf({
    duration: 5000,
    position: { x: "right", y: "bottom" }
});

