//FUNCTION CALL
loadInitialData("sevenDays");
connectMe("metamask_wallet");
function connectWallet() {}

function openTab(event, name) {
    console.log(name);
    contractCall = name;
    getSelectedTab(name);
    loadInitialData(name);
}

async function loadInitialData(sClass) {
    console.log(sClass);
    try {
        clearInterval(countDownGlobal);
        
        let cObj = new web3Main.eth.Contract(
            SELECT_CONTRACT[_NETWORK_ID].STACKING.abi,
            SELECT_CONTRACT[_NETWORK_ID].STACKING[sClass].address
        );

        //ID ELEMENT DATA
        let totalUsers = await cObj.methods.getTotalUsers().call();
        let cApy = await cObj.methods.getAPY().call();
        //GET USER
        let userDetail = await cObj.methods.getUser(currentAddress).call();

        const user = {
            lastRewardCalculationTime: userDetail.lastRewardCalculationTime,
            lastStakeTime: userDetail.lastStakeTime,
            rewardAmount: userDetail.rewardAmount,
            rewardsClaimedSoFar: userDetail.rewardsClaimedSoFar,
            stakeAmount: userDetail.stakeAmount,
            address: currentAddress,
        };
        localStorage.setItem("User", JSON.stringify(user));

        let userDetailBal = userDetail.stakeAmount / 10 ** 18;
        document.getElementById(
            "total-locked-user-token"
        ).innerHTML = `${userDetailBal}`;

        //ELEMENTS --ID
        document.getElementById(
            "num-of-staackers-value"
        ).innerHTML = `${totalUsers}`;
        document.getElementById("apy-value-feature").innerHTML = `${cApy} %`;

        //ClASS ELEMENT DATA
        let totalLockedTokens = await cObj.methods.getTotalStakedTokens().call();
        let earlyUnstakedFee = await cObj.methods
        .getEarlyUnstakeFeePercentage()
        .call();

        //ELEMENTS --CLASS
        document.getElementById("total-locked-tokens-value").innerHTML = 
        `${totalLockedTokens / 10 ** 18 } ${SELECT_CONTRACT[_NETWORK_ID].TOKEN.symbol}`;

        document
        .querySelectorAll(".early-unstake-fee-value")
        .forEach(function (element) {
            element.innerHTML = `${earlyUnstakedFee / 100}%`;
        });

        let minStakeAmount = await cObj.methods.getMinimumStakingAmount().call();
        minStakeAmount = Number(minStakeAmount);
        let minA;
    }
}