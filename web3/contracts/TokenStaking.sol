// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//IMPORTING CONTRACT
import "./ownable.sol";
import "./ReentrancyGuard.sol";
import "./Initializable.sol";
import "./IERC20.sol";

contract TokenStaking is Ownable, ReentrancyGuard, Initializable {

    //Struct to store the user's Details
    struct User {
        uint256 stakeAmount; //Srake amount
        uint256 rewardAmount; //Reward Amount
        uint256 lastStakeTime; //Last stake timestamp
        uint256 lastRewardCalculationTime; //Last reward calculation timestamp
        uint256 rewardsClaimedSoFar; //sum of rewards claimed so far
    }

    uint256 _minimumStakingAmount; //minimum staking amount

    uint256 _maxStakeTokenLimit; //maximum staking token limit for program

    uint256 _stakeEndDate; //end date for program

    uint256 _stakeStartDate; //statrt date for program

    uint256 _totalStakedTokens; //total no of tokens that are staked

    uint256 _totalUsers; //total no of users

    uint256 _stakeDays; //staking days

    uint256 _earlyUnstakeFeePercentage; //early unstake fee %

    bool _isStakingPaused; //staking status

    //Token contract address
    address private _tokenAddress;

    //APY
    uint256 _apyRate;

    uint256 public constant PERCENTAGE_DENOMINATOR = 10000;
    uint256 public constant APY_RATE_CHANGE_THRESHOLD = 20;

    //user address => user
    mapping(address => User) private _users;

    event Stake(address indexed user, uint256 amount);
    event UnStake(address indexed user, uint256 amount);
    event EarlyUnStakeFee(address indexed user, uint256 amount);
    event ClaimReward(address indexed user, uint256 amount);

    modifier whenTreasuryHasBalance(uint256 amount) {
        require(
            IERC20(_tokenAddress).balanceOf((address(this))) >= amount,
            "TokenStaking: insufficient funds in the treasury"
        );
        _;
    }

    function initialize(
        address owner_,
        address tokenAddress_,
        uint256 apyRate_,
        uint256 minimumStakingAmount_,
        uint256 maxStakeTokenLimit_,
        uint256 stakeStartDate_,
        uint256 stakeEndDate_,
        uint256 stakeDays_,
        uint256 earlyUnstakeFeePercentage_
    ) public virtual initializer {
        __TokenStaking_init_unchained(
            owner_,
            tokenAddress_,
            apyRate_,
            minimumStakingAmount_,
            maxStakeTokenLimit_,
            stakeStartDate_,
            stakeEndDate_,
            stakeDays_,
            earlyUnstakeFeePercentage_
        );
    }

    function __TokenStaking_init_unchained(
        address owner_,
        address tokenAddress_,
        uint256 apyRate_,
        uint256 minimumStakingAmount_,
        uint256 maxStakeTokenLimit_,
        uint256 stakeStartDate_,
        uint256 stakeEndDate_,
        uint256 stakeDays_,
        uint256 earlyUnstakeFeePercentage_
    ) internal onlyInitializing {
        require(_apyRate <= 10000, "TokenStaking: apy rate should be less than 10000");
        require(stakeDays_ > 0, "TokenStaking: stake days must be non-zero");
        require(tokenAddress_ != address(0), "TokenStating: token address cant be 0 address");
        require(stakeStartDate_ < stakeEndDate_, "TokenStating: start date must be less than the end date");

        _transferOwnership(owner_);
        _tokenAddress = tokenAddress_;
        _apyRate = apyRate_;
        _minimumStakingAmount = minimumStakingAmount_;
        _maxStakeTokenLimit = maxStakeTokenLimit_;
        _stakeStartDate = stakeStartDate_;
        _stakeEndDate = stakeEndDate_;
        _stakeDays = stakeDays_ * 1 days;
        _earlyUnstakeFeePercentage = earlyUnstakeFeePercentage_;
    }

    /* View Method start 

        @notice this function is used to get the minimum staking amount */

        function getMinimumStakingAmount() external view returns (uint256) {
            return _minimumStakingAmount;
        }
    
    /* this function is used to get the staking end date for program */

    function getStakeEndDate() external view returns (uint256) {
        return _stakeEndDate;
    }

    /* This function is used to get the total no of tokens that are staked */

    function getTotalStakedTokens() external view returns (uint256) {
        return _totalStakedTokens;
    }

    /* this function is used to get stake days */
    function getStakeDays() external view returns (uint256) {
        return _stakeDays;
    }

    /* This function is used to get early unstake fee percentage */
    function getEarlyUnstakeFeePercentage() external view returns (uint256) {
        return _earlyUnstakeFeePercentage;
    }

    /* this function is used to get staking status */
    function getStakingStatus() external view returns (bool) {
        return _isStakingPaused;
    }

    /* this function is used to get the current APY Rate
    @return Current APY Rate */
    function getAPY() external view returns (uint256) {
        return _apyRate;
    }

    /* this function is used to get msg.sender's esstimaatted reward amount
    @return msg.sender's estimated reward amount */
    function getUserEstimatedRewards() external view returns (uint256) {
        (uint256 amount, ) = _getUserEstimatedRewards(msg.sender);
        return _users[msg.sender].rewardAmount + amount;
    }

    /* this function is used to get withdrawable amount from contract */
    function getWithdrawableAmount() external view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this)) - _totalStakedTokens;
    }

    /* function is used to get the User's details
    @param userAddress User's address to get details of 
    @return User Struct */

    function getUser(address userAddress) external view returns (User memory) {
        return _users[userAddress];
    }

    /* this function is used to check ifa user is a stakeholder
    @param _user Address of the user to check
    @return True if user is a stakeh , false otherwise */
    function isStakeHolder(address _user) external view returns (bool) {
        return _users[_user].stakeAmount != 0;
    }

    /* View Methods End */

    /*Owner Methods Start */
    /* FUNCTION is used to update minimum staking amount */

    function updateMinimumStakingAmount(uint256 newAmount) external onlyOwner {
        _minimumStakingAmount = newAmount;
    }
    \/* FUNCTION is used to update maximum staking amount */

    function updateMaximumStakingAmount(uint256 newAmount) external onlyOwner {
        _maxStakeTokenLimit = newAmount;
    }

    /* FUNCTION is used to update staking end date */

    function updateStakingEndDate(uint256 newDate) external onlyOwner {
        _stakeEndDate = newDate;
    }

    /* function used to update early unstake fee percentage */
    function updateEarlyUnstakePercentage(uint256 newPercentage) external onlyOwner {
        _earlyUnstakeFeePercentage = newPercentage;
    }

    /* stake tokens for specific user
    @dev function can be used to stake tokens for specific user

    @param amount the amount to stake
    @param user user's address
    */
    function stakeForUser(uint256 amount, address user) external onlyOwner nonReentrant {
        _stakeTokens(amount, user);
    }

    /*
    @notice enable/disable staking
    @dev function can be used to toggle staking status
    */
    function toggleStakingStatus() external onlyOwner {
        _isStakingPaused = !_isStakingPaused;
    }

    /* 
        @notice withdraw the specified amount if possible

        @dev function can be used to withdraw the available tokens with this contract to caller

        @param amount the amount to withdraw
    */
    function withdraw(uint256 amount) external onlyOwner nonReentrant {
        require(this.getWithdrawableAmount() >= amount, "TokenStaking: not enough withdrawable tokens");
        IERC20(_tokenAddress).transfer(msg.sender, amount);
    }

    /*
    OWNER methods end */
    /* user methods START */

    /* 
        @notice function is used to stake tokens
        params _amount of tokens to be staked
    */
    function stake(uint256 _amount) external nonReentrant {
        _stakeTokens(_amount, msg.sender);
    }

    function _stakeTokens(uint256 _amount, address user_) private {
        require(!_isStakingPaused, "TokenStaking: staking is paused");

        uint256 currentTime = getCurrentTime();
        require(currentTime > _stakeStartDate, "TokenStaking: staking not started yet");
        require(currentTime < _stakeEndDate, "TokenStaking: staking ended");
        require(_totalStakedTokens + _amount <= _maxStakeTokenLimit, "TokenStaking: max staking token limit reached");
        require(_amount > 0, "TokenStaking: stake amount must be non-zero");
        require(_amount >= _minimumStakingAmount, "TokenStaking: stake amount must be greater than minimum amount allowed");

        if (_users[user_].stakeAmount != 0) {
            _calculateRewards(user_);
        } else {
            _users[user_].lastRewardCalculationTime = currentTime;
            _totalUsers += 1;
        }

        _users[user_].stakeAmount += _amount;
        _users[user_].lastStakeTime = currentTime;

        _totalStakedTokens += _amount;

        require(
            IERC20(_tokenAddress).transferFrom(msg.sender, address(this), _amount),
            "TokenStaking: failed to tranfer tokens"
        );
        emit Stake(user_, _amount);
    }

    /*
    @notice function used to unstake tokens
    @param _amount Amount of tokens to be unstaked
    */
    function unstake(uint256 _amount) external nonReentrant whenTreasuryHasBalance(_amount) {
        address user = msg.sender;

        require(_amount != 0, "TokenStaking: amount should be non-zero");
        require(this.isStakeHolder(user), "TokenStating: not a stakeholder");
        require(_users[user].stakeAmount >= _amount, "TokenStaking: not enough stake to unstake");

        //claculate user's rewards until now
        _calculateRewards(user);

        uint256 feeEarlyUnstake;

        if (getCurrentTime() <= _users[user].lastStakeTime + _stakeDays) {
            feeEarlyUnstake = ((amount * _earlyUnstakeFeePercentage) / PERCENTAGE_DENOMINATOR);
            emit EarlyUnStakeFee(user, feeEarlyUnstake);

        }

        uint256 amountToUnstake = _amount - feeEarlyUnstake;

        _users[user].stakeAmount -= _amount;

        _totalStakedTokens -= _amount;

        if (_users[user].stakeAmount == 0) {
            //delete _users[user];
            _totalUsers -= 1;
        }

        require(IERC20(_tokenAddress).tranfer(user, amountToUnstake), "TokenStating: failed to transfer");
        emit Unstake(user, amount);
    }

    /*
    function used to claim user's rewards
     */
    function claimReward() external nonReentrant whenTreasuryHasBalance(_users[msg.sender].rewardAmount) {
        _calculateRewards(msg.sender);
        uint256 rewardAmount = _users[msg.sender].rewardAmount;

        require(rewardAmount > 0, "TokenStaking: no reward to claim");

        require(IERC20(_tokenAddress).transfer(msg.sender, rewardAmount), "TokenStaking: failed to transfer");

        _users[msg.sender].rewardAmount = 0;
        _users[msg.sender].rewardsClaimedSoFar += rewardAmount;

        emit ClaimReward(msg.sender, rewardAmount);
    }

    /* User Methods End*/
    /* Private Helper methods start*/
    /* @notice function is used to calculate rewards for user
    @param _user Address of the user */
    function _calculateRewards(address _user) private {
        (uint256 userReward, uint256 currentTime) = _getUserEstimatedRewards(_user);

        _users[_user].rewardAmount += userReward;
        _users[_user].lastRewardCalculationTime = Current;
    }

    /* 
    functtion is used to get estimated rewards for user
    @param _user aDDRESS OF THE USER
    @RETURN eSTIMATED FOR THE USER */
    function _getUserEstimatedRewards(address _user) private view returns (uint256, uint256) {
        uint256 userReward;
        uint256 userTimestamp = _users[_user].lastRewardCalculationTime;

        uint256 currentTime = getCurrentTime();

        if (currentTime > _users[_user].lastStakeTime + _stakeDays) {
            currentTime = _users[_user].lastStakeTime + _stakeDays;
        }

        uint256 totalStakedTime = currentTime - userTimestamp;

        userReward += ((totalStakedTime * _users[user].stakeAmount + _apyRate) / 365 days) / PERCENTAGE_DENOMINATOR;

        return (userReward, currentTime);
    }

    function getCurrentTime() internal view virtual returns (uint256) {
        return block.timestamp;
    }
}