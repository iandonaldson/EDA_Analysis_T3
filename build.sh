#!/bin/bash

# Get the config path from the arguments
# build.sh takes only one parameter --configPath
# which is a path to a config file for running the analysis
# providing any other parameters will cause the script to fail.
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --configPath) configPath="$2"; shift ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

# Validate that the config path exists
if [ -z "$configPath" ]; then
    echo "Error: configPath not provided."
    exit 1
fi

# Check if the config file exists at the given path
if [ ! -f "$configPath" ]; then
    echo "Config file not found at $configPath. Checking in the config directory..."
    configFileName=$(basename "$configPath")
    configPath="config/$configFileName"
    if [ ! -f "$configPath" ]; then
        echo "Error: Config file not found at $configPath or in the config directory."
        exit 1
    fi
fi

# Print the config path 
echo "Using config file: $configPath"
# cat $configPath

# Create the output directory outside the repository and outside the code 
# directory where it resides
OUTPUT_DIR="../output"
mkdir -p "$OUTPUT_DIR"

# Execute the analysis workflow
# Uncomment one of the following options to select either RMarkdown or Quarto

# Option 1: Run an R Markdown (.Rmd) file using rmarkdown::render
# Rscript -e "rmarkdown::render('src/workflow.Rmd', params = list(configPath = '$configPath'))"

# Option 2: Run a Quarto (.qmd) document using quarto render
quarto render src/workflow.qmd --to html -P configPath="$configPath"
#
# Parameterization of quarto documents is buried in the documentation here:
# https://quarto.org/docs/computations/parameters.html
# The correct way is to pass values for parameters using the -P flag 
# (e.g. configPath="../config/config.yml" ); 
# these values will overwrite the default values of the same parameters provided
# in the yaml front-matter of the qmd document.
# Documentation can also be found at the command line interface using
# quarto --help and quarto render --help ; hrsOfFun not finding and reading this first.
# The default working directory for the render will be the dir of the qmd doc;
# however, this can be changed within the qmd doc itself using setwd().
# I have used this method in the example to maintain consistency with the rmd
# example (code is written as though the wd is the root dir of the repository)
# Whichever style you use, just make it clear what your decision is.
# One tool that may be useful during debug is to create and pass absolute paths
# that can be generated from relative paths using realpath
# CONFIG_PATH="$(realpath config/config.yml)"
# echo "Resolved config path: $CONFIG_PATH"


# Check the return code of the last execution
if [ $? -eq 0 ]; then
    echo "Analysis completed successfully."
else
    echo "Analysis failed."
    exit 1
fi

# Cleanup - by default, the html file will be saved to the same directory as 
# the workflow.Rmd/qmd
cp src/workflow.html ../output/.
# and an additional dir in case of qmd
[ -d "src/workflow_files" ] && cp -r src/workflow_files ../output

# Indicate success by creating a success file
touch "$OUTPUT_DIR/success"

echo "EDA_Analysis_T3 completed successfully."
