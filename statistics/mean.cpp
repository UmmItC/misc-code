#include <iostream>
#include <vector>

/* 
 * This function calculates the mean (average) of a vector of double values.
 * It sums all the values in the vector and divides by the number of elements.
 * 
 * Example:
 * Given the vector A = {5, 10, 15, 20, 25} with 5 elements,
 * The sum is: 5 + 10 + 15 + 20 + 25 = 75
 * The mean is: 75 / 5 = 15
 *
 * Note: If the input vector is empty, the function will return 0.0.
 */

double calculateMean(const std::vector<double>& data) {
    double sum = 0.0;
    for (double value : data) {
        sum += value;
    }
    return sum / data.size();
}

int main() {
    std::vector<double> data = {5.0, 10.0, 15.0, 20.0, 25.0};
    double mean = calculateMean(data);
    std::cout << "The mean is: " << mean << std::endl;
    return 0;
}
