#include <iostream>

// Russian Multiplication
// double one number, halve the other, and add up those where halved is odd
int russian_multiply(int a, int b) {
    int result = 0;
    while (b > 0) {
        if (b % 2 == 1)
            result += a;
        a <<= 1;
        b >>= 1;
    }
    return result;
}

int main() {
    int a = 47, b = 42;
    std::cout << a << " × " << b << " = " << russian_multiply(a, b) << "\n";
    return 0;
}