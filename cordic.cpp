#include <iostream>
#include <cmath>

// CORDIC Algorithm
void cordic(double theta, int iterations, double &cosOut, double &sinOut) {
    double x = 1.0, y = 0.0;
    static const double angles[] = {
        0.7853981633974483, 0.4636476090008061, 0.24497866312686414,
        0.12435499454676144, 0.06241880999595735, 0.031239833430268277,
        0.015623728620476831, 0.007812341060101111, 0.0039062301319669718,
        0.0019531225164788198, 0.0009765621895593195
    };

    for (int i = 0; i < iterations; ++i) {
        double factor = std::pow(2.0, -i);
        double x_new, y_new;

        if (theta >= 0) {
            x_new = x - y * factor;
            y_new = y + x * factor;
            theta -= angles[i];
        } else {
            x_new = x + y * factor;
            y_new = y - x * factor;
            theta += angles[i];
        }

        x = x_new;
        y = y_new;
    }

    const double K = 0.6072529350088814; // converges quickly for >10 iterations with this correction
    cosOut = x * K;
    sinOut = y * K;
}

int main() {
    double theta = M_PI / 6; // ie 30 degrees
    double c, s;
    cordic(theta, 15, c, s);
    std::cout << "CORDIC cos(30 degrees) ≈ " << c << ", sin(30 degrees) ≈ " << s << "\n";
    std::cout << "std::cos(30 degrees) = " << std::cos(theta)
              << ", std::sin(30 degrees) = " << std::sin(theta) << "\n";
    return 0;
}