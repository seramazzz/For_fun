#include <iostream>
#include <cmath>

// Babylonian method for square root - always impressed by Ancient civilisations (and ashamed of myself a bit) who were very clever people
// WikipediaL: https://en.wikipedia.org/wiki/YBC_7289
double babyloniansqrt(double x, int iterations = 10) {
    // Parameters:
    //   x: the number to find the square root of
    //   iterations: the number of refinement steps (default = 10), i.e. more iterations improve accuracy, but increase computation
    // Returns:
    //   Approximate value of sqrt(x)
    int y = static_cast<int>(std::round(std::sqrt(x)));
    double approx = y;

    for (int i = 0; i < iterations; ++i) {
        approx = (approx + x / approx) / 2.0;
    }
    return approx;
}

int main() {
    double x = 42.0;

    std::cout << "Square root of 42: " << std::sqrt(x) << std::endl;
    std::cout << "Square root of 42 if I were Babylonian: " << babyloniansqrt(x) << std::endl;

    return 0;
}