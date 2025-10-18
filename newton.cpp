#include <iostream>
#include <cmath>
#include <functional>

double newton_sqrt(double x, int iterations = 10) {
    double guess = x / 2.0;
    for (int i = 0; i < iterations; ++i)
        guess = 0.5 * (guess + x / guess);
    return guess;
}

double newton_cuberoot(double x, int iterations = 10) {
    double y = x / 3.0;
    for (int i = 0; i < iterations; ++i)
        y = y - (y * y * y - x) / (3 * y * y);
    return y;
}

double numerical_derivative_forward(const std::function<double(double)> &f,
                                    double x, double h = 1e-6) {
    return (f(x + h) - f(x)) / h;
}

double numerical_derivative_central(const std::function<double(double)> &f,
                                    double x, double h = 1e-6) {
    return (f(x + h) - f(x - h)) / (2 * h);
}

// Generic Newton solver
double newton_general(const std::function<double(double)> &f,
                      double initial_guess,
                      int iterations = 10,
                      double h = 1e-6,
                      bool use_central = true) {
    double x = initial_guess;
    for (int i = 0; i < iterations; ++i) {
        double fval = f(x);
        double deriv = use_central
                           ? numerical_derivative_central(f, x, h)
                           : numerical_derivative_forward(f, x, h);

        if (std::abs(deriv) < 1e-12) {
            std::cerr << "Derivative too small, stopping early.\n";
            break;
        }

        x = x - fval / deriv;
    }
    return x;
}

int main() {
    std::cout << std::fixed;
    std::cout.precision(10);

    double x = 42.0;
    std::cout << "Newton sqrt(" << x << ") = " << newton_sqrt(x, 100) << "\n";
    std::cout << "Newton cuberoot(" << x << ") = " << newton_cuberoot(x, 100) << "\n";


    auto f1 = [](double x) { return x * x - 42.0; };
    double root1 = newton_general(f1, 6.0);
    std::cout << "42 ≈ " << root1 << " (true: " << std::sqrt(42.0) << ")\n";

    auto f2 = [](double x) { return x * x * x - 42.0; };
    double root2 = newton_general(f2, 3.0);
    std::cout << "42 ≈ " << root2 << " (true: " << std::cbrt(42.0) << ")\n";

    auto f3 = [](double x) { return std::sin(x); };
    double root3 = newton_general(f3, 3.0);
    std::cout << "sin(x)=0 near 3 ⇒ x ≈ " << root3 << " (true: " << M_PI << ")\n";

    auto f4 = [](double x) { return std::cos(x) - x; };
    double root4 = newton_general(f4, 1.0);
    std::cout << "cos(x)=x ⇒ x ≈ " << root4 << "\n";

    return 0;
}
