pragma solidity ^0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';
import './TokenPaymentSplitter.sol';

contract MockPool is Ownable, TokenPaymentSplitter {
  using SafeERC20 for IERC20;

  constructor(
    address[] memory _payees,
    uint256[] memory _shares,
    address _paymentToken
  ) TokenPaymentSplitter(_payees, _shares, _paymentToken) {}

  function drainTo(address _transferTo, address _token) public onlyOwner {
    require(_token != paymentToken, 'MockPool: token to drain is payment token');
    uint256 balance = IERC20(_token).balanceOf(address(this));
    require(balance > 0, 'MockPool: token to drain balance is 0');
    IERC20(_token).safeTransfer(_transferTo, balance);
  }
}
