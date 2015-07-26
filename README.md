# Getting and Cleaning Data Course Project

The data for this project came from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

It is comprised of

 - test subjects
 
 - activity types
 
 - sensor data

For the sensor data we are only interested in the mean and standard deviation of the raw signals from the accelerometer and the gyroscope.  Computed signals have been discarded!

## R Files

get_data.R will download and extract the raw data sets.

run_analysis.R will clean and tidy the data.  It's output is a single table with all raw sensor data averaged by each activity and each subject.