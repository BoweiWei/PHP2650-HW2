import numpy as np
import math
import os
import glob


def compute_corr(name):
    # return the matrix
    lines = np.loadtxt(name)
    corr = np.corrcoef(np.transpose(lines))
    fisherz = np.zeros(shape=(15, 15))
    for i in range(15):
        for j in range(15):
            if i == j:
                fisherz[i][j] = 0
            else:
                fisherz[i][j] = 1 / 2 * math.log((1 + corr[i][j]) / (1 - corr[i][j]))
    return fisherz


def compute_avg():
    sum = np.zeros(shape=(15, 15))
    for file in os.listdir("/Users/minielf/Desktop/Brown/spring2018/PHP2650/HW/HW2/brainD15"):
        if file.endswith(".txt"):
            fisherz = compute_corr(file)
            sum = np.add(sum, fisherz)
    avg = sum / 820
    return avg


def compute_var():
    avg = compute_avg()
    sum = np.zeros(shape=(15, 15))
    for file in os.listdir("/Users/minielf/Desktop/Brown/spring2018/PHP2650/HW/HW2/brainD15"):
        if file.endswith(".txt"):
            fisherz = compute_corr(file)
            sum = np.add(sum, np.subtract(fisherz, avg) ** 2)
    var = sum / 820
    print(var)
    return var


def compute_sorted_avg():
    sum_train = np.zeros(shape=(15, 15))
    sum_test = np.zeros(shape=(15, 15))
    cnt = 0
    for file in sorted(glob.glob('*.txt')):
        cnt += 1
        if cnt < 411:
            fisherz = compute_corr(file)
            sum_train = np.add(sum_train, fisherz)
        else:
            fisherz = compute_corr(file)
            sum_test = np.add(sum_test, fisherz)
    avg_train = sum_train / 820
    avg_test = sum_test / 820
    return avg_train, avg_test

def main():
    # avg = compute_var()
    # var = compute_var()
    # np.savetxt("Fn.csv", avg, delimiter=",")
    # np.savetxt("Fv.csv", var, delimiter=",")
    avg_train, avg_test = compute_sorted_avg()
    np.savetxt("Ftrain.csv", avg_train, delimiter=",")
    np.savetxt("Ftest.csv", avg_test, delimiter=",")




main()

