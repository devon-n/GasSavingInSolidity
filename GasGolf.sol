// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract gasGolf {

	uint public total;

	/* Unoptimized */

	function sumIfEvenAndLessThan99(uint[] memory nums) external {
		for (uint i = 0; i < nums.length; i += 1) {
			bool isEven = nums[i] % 2 == 0;
			bool isLessThan99 = nums[i] < 99;
			if (isEven &&  isLessThan99) {
				total += nums[i];
			}
		}
	}

	/* Optimized */
	// 1. Use calldata instead of memory
	function sumIfEvenAndLessThan99Optimized(uint[] calldata nums) external {

		// 2. Copy state variable to memory (Memory is less expensive to read and write to)
		uint _total = total;
		// 3. Save nums.length in local variable to not calculate every for loop iteration
		uint length = nums.length;

		// 4. Loop increments ++i vs i += 1
		for (uint i = 0; i < length; ++i) {
			// 5. Store nums[i] in local variable (Similar to 3)
			uint num = nums[i];

			// 6. Compute ifs in for loop to save the second if running when first if == negative
			if (num % 2 == 0 &&  num < 99) {
				_total += num;
			}
		}
		total = _total;
	}
}