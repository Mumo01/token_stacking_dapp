// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
library Address {

    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }


    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
        ) internal returns (bytes memory) {
            return functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }


    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
        ) internal returns (bytes memory) {
            require(address(this).balance >= value, "Address: insufficient balance for call");
            require(isContract(target), "Address: call to non-contract");

            (bool success, bytes memory returndata) = target.call{value: value}(data);
            return verifyCallResult(success, returndata, errorMessage);
    }

    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
            return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    function functionStaticCall(
            address target,
            bytes memory data,
            string memory errorMessage
        ) internal view returns (bytes memory) {
            require(isContract(target), "Address: static call to non-contract");

            (bool success, bytes memory returndata) = target.staticcall(data);
            return verifyCallResult(success, returndata, errorMessage);
    }

    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
            return functionDelegateCall(target, data, "Addres: low-level delegate call failed");
    }

    function functionDelegateCall(
            address target,
            bytes memory data,
            string memory errorMessage
        ) internal returns (bytes memory){
            require(isContract(target), "Address: delegate call to non-contract");

            (bool success, bytes memory returndata) = target.delegatecall(data);
            return verifyCallResult(success, returndata, errorMessage);
    }

    function verifyCallResult(
            bool success,
            bytes memory returndata,
            string memory errorMessage
        ) internal pure returns (bytes memory) {
            if (success) {
                return returndata;
            } else {

                if (returndata.length > 0) {

                    assembly {
                        let returndata_size := mload(returndata)
                        revert(add(32, returndata), returndata_size)
                    }
                } else {
                    revert(errorMessage);
                }
            }
    }
}

pragma solidity ^0.8.9;
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

pragma solidity ^0.8.9;
interface IERC20 {

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount 
    ) external returns (bool);
}

pragma solidity ^0.8.9;
abstract contract Initializable {

    uint8 private _initialized;

    bool private _initializing;

    event Initialized(uint8 version);

    modifier initializer() {
        bool isTopLevelCall = !_initializing;
        require(
            isTopLevelCall && _initialized < 1 || (!Address.isContract(address(this)) && _initialized == 1),
            "Initializable: contract is already initialized"
        );
        _initialized = 1;
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(1);
        }
    }

    modifier reinitializer(uint8 version) {
        require(!_initializing && _initialized < version, "Initializable: contract is already initialized");
        _initialized = version;
        _initializing = true;
        _;
        _initializing = false;
        emit Initialized(version); 
    }

    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    function _disableInitializers() internal virtual {
        require(!_initializing, "Initializable: contract is initializing");
        if (_initialized < type(uint8).max) {
            _initialized = type(uint8).max;
            emit Initialized(type(uint8).max);
        }
    }
}

pragma solidity ^0.8.9;
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _transferOwnership(_msgSender());
    }

    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

pragma solidity ^0.8.9;
abstract contract ReentrancyGuard {

    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    modifier nonReentrant() {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        _status = _ENTERED;

        _;

        _status = _NOT_ENTERED;
    }
}

pragma solidity ^0.8.9;
contract Theblockchaincoders {
    string public name = "@theblockchaincoders";
    string public symbol = "TBC";
    string public standard = "theblockchaincoders v.0.1";
    uint256 public totalSupply;
    address public ownerOfContract;
    uint256 public _userId;

    uint256 constant initialSupply = 1000000 * (10**18);

    address[] public holderToken;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => TokenHolderInfo) public tokenHolderInfos;

    struct TokenHolderInfo {
        uint256 _tokenId;
        address _from;
        address _to;
        uint256 _totalToken;
        bool _tokenHolder; 
    }

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        ownerOfContract = msg.sender;
        balanceOf[msg.sender] = initialSupply;
        totalSupply = initialSupply;
    }

    function inc() internal {
        _userId++;
    }

    function transfer(address _to, uint256 _value)
        public returns (bool success)

    {
        require(balanceOf[msg.sender] >= _value);
        inc();

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        TokenHolderInfo storage tokenHolderInfo = tokenHolderInfos[_to];

        tokenHolderInfo._to = _to;
        tokenHolderInfo._from = msg.sender;
        tokenHolderInfo._totalToken = _value;
        tokenHolderInfo._tokenHolder = true;
        tokenHolderInfo._tokenId = _userId;

        holderToken.push(_to);

        emit Transfer(msg.sender, _to, _value);

        return true; 
    }

    function approve(address _spender, uint256 _value)
        public returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

    function getTokenHolderData(address _address)
    public view returns (
        uint256,
        address,
        address,
        uint256,
        bool
    )
    {
        return (
            tokenHolderInfos[_address]._tokenId,
            tokenHolderInfos[_address]._to,
            tokenHolderInfos[_address]._from,
            tokenHolderInfos[_address]._totalToken,
            tokenHolderInfos[_address]._tokenHolder
        );
    }

    function getTokenHolder() public view returns (address[] memory){
        return holderToken;
    }
}

pragma solidity ^0.8.9;
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

    /* @notice this function used to get the maximum staking token limit */
    function getMaxStakingTokenLimit() external view returns (uint256) {
        return _maxStakeTokenLimit;
    }
    
    /* @notice this function used to get the STAKING START DATE */
    function getStakeStartDate() external view returns (uint256) {
        return _stakeStartDate;
    }

    /* this function is used to get the staking end date for program */

    function getStakeEndDate() external view returns (uint256) {
        return _stakeEndDate;
    }

    /* This function is used to get the total no of tokens that are staked */

    function getTotalStakedTokens() external view returns (uint256) {
        return _totalStakedTokens;
    }


    /* function used to get the total no of users */
    function getTotalUsers() external view returns (uint256) {
        return _totalUsers;
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
    /* FUNCTION is used to update maximum staking amount */

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
            feeEarlyUnstake = ((_amount * _earlyUnstakeFeePercentage) / PERCENTAGE_DENOMINATOR);
            emit EarlyUnStakeFee(user, feeEarlyUnstake);

        }

        uint256 amountToUnstake = _amount - feeEarlyUnstake;

        _users[user].stakeAmount -= _amount;

        _totalStakedTokens -= _amount;

        if (_users[user].stakeAmount == 0) {
            //delete _users[user];
            _totalUsers -= 1;
        }

        require(IERC20(_tokenAddress).transfer(user, amountToUnstake), "TokenStating: failed to transfer");
        emit UnStake(user, _amount);
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
        _users[_user].lastRewardCalculationTime = currentTime;
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

        userReward += ((totalStakedTime * _users[_user].stakeAmount + _apyRate) / 365 days) / PERCENTAGE_DENOMINATOR;

        return (userReward, currentTime);
    }

    function getCurrentTime() internal view virtual returns (uint256) {
        return block.timestamp;
    }
}