# Variables

* `train_x`, `train_y`, `test_y`, `test_y`, `train_subj` , `test_subj`, `features` and `labels` contain the data from the downloaded files.
* `train, and `test` merge the previous datasets for further analysis.
* `features` contains the names for the `train` dataset.
* `features2` contains the more descriptive names from the features_into.txt
* `meanStd` is a logical vector, use in subsetting of `combine_data` data.frame to get `extracted_data`
* `extracted_data` subsetting data from original data set using only mean and standard daviation data
* `labels` is a dataframe with the activity names from activity_labels.txt
* `all_data` merges `x_data`, `y_data` and `subject_data` in a big dataset.
* `independent_tidy_data` final tidy data set with average mean values for subject and activity.