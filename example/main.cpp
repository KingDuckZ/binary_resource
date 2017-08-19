#include "main_src.hpp"
#include <iostream>
#include <string>

int main() {
	std::cout << "size: " << main_src_len << '\n';
	std::string out_str(reinterpret_cast<const char*>(main_src), main_src_len);
	std::cout << out_str << '\n';
	return 0;
}
