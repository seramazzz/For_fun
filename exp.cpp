#include <iostream>

long long fast_pow(long long base, long long exp) {
    long long result = 1;
    while (exp > 0) {
        if (exp & 1)
            result *= base;
        base *= base;
        exp >>= 1;
    }
    return result;
}

int main() {
    long long base = 3, exp = 13;
    std::cout << base << "^" << exp << " = " << fast_pow(base, exp) << "\n";
    return 0;
}
