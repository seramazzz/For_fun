#include <iostream>
#include <cmath>
#include <cstdlib>
#include <ctime>

// Egyptian
double egyptian_pi() {
    return std::pow(16.0 / 9.0, 2.0);
}

// Babylonian
// They used 3 + 1/8 = 3.125
double babylonian_pi() {
    return 3.125;
}

// Archimedes’ polygon method
double archimedes_pi_iter(int iterations = 10) {
    double sides = 6.0;   // Start with a hexagon
    double side_length = 1.0; // Chord length for unit circle (sin(pi/6) = 0.5)
    for (int i = 0; i < iterations; ++i) {
        // This formula updates the chord length for a polygon with double the sides...
        side_length = std::sqrt(2 - std::sqrt(4 - side_length * side_length));
        sides *= 2;
    }
    return (sides * side_length) / 2.0;
}

// Monte Carlo
double montecarlo_pi(int samples = 1000000) {
    int inside = 0;
    for (int i = 0; i < samples; ++i) {
        double x = static_cast<double>(rand()) / RAND_MAX;
        double y = static_cast<double>(rand()) / RAND_MAX;
        if (x * x + y * y <= 1.0)
            inside++;
    }
    return 4.0 * inside / samples;
}

// Gauss–Legendre algorithm
// converges insanely fast...
double gauss_legendre_pi(int iterations = 5) {
    double a = 1.0;
    double b = 1.0 / std::sqrt(2.0);
    double t = 0.25;
    double p = 1.0;

    for (int i = 0; i < iterations; ++i) {
        double nextA = (a + b) / 2.0;
        double nextB = std::sqrt(a * b);
        double nextT = t - p * std::pow(a - nextA, 2);
        a = nextA;
        b = nextB;
        t = nextT;
        p *= 2.0;
    }
    return std::pow(a + b, 2) / (4.0 * t);
}

int main() {
    std::cout << "Egyptian π ≈ " << egyptian_pi() << "\n";
    std::cout << "Babylonian π ≈ " << babylonian_pi() << "\n";
    std::cout << "Archimedes π ≈ " << archimedes_pi_iter(12) << ")\n";
    std::cout << "Monte Carlo π ≈ " << montecarlo_pi(1000000) << "\n";
    std::cout << "Gauss–Legendre π ≈ " << gauss_legendre_pi(5) << "\n";
    std::cout << "\nReal π = " << M_PI << "\n";

    return 0;
}